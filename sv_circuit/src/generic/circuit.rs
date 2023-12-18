use std::collections::hash_map::RandomState;
use std::collections::{HashMap, HashSet};
use std::fmt::Debug;
use std::fs::File;
use std::io::Write;

use counter::Counter;
use itertools::Itertools;
use mcircuit::parsers::blif::BlifCircuitDesc;
use mcircuit::{Gate, HasIO, Identity, Operation, WireValue};
use petgraph::algo::toposort;
use petgraph::dot::Dot;
use petgraph::graph::NodeIndex;
use petgraph::prelude::StableDiGraph;
use petgraph::visit::Topo;
use petgraph::Direction;
use serde::{Serialize, Serializer};

use crate::generic;
use crate::generic::{ModId, NodeIdx, SVCircuitError, SubCircuitDesc, Wire};

/// A circuit model that can support gates of arbitrary type
pub struct GenericCircuit<T: WireValue> {
    /// Name of this circuit
    pub name: String,
    /// Underlying graph representation of the circuit that connects gates (nodes) with wires (edges)
    pub graph: StableDiGraph<Operation<T>, ()>,
    /// Subcircuit descriptors, used by hierarchical circuits
    pub subcircuits: Vec<SubCircuitDesc>,
    /// IDs of the input wires
    pub inputs: HashSet<Wire>,
    /// IDs of the output wires
    pub outputs: HashSet<Wire>,
    /// Maps wires to the gates that write to them
    pub _gate_outputs: HashMap<Wire, NodeIdx>,
    /// IDs of wires that will be driven by subcircuits
    pub _subcircuit_outputs: HashSet<Wire>,
    /// Maps wires in the local domain to wires in the global domain
    pub remappings: HashMap<Wire, Wire>,
    /// Whether or not all the wires from the pending_wires list have been processed
    pub built: bool,
    /// Whether or not this circuit contains subcircuits
    pub flat: bool,
    /// Unique ID for this circuit. Captures parent information
    pub id: ModId,
}

impl<T: WireValue> Default for GenericCircuit<T> {
    fn default() -> Self {
        GenericCircuit {
            name: String::new(),
            graph: StableDiGraph::new(),
            subcircuits: Vec::new(),
            inputs: HashSet::new(),
            outputs: HashSet::new(),
            _gate_outputs: HashMap::new(),
            _subcircuit_outputs: HashSet::new(),
            remappings: HashMap::new(),
            built: false,
            flat: true,
            id: ModId::new(0),
        }
    }
}

impl<T: Debug + WireValue> GenericCircuit<T>
where
    Operation<T>: Identity<T>,
{
    /// Adds a buffer gate between parent and child wires. In the future, could make more efficient
    /// by rewriting edges directly.
    fn splice(&mut self, parent: &Wire, child: &Wire) -> Result<(), SVCircuitError> {
        self._add_gate(Operation::identity(*child, *parent))?;
        Ok(())
    }

    /// Iterates over all gates and replaces random 64-bit wire IDs with sequential ones. This is
    /// necessary to prevent Reverie from having to use a hashmap for mapping wire IDs to values.
    /// A HashMap would use up substantially more RAM than the existing flat memory layout.
    pub fn minimize_wires(&mut self) {
        assert!(self.built);

        let mut translations: HashMap<Wire, Wire> = HashMap::new();
        let mut frozen: HashSet<Wire> = HashSet::new();

        // Fix the input and output symbols
        frozen.extend(self.inputs.iter());
        frozen.extend(self.outputs.iter());

        // Start at one above the number of fixed wires
        let mut counter: usize = frozen.iter().max().unwrap_or(&0) + 1;
        for idx in self.topo_indices().iter() {
            // Grab the next node
            let node = self.graph.node_weight(*idx).unwrap();

            // Iterate over the wires. If we haven't seen a wire before, increment `counter` to get
            // a new ID for it.
            for w in node.inputs().chain(node.outputs()) {
                if !translations.contains_key(&w) && !frozen.contains(&w) {
                    translations.insert(w, counter);
                    self.remappings.insert(w, counter);
                    counter += 1;
                }
            }

            // Replace the gate with the translated version. Does NOT update edge weights, since we
            // don't use those directly.
            self.graph[*idx] =
                generic::translate_gate::<T>(&self.graph[*idx], &translations, Some(&frozen));
        }
    }

    /// Increment every wire index in the circuit by the provided amount. Useful for moving two minimized
    /// circuits into the same namespace without producing index collisions.
    pub fn increment_wires(&mut self, increment: Wire) {
        assert!(self.built);

        let mut translations: HashMap<Wire, Wire> = HashMap::new();

        for idx in self.topo_indices().iter() {
            // Grab the next node
            let node = self.graph.node_weight(*idx).unwrap();

            // Iterate over the wires and remap wires to higher indices
            for w in node.inputs().chain(node.outputs()) {
                if let std::collections::hash_map::Entry::Vacant(e) = translations.entry(w) {
                    let incremented = w + increment;
                    e.insert(incremented);
                    self.remappings.insert(w, incremented);
                }
            }

            // Replace the gate with the translated version. Does NOT update edge weights, since we
            // don't use those directly.
            self.graph[*idx] = generic::translate_gate::<T>(&self.graph[*idx], &translations, None);
        }
        //
        // for idx in 0..self.inputs.len(){
        //     self.inputs[idx] += increment;
        // }
        // for idx in 0..self.outputs.len(){
        //     self.outputs[idx] += increment;
        // }
    }

    /// Removes unnecessary buffer gates.
    pub fn prune(&mut self) -> usize {
        assert!(self.built);

        let mut removed: usize = 0;
        let mut topo = Topo::new(&self.graph);
        // Iterate over every node (gate) in the underlying graph
        while let Some(idx) = topo.next(&self.graph) {
            let node = self
                .graph
                .node_weight(idx)
                .expect("Node removed before visiting");

            // Operation::AddConst(out, a, _b)
            if node.is_identity() {
                let out = node.dst().unwrap();
                let src = node.inputs().next().unwrap();

                // Get all the wires that write to this buffer (there should only be one)
                let sources: Vec<NodeIndex> = self
                    .graph
                    .neighbors_directed(idx, Direction::Incoming)
                    .collect();
                // Get all the wires that read from this buffer (there is usually only one, but
                // can be many
                let sinks: Vec<NodeIndex> = self
                    .graph
                    .neighbors_directed(idx, Direction::Outgoing)
                    .collect();

                // Adding more gates after
                // If this node has sinks, it'll be removed, so we should remove it from _pending_inputs
                // if !sinks.is_empty() {
                //     if self._pending_inputs.contains_key(&a) {
                //         self._pending_inputs
                //             .get_mut(&a)
                //             .unwrap()
                //             .retain(|id| idx.index() != *id);
                //     }
                // }

                // On all the gates that read from this buffer, update their wires to instead
                // read from this buffer's source. We shouldn't do this in the opposite
                // direction because this buffer gate might not be the only gate that reads from
                // its input wires.
                for neighbor in sinks.iter() {
                    self.graph[*neighbor] = generic::translate_gate::<T>(
                        &self.graph[*neighbor],
                        &hashmap! {
                             out => src,
                        },
                        None,
                    );
                }

                // Warn if this buffer maps an output to an output. I don't think it breaks
                // anything, but it's weird.
                if self.outputs.contains(&out) && self.outputs.contains(&src) {
                    log::debug!("Instruction: BUF {src} --> {out} maps an output to an output");
                }

                // If this buffer doesn't connect to any gates, it probably transparently maps
                // an input to an output, so we should leave it in.
                if sinks.is_empty() && sources.is_empty() {
                    // Unless of course it doesn't, in which case we can remove it.
                    if !self.outputs.contains(&out) || !self.inputs.contains(&src) {
                        self.graph.remove_node(idx);
                        removed += 1;
                    }
                }
                // If it has inputs, but no outputs, then it's probably connected to an output wire.
                else if sinks.is_empty() {
                    if !self.outputs.contains(&out) {
                        // Unless of course it's not, in which case we can remove it. We do,
                        // however, need to remap its source wires just in case.
                        for source in sources.iter() {
                            self.graph[*source] = generic::translate_gate::<T>(
                                &self.graph[*source],
                                &hashmap! {
                                     out => src,
                                },
                                None,
                            );
                        }

                        self.graph.remove_node(idx);
                        removed += 1;
                    }
                }
                // If it has outputs, but no inputs, then we're reading directly from an input
                // wire.
                else if sources.is_empty() {
                    // We've already overwritten the wires on the sinks, so we can just delete
                    // this node
                    self.graph.remove_node(idx);
                    removed += 1;
                }
                // Most of the time we'll have a source AND sinks, so when we remove the node,
                // We'll need to create new edges that map directly between those gates.
                else {
                    // We do need to make sure this wire isn't being used by an IO port, since
                    // we can't rewrite those
                    if !self.outputs.contains(&out) && !self.inputs.contains(&src) {
                        self.graph.remove_node(idx);
                        removed += 1;
                        for source in sources.iter() {
                            for sink in sinks.iter() {
                                self.graph.add_edge(*source, *sink, ());
                            }
                        }
                    }
                }
            }
        }
        removed
    }

    /// Replaces arithmetic nodes with const inputs with the Const variant of the node
    pub fn curry(&mut self) -> usize {
        assert!(self.built);

        let mut removed: usize = 0;
        let mut topo = Topo::new(&self.graph);
        // Iterate over every node (gate) in the underlying graph
        while let Some(idx) = topo.next(&self.graph) {
            let node = self.graph.node_weight(idx).unwrap();
            if let Operation::Const(out, val) = *node {
                // Get all the gates that this gate drives
                let sinks: Vec<NodeIndex> = self
                    .graph
                    .neighbors_directed(idx, Direction::Outgoing)
                    .collect();

                for neighbor in sinks.iter() {
                    let remove_edge = match self.graph.node_weight_mut(*neighbor) {
                        Some(neighbor_node) => match neighbor_node {
                            Operation::Add(next_out, next_in, const_in) if *const_in == out => {
                                *neighbor_node = Operation::AddConst(*next_out, *next_in, val);
                                true
                            }
                            Operation::Add(next_out, const_in, next_in) if *const_in == out => {
                                *neighbor_node = Operation::AddConst(*next_out, *next_in, val);
                                true
                            }
                            Operation::Sub(next_out, next_in, const_in) if *const_in == out => {
                                *neighbor_node = Operation::SubConst(*next_out, *next_in, val);
                                true
                            }
                            Operation::Sub(next_out, const_in, next_in) if *const_in == out => {
                                *neighbor_node = Operation::SubConst(*next_out, *next_in, val);
                                true
                            }
                            Operation::Mul(next_out, next_in, const_in) if *const_in == out => {
                                *neighbor_node = Operation::MulConst(*next_out, *next_in, val);
                                true
                            }
                            Operation::Mul(next_out, const_in, next_in) if *const_in == out => {
                                *neighbor_node = Operation::MulConst(*next_out, *next_in, val);
                                true
                            }
                            _ => false,
                        },
                        None => {
                            continue;
                        }
                    };
                    if remove_edge {
                        match self.graph.find_edge(idx, *neighbor) {
                            None => {}
                            Some(edge) => {
                                self.graph.remove_edge(edge);
                            }
                        }
                    }
                }

                let sinks_count = self
                    .graph
                    .neighbors_directed(idx, Direction::Outgoing)
                    .count();
                if sinks_count == 0 && !self.outputs.contains(&out) {
                    self.graph.remove_node(idx);
                    removed += 1
                }
            }
        }
        removed
    }

    /// Given the specifications for the necessary subcircuits, produces a flattened representation
    /// of this circuit.
    /// * `library` - HashMap mapping subcircuit names (String) to circuits (GenericCircuit<T>)
    pub fn merge(
        &mut self,
        library: &HashMap<String, GenericCircuit<T>>,
    ) -> Result<Self, SVCircuitError> {
        // Create a new circuit that will hold the flattened version
        let mut merged = GenericCircuit {
            name: self.name.clone(),
            inputs: self.inputs.clone(),
            outputs: self.outputs.clone(),
            id: self.id.clone(),
            ..Default::default()
        };

        let mut io = merged.inputs.clone();
        io.extend(merged.outputs.clone());

        // Copy all the gates from `self` into `merged`
        for idx in self.graph.node_indices() {
            // We don't have a topological ordering yet
            let gate = self.graph.node_weight(idx).unwrap();
            let (localized, remappings) = generic::localize_gate::<T>(&merged.id, gate, Some(&io));
            // Add the wires we just remapped into merged's map of wire remappings
            merged.remappings.extend(remappings);
            merged._add_gate(localized)?;
        }

        // Print a debug message with the subcircuits we're merging into this one
        let submod_counts = self
            .subcircuits
            .iter()
            .map(|i| &i.name)
            .collect::<Counter<_>>();
        for (subcircuit, frequency) in submod_counts.most_common_ordered() {
            log::debug!("{}: merge {frequency}x {subcircuit}(s)", self.name);
        }

        // Iterate over all the subcircuit descriptors
        for desc in self.subcircuits.iter() {
            // Get a copy of the subcircuit specificied by the current descriptor
            let other = match library.get(&desc.name) {
                None => {
                    return Err(SVCircuitError::MissingDependency {
                        dependency: desc.name.clone(),
                        parent: self.name.clone(),
                    });
                }
                Some(other) => other,
            };

            // We need the other circuit to be flat, which should be guaranteed by the topological
            // ordering.
            if !other.flat {
                return Err(SVCircuitError::NonTopo);
            }

            let mut other_localizations: HashMap<Wire, Wire> = HashMap::new();

            // Localize all the gates from the other circuit into merged's unique namespace. Add the
            // localized gates to `merged` and store the remappings as well.
            for gate_idx in other.topo_indices().iter().rev() {
                let gate = other.graph.node_weight(*gate_idx).unwrap();
                let (localized, remappings) = generic::localize_gate::<T>(&desc.id, gate, None);
                other_localizations.extend(remappings);
                merged._add_gate(localized)?;
            }

            let mut splice_pairs: Vec<(Wire, Wire)> = Vec::new();

            // Connect the wires from the parent circuit to the input wires of the subcircuit. The
            // wire IDs in the mapping are given in the local namespaces for each circuit, so we
            // need to localize them to what's actually present on the gates right now.
            for (parent_local, child_local) in desc.inputs.iter() {
                // First, we get the localized wire in the parent circuit's namespace.
                // If we've already remapped this wire ID in merged, we should use the remapped version
                let parent: usize = *merged.remappings.get(parent_local).unwrap_or(
                    // If we haven't already remapped the parent wire, that means it must be an
                    // IO port without any gates connected to it. We need to preserve the interface
                    // for the parent module, so we won't remap it.
                    parent_local,
                );

                // If for some reason we're trying to connect to a child wire that's not explicitly
                // part of the input specification, that wil probably cause problems that I don't
                // want to think about. It's valid in Verilog, but easy enough to avoid writing, so
                // we explicitly disallow it here to keep things simple.
                if !other.inputs.contains(child_local) {
                    return Err(SVCircuitError::EncapsulationViolation {
                        dependency: desc.name.clone(),
                        parent: self.name.clone(),
                        wire: *child_local,
                    });
                }

                // Now we get the localized wire in the child circuit's namespace
                let child: &usize = match other_localizations.get(child_local) {
                    // If the child wire hasn't been remapped (ie no gates connect to it) then we're
                    // not using the input for anything. It's fairly common for our circuits to not
                    // use all of their inputs, so we can ignore this.
                    None => {
                        // #[cfg(debug_assertions)]
                        // {
                        //     let mut missing: HashSet<Wire> = HashSet::new();
                        //     for i in other.inputs.iter() {
                        //         if !other_localizations.contains_key(i) {
                        //             missing.insert(*i);
                        //         }
                        //     }
                        //     elog::debug!(
                        //         "Warning: subcircuit {} drops {} bits of input: {:?}",
                        //         desc.name,
                        //         missing.len(),
                        //         missing
                        //     );
                        // }
                        continue;
                    }
                    // If we've remapped this child wire, we'll return the remapped version
                    Some(remapped) => remapped,
                };
                // We'll save this pair of wires to connect later
                splice_pairs.push((parent, *child));
            }

            // Now we connect the outputs of the subcircuit to the wires of the parent circuit
            for (parent_local, child_local) in desc.outputs.iter() {
                // First, we get the localized wire in the parent circuit's namespace.
                // As above, if we're connecting to a remapped wire, we use the remapped version.
                // Otherwise, if we haven't already remapped the parent wire,
                // that means it must be an IO port without any gates connected to it. So, once
                // again, we don't remap in this case because we need to preserve the interface.
                let parent: usize = *merged.remappings.get(parent_local).unwrap_or(parent_local);

                // Once again, we assert that we're not trying to connect to any wires that aren't
                // specified to be part of the interface
                if !other.outputs.contains(child_local) {
                    return Err(SVCircuitError::EncapsulationViolation {
                        dependency: desc.name.clone(),
                        parent: self.name.clone(),
                        wire: *child_local,
                    });
                }

                // Now we get the localized wire in the child circuit's namespace
                let child: usize = match other_localizations.get(child_local) {
                    // If the child doesn't drive an output, that's a big problem, because something
                    // might want to read from those output bits. We figure out which bits we're
                    // missing, then bail out.
                    None => {
                        let mut missing: HashSet<Wire> = HashSet::new();
                        for i in other.outputs.iter() {
                            if !other_localizations.contains_key(i) {
                                missing.insert(*i);
                            }
                        }
                        return Err(SVCircuitError::UndrivenOutput {
                            name: desc.name.clone(),
                            wires: missing.into_iter().sorted().collect(),
                        });
                    }
                    // If the circuit is okay, we should have some gate that drives this output.
                    // We'll retrieve the remapped wire ID.
                    Some(remapped) => *remapped,
                };
                splice_pairs.push((child, parent));
            }

            // Now, we'll go ahead and splice together the interface wires between the parent and
            // the subcircuits. We do this all at once, but might get slightly lower memory usage
            // if we did it repeatedly along the way.
            for (parent, child) in splice_pairs.drain(..) {
                merged.splice(&parent, &child)?;
            }
        }

        log::debug!("Adding missing wires...");
        // We call the `build` operation, which is necessary to make the edges in our underlying
        // graph (assuming the gates weren't already topologically sorted)
        let num_wires = merged._build()?;
        log::debug!("Created {} wires", num_wires);
        // We undo the remappings on any IO wires for this subcircuit
        // We attempt to squash the buffer gates that we used to connect the parent circuits to
        // the subcircuits
        log::debug!("Squashing extra buffer gates");
        let num_pruned_buffers = merged.prune();
        log::debug!("Removed {} buffers", num_pruned_buffers);

        log::debug!("Currying constant gates");
        let num_constant_gates_removed = merged.curry();
        log::debug!("Removed {} constant gates", num_constant_gates_removed);

        Ok(merged)
    }

    /// Get a topological sorting of the gate indices in this circuit. This could probably be an
    /// iterator, as it's not directly consumed by PyO3
    pub fn topo_indices(&self) -> Vec<NodeIndex> {
        assert!(self.built);
        match toposort(&self.graph, None) {
            Ok(indices) => indices,
            Err(cycle) => panic!(
                "Can't get a topological ordering - there's a cycle in this circuit: {:?}",
                cycle
            ),
        }
    }

    /// Add the _description_ of a subcircuit to this circuit. Does not take the subcircuit model,
    /// only its name and a set of mappings detailing how to connect the inputs and outputs of the
    /// subcircuit. The mappings are Vecs of tuples (Wire, Wire), where the first wire is the ID
    /// of the wire in the parent's local namespace, and the second wire is the ID of the connected
    /// wire in the subcircuit's local namespace.
    pub fn add_subcircuit(
        &mut self,
        name: String,
        inputs: Vec<(Wire, Wire)>,
        outputs: Vec<(Wire, Wire)>,
    ) {
        self.flat = false;
        for (parent, _child) in outputs.iter() {
            self._subcircuit_outputs.insert(*parent);
        }
        self.subcircuits.push(SubCircuitDesc {
            name,
            inputs,
            outputs,
            id: ModId::new(self.id.own),
        });
    }

    /// Get the number of gates used in this circuit
    pub fn ngate(&self) -> usize {
        self.graph.node_count()
    }

    /// Get the number of edges used by the graph of this circuit, which should give the wire count
    /// minus the inputs and outputs
    pub fn nwire(&self) -> usize {
        let mut max_wire: usize = 0;
        for input in self.inputs.iter() {
            if *input > max_wire {
                max_wire = *input;
            }
        }
        for gate in self.topo_iter() {
            for i in gate.inputs().chain(gate.outputs()) {
                if i > max_wire {
                    max_wire = i;
                }
            }
        }

        for output in self.outputs.iter() {
            if *output > max_wire {
                max_wire = *output;
            }
        }

        log::warn!(
            "Expected max_wire was {}, actual was {}",
            self.graph.edge_count() + self.inputs.len() + self.outputs.len(),
            max_wire
        );
        max_wire
    }

    /// Produce a dotfile of the graph underlying this circuit, for debugging purposes.
    pub fn dotfile(&self, filename: &str) -> std::io::Result<()> {
        let mut f = File::create(filename)?;
        let output = format!("{:?}", Dot::with_config(&self.graph, &[]));
        f.write_all(output.as_bytes())?;
        Ok(())
    }

    pub fn prettyprint(&self) -> String {
        format!("{:#?}", self.graph)
    }

    pub fn topo_iter(&self) -> TopoGateIter<T> {
        TopoGateIter::new(self)
    }

    /// Add a gate to the circuit
    pub(crate) fn _add_gate(&mut self, gate: Operation<T>) -> Result<NodeIdx, SVCircuitError> {
        self.built = false;

        // Add the gate to the graph, and mark that it doesn't have its inputs satisfied yet
        let idx = self.graph.add_node(gate).index();

        if let Some(output) = gate.dst() {
            // Mark which outputs this gate satisfies
            if self._gate_outputs.contains_key(&output)
                || self._subcircuit_outputs.contains(&output)
                || self.inputs.contains(&output)
            {
                return Err(SVCircuitError::DriveConflict { wire: output });
            }
            self._gate_outputs.insert(output, idx);
        }
        Ok(idx)
    }

    /// Retrive a gate using its node index in the underlying graph
    fn _get_gate(&self, idx: NodeIdx) -> Option<&Operation<T>> {
        self.graph.node_weight(NodeIndex::new(idx))
    }

    /// Create all the pending edges in the underlying graph, necessary to correctly retrieve most
    /// other information about the circuit
    pub(crate) fn _build(&mut self) -> Result<usize, SVCircuitError> {
        if self.built {
            return Ok(0);
        }
        let mut edges_added = 0;

        let indices: Vec<NodeIndex> = self.graph.node_indices().collect();

        for idx in indices {
            let inputs: Vec<Wire> = self.graph.node_weight(idx).unwrap().inputs().collect();
            for input in inputs {
                let driver = match self._gate_outputs.get(&input) {
                    // if this wire isn't driven by a gate, that could be bad
                    None => {
                        // If it's driven by an input or a subcircuit, that's okay though
                        if self.inputs.contains(&input) || self._subcircuit_outputs.contains(&input)
                        {
                            continue;
                        }
                        // Otherwise, this gate is missing inputs, and we need that to be fixed before we can proceed
                        return Err(SVCircuitError::UndrivenGate {
                            parent: self.name.clone(),
                            gate_index: idx.index(),
                            wire: input,
                        });
                    }
                    Some(n) => *n,
                };
                // If we've gotten here, then this wire is driven by another gate, so we should make sure there's an edge between them
                let new_idx = NodeIndex::new(driver);
                if !self.graph.contains_edge(new_idx, idx) {
                    self.graph.add_edge(new_idx, idx, ());
                    edges_added += 1;
                }
            }
        }

        self.built = true;
        Ok(edges_added)
    }

    /// Provide the set of input wires to this circuit
    fn _set_inputs(&mut self, inputs: &HashSet<usize, RandomState>) {
        self.inputs.clear();
        self.inputs.extend(inputs.iter());
    }

    /// Provide the set of output wires from this circuit
    fn _set_outputs(&mut self, outputs: &HashSet<usize, RandomState>) {
        self.outputs.clear();
        self.outputs.extend(outputs.iter());
    }

    pub fn gate_count(&self) -> HashMap<&str, usize> {
        let mut counts = HashMap::new();

        for gate in self.topo_iter() {
            // There must be a way to do this dynamically, but we probably want to add variant
            // names to mcircuit
            match gate {
                Operation::Input(_) => {
                    *counts.entry("Input").or_insert(0) += 1;
                }
                Operation::Random(_) => {
                    *counts.entry("Random").or_insert(0) += 1;
                }
                Operation::Add(_, _, _) => {
                    *counts.entry("Add").or_insert(0) += 1;
                }
                Operation::AddConst(_, _, _) => {
                    *counts.entry("AddConst").or_insert(0) += 1;
                }
                Operation::Sub(_, _, _) => {
                    *counts.entry("Sub").or_insert(0) += 1;
                }
                Operation::SubConst(_, _, _) => {
                    *counts.entry("SubConst").or_insert(0) += 1;
                }
                Operation::Mul(_, _, _) => {
                    *counts.entry("Mul").or_insert(0) += 1;
                }
                Operation::MulConst(_, _, _) => {
                    *counts.entry("MulConst").or_insert(0) += 1;
                }
                Operation::AssertZero(_) => {
                    *counts.entry("AssertZero").or_insert(0) += 1;
                }
                Operation::Const(_, _) => {
                    *counts.entry("Const").or_insert(0) += 1;
                }
            }
        }

        counts
    }
}

impl<T: WireValue> Serialize for GenericCircuit<T>
where
    Operation<T>: Gate<T>,
{
    fn serialize<S>(&self, serializer: S) -> Result<<S as Serializer>::Ok, <S as Serializer>::Error>
    where
        S: Serializer,
    {
        serializer.collect_seq(self.into_iter())
    }
}

pub struct TopoGateIter<'a, T: WireValue> {
    ordering: Vec<NodeIndex>,
    circuit: &'a GenericCircuit<T>,
    idx: usize,
}

impl<'a, T: WireValue> TopoGateIter<'a, T> {
    fn new(circuit: &'a GenericCircuit<T>) -> Self {
        let ordering: Vec<NodeIndex> = toposort(&circuit.graph, None).unwrap();
        TopoGateIter {
            ordering,
            circuit,
            idx: 0,
        }
    }
}

impl<'a, T: WireValue> Iterator for TopoGateIter<'a, T>
where
    Operation<T>: Identity<T>,
{
    type Item = &'a Operation<T>;

    fn next(&mut self) -> Option<Self::Item> {
        if self.idx < self.ordering.len() {
            self.idx += 1;
            self.circuit._get_gate(self.ordering[self.idx - 1].index())
        } else {
            None
        }
    }

    fn size_hint(&self) -> (usize, Option<usize>) {
        self.ordering.iter().size_hint()
    }
}

/// Lets us easily retrieve an iterator w/ the canonical way of serializing this circuit into
/// a series of gates.
impl<'a, T: 'a + WireValue> IntoIterator for &'a GenericCircuit<T>
where
    Operation<T>: Identity<T>,
{
    type Item = Operation<T>;
    type IntoIter = impl Iterator<Item = Self::Item>;

    fn into_iter(self) -> Self::IntoIter {
        self.inputs
            .iter()
            .cloned()
            .sorted()
            .map(|i| Operation::Input(i))
            .chain(self.topo_iter().cloned())
            .chain(
                self.outputs
                    .iter()
                    .sorted()
                    .map(|o| Operation::AssertZero(*o)),
            )
    }
}

impl<T: WireValue> From<BlifCircuitDesc<T>> for GenericCircuit<T>
where
    Operation<T>: Identity<T>,
{
    fn from(mut desc: BlifCircuitDesc<T>) -> Self {
        let mut circuit = GenericCircuit::<T> {
            name: desc.name,
            ..Default::default()
        };
        circuit.inputs.extend(desc.inputs.drain(..));
        circuit.outputs.extend(desc.outputs.drain(..));
        for gate in desc.gates.drain(..) {
            circuit._add_gate(gate).unwrap();
        }
        circuit
    }
}

#[cfg(test)]
mod tests {
    use crate::{GenericCircuit, SVCircuitError};
    use mcircuit::Operation;
    use std::collections::{HashMap, HashSet};
    use std::iter::FromIterator;

    #[test]
    fn test_minimize_indices() -> Result<(), SVCircuitError> {
        // When we eventually move away from reserving the 1/0 wires, this test
        // (and any any others that use minimize_indices) are expected to break.

        let mut circuit: GenericCircuit<bool> = GenericCircuit::default();
        circuit._set_inputs(&HashSet::from_iter([3, 2]));
        circuit._add_gate(Operation::Const(1, true))?;
        circuit._add_gate(Operation::Add(12, 1, 3))?;
        circuit._add_gate(Operation::Mul(8, 12, 2))?;
        circuit._build().expect("Failed to build circuit");

        circuit.minimize_wires();

        let minimized: Vec<Operation<bool>> = circuit.topo_iter().cloned().collect();

        assert_eq!(
            minimized,
            vec![
                Operation::Const(4, true),
                Operation::Add(5, 4, 3),
                Operation::Mul(6, 5, 2)
            ]
        );

        Ok(())
    }

    #[test]
    fn test_prune() -> Result<(), SVCircuitError> {
        let mut circuit: GenericCircuit<bool> = GenericCircuit::default();
        circuit._set_inputs(&HashSet::from_iter([2, 3, 4]));
        circuit._add_gate(Operation::Const(1, true))?;
        circuit._add_gate(Operation::Add(5, 1, 2))?;
        circuit._add_gate(Operation::Add(6, 3, 4))?;
        circuit._add_gate(Operation::AddConst(7, 5, false))?;
        circuit._add_gate(Operation::MulConst(8, 6, true))?;
        circuit._add_gate(Operation::Mul(9, 7, 8))?;
        circuit._build().expect("Failed to build circuit");

        circuit.prune();

        let pruned: Vec<Operation<bool>> = circuit.topo_iter().cloned().collect();

        assert_eq!(
            pruned,
            vec![
                Operation::Add(6, 3, 4),
                Operation::Const(1, true),
                Operation::Add(5, 1, 2),
                Operation::Mul(9, 5, 6)
            ]
        );

        Ok(())
    }

    #[test]
    fn test_merge_simple() -> Result<(), SVCircuitError> {
        let mut top: GenericCircuit<bool> = GenericCircuit::default();
        top._set_inputs(&HashSet::from_iter([0, 1]));
        top._add_gate(Operation::Mul(2, 0, 1))?;
        top._add_gate(Operation::Add(4, 3, 2))?;
        top.add_subcircuit("Inverter".to_string(), vec![(2, 7)], vec![(3, 9)]);
        top._build()?;

        let mut inverter: GenericCircuit<bool> = GenericCircuit::default();
        inverter._set_inputs(&HashSet::from_iter([7]));
        inverter._set_outputs(&HashSet::from_iter([9]));
        inverter._add_gate(Operation::AddConst(9, 7, true))?;
        inverter._build()?;

        let library: HashMap<String, GenericCircuit<bool>> =
            HashMap::from_iter([("Inverter".to_string(), inverter)]);

        let mut merged = top.merge(&library).unwrap();
        merged.minimize_wires();
        let merged: Vec<Operation<bool>> = merged.topo_iter().cloned().collect();

        assert_eq!(
            merged,
            vec![
                Operation::Mul(2, 0, 1),
                Operation::AddConst(3, 2, true),
                Operation::Add(4, 3, 2),
            ]
        );

        Ok(())
    }

    #[test]
    fn test_merge_multi() -> Result<(), SVCircuitError> {
        let mut top: GenericCircuit<bool> = GenericCircuit::default();
        top._set_inputs(&HashSet::from_iter([3, 4]));
        top._set_outputs(&HashSet::from_iter([6]));
        top._add_gate(Operation::Const(0, false))?;
        top._add_gate(Operation::Const(1, true))?;
        top._add_gate(Operation::Add(2, 0, 1))?;
        top._add_gate(Operation::Add(5, 3, 4))?;
        top.add_subcircuit("Inner".to_string(), vec![(2, 5), (5, 6)], vec![(6, 4)]);
        top._build().expect("Failed to build top");

        let mut inner: GenericCircuit<bool> = GenericCircuit::default();
        inner._set_inputs(&HashSet::from_iter([5, 6]));
        inner._set_outputs(&HashSet::from_iter([4]));
        inner._add_gate(Operation::Mul(2, 5, 6))?;
        inner._add_gate(Operation::Add(4, 3, 2))?;
        inner.add_subcircuit("Inverter".to_string(), vec![(2, 7)], vec![(3, 9)]);
        inner._build().expect("Failed to build inner");

        let mut inverter: GenericCircuit<bool> = GenericCircuit::default();
        inverter._set_inputs(&HashSet::from_iter([7]));
        inverter._set_outputs(&HashSet::from_iter([9]));
        inverter._add_gate(Operation::AddConst(9, 7, true))?;
        inverter._build().expect("Failed to build inverter");

        let mut library: HashMap<String, GenericCircuit<bool>> =
            HashMap::from_iter([("Inverter".to_string(), inverter)]);
        library.insert("Inner".to_string(), inner.merge(&library).unwrap());

        let mut merged = top.merge(&library).unwrap();
        merged.minimize_wires();
        let merged: Vec<Operation<bool>> = merged.topo_iter().cloned().collect();

        assert_eq!(
            merged,
            vec![
                Operation::Add(7, 3, 4),
                Operation::Const(8, false),
                Operation::AddConst(9, 8, true),
                Operation::Mul(10, 9, 7),
                Operation::AddConst(11, 10, true),
                Operation::Add(12, 11, 10),
                // Since we're connecting directly to an output with the subcircuit,
                // this buffer sticks around
                Operation::AddConst(6, 12, false)
            ]
        );

        Ok(())
    }

    #[test]
    fn test_gate_count() -> Result<(), SVCircuitError> {
        let mut circuit: GenericCircuit<bool> = GenericCircuit::default();
        circuit._add_gate(Operation::Add(9, 7, 8))?;
        circuit._add_gate(Operation::Add(10, 0, 1))?;
        circuit._add_gate(Operation::Mul(11, 10, 9))?;
        circuit._add_gate(Operation::AddConst(12, 11, true))?;
        circuit._add_gate(Operation::Add(13, 12, 11))?;
        circuit._add_gate(Operation::AddConst(6, 13, false))?;

        let counts = circuit.gate_count();

        assert_eq!(
            counts,
            HashMap::from_iter([("Add", 3), ("AddConst", 2), ("Mul", 1)]),
        );

        Ok(())
    }
}
