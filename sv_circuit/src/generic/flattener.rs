use std::collections::{HashMap, HashSet};
use std::fmt::Debug;
use std::mem::size_of;

use mcircuit::{Gate, HasIO, Operation, WireValue};
use petgraph::algo::toposort;
use petgraph::graph::NodeIndex;
use petgraph::prelude::StableDiGraph;

use crate::generic::circuit::GenericCircuit;
use crate::generic::{NodeIdx, SVCircuitError, Wire};

/// A sort of "global" namespace that can take a top-level circuit and a series of subcircuits and
/// produce a flat (no subcircuits) representation of the top-level circuit.
pub struct CircuitFlattener<T: WireValue> {
    /// Top-level circuit for this design, must not be a subcircuit of any other subcircuits
    pub top: GenericCircuit<T>,
    /// The subcircuits of `top`. Do not need to be direct subcircuits; can be nth-level.
    subcircuits: HashMap<String, GenericCircuit<T>>,
    /// Underlying graph, used for getting topological ordering
    graph: StableDiGraph<String, usize>,
    /// Maps subcircuit names to the names of circuits that require them
    required_by: HashMap<String, HashSet<String>>,
    /// Maps names of subcircuits to node indices in the graph
    name_map: HashMap<String, NodeIdx>,
    /// Whether the underlying graph has had its edges builts
    pub built: bool,
}

impl<T: WireValue> Default for CircuitFlattener<T> {
    fn default() -> Self {
        CircuitFlattener {
            top: GenericCircuit::default(),
            subcircuits: HashMap::new(),
            graph: StableDiGraph::new(),
            required_by: HashMap::new(),
            name_map: HashMap::new(),
            built: false,
        }
    }
}

impl<T: Debug + WireValue> CircuitFlattener<T>
where
    Operation<T>: Gate<T>,
{
    /// Create a flattener from a given top-level circuit
    pub fn with_top(top: GenericCircuit<T>) -> Self {
        CircuitFlattener {
            top,
            subcircuits: HashMap::new(),
            graph: StableDiGraph::new(),
            required_by: HashMap::new(),
            name_map: HashMap::new(),
            built: false,
        }
    }

    /// Add a subcircuit design to the flattener
    /// * `name` - The name of the subcircuit
    /// * `circuit` - The full design of the subcircuit
    pub fn add_subcircuit(&mut self, name: String, mut circuit: GenericCircuit<T>) -> NodeIdx {
        self.built = false;

        // Build the `required_by` dict appropriately
        for sub in &circuit.subcircuits {
            if !self.required_by.contains_key(&sub.name) {
                self.required_by.insert(sub.name.clone(), HashSet::new());
            }

            self.required_by
                .get_mut(&sub.name)
                .expect("But... Where did it go?")
                .insert(name.clone());
        }

        // Make sure that all of the subcircuits have at least been built
        while !circuit.built {
            match circuit._build() {
                Ok(_) => {}
                Err(e) => match e {
                    SVCircuitError::UndrivenGate {
                        parent,
                        gate_index,
                        wire: _,
                    } => {
                        log::warn!("{parent} contains a gate with an undriven input. Dropping this gate and trusting that its output won't be needed.");
                        let gate = circuit
                            .graph
                            .remove_node(NodeIndex::new(gate_index))
                            .unwrap();
                        if let Some(dst) = gate.dst() {
                            circuit._gate_outputs.remove(&dst);
                        }
                    }
                    _ => {
                        panic!("Failed to build {}", circuit.name);
                    }
                },
            }
        }
        // Store the subcircuit info in the appropriate fields
        self.subcircuits.insert(name.clone(), circuit);
        let idx = self.graph.add_node(name.clone()).index();
        self.name_map.insert(name, idx);

        idx
    }

    /// Iterate through the requirements and add appropriate edges in the underlying graph.
    /// Necessary before flattening so we can get a topological ordering.
    fn build(&mut self) {
        // Iterate over the pair of parents and children
        for (child_name, parent_names) in self.required_by.iter() {
            // Get the node ID for the child
            let child_id = self.name_map.get(child_name).unwrap_or_else(|| {
                panic!(
                    "A circuit called {} was referenced, but couldn't be found",
                    child_name
                )
            });
            // Iterate over parents, since subcircuits can be used in multiple other modules
            for parent_name in parent_names.iter() {
                // Get the node ID for the parent
                let parent_id = self.name_map.get(parent_name).unwrap_or_else(|| {
                    panic!("Somehow, a node was never created for {}", parent_name)
                });
                // Add a directed edge from the child to the parent
                self.graph
                    .add_edge(NodeIndex::new(*child_id), NodeIndex::new(*parent_id), 0);
            }
        }
        self.built = true;
    }

    /// Produces a flat representation of `self.top`
    pub fn flatten(&mut self) -> Result<GenericCircuit<T>, SVCircuitError> {
        if !self.built {
            self.build();
        }
        // Get a topological ordering of the subcircuits
        let graph = &self.graph;
        let ordering: Vec<&String> = match toposort(graph, None) {
            Ok(indices) => indices
                .into_iter()
                .map(|i| graph.node_weight(i).expect("The node vanished!"))
                .collect(),
            Err(cycle) => panic!(
                "Can't get a topological ordering - there's a cycle in this circuit: {:?}",
                cycle
            ),
        };
        // Iterate over the subcircuits in topological order and flatten them as we go
        for sub_name in ordering {
            let is_flat = self
                .subcircuits
                .get(sub_name)
                .expect("The subcircuit is missing!")
                .flat;
            // If we haven't flattened the circuit, replace our current copy of it with a flattened
            // version
            if !is_flat {
                log::info!("Flattening {sub_name}");
                let mut sub = self
                    .subcircuits
                    .remove(sub_name)
                    .expect("The subcircuit is missing!");
                let merged = sub.merge(&self.subcircuits)?;
                self.subcircuits.insert(sub_name.clone(), merged);
            }
        }

        // Now that we have one flattened copy of each subcircuit, we can flatten `top`. First, we
        // print out some debug information to help us estimate the size of the circuit (and how
        // much RAM we'll need)
        log::info!("Performing final flattening");
        for (name, sub) in self.subcircuits.iter() {
            log::debug!(
                "    {}: {} Gates | {} Wires | {} kb",
                name,
                sub.ngate(),
                sub.graph.edge_count(),
                ((size_of::<Operation<T>>() * sub.ngate())
                    + (size_of::<Wire>() * sub.graph.edge_count()))
                    / 1024
            );
        }

        // Merge all of the subcircuits into the top module
        log::debug!("Top module:");
        let mut out = self.top.merge(&self.subcircuits)?;

        // Shrink the wires down into the smallest contiguous chunk of the 64-bit space as possible
        // so that they'll fit in less memory when we have to load them into Reverie.
        log::debug!("Minimizing wire indices");
        out.minimize_wires();
        Ok(out)
    }
}

impl<T: WireValue> From<(String, HashMap<String, GenericCircuit<T>>)> for CircuitFlattener<T>
where
    Operation<T>: Gate<T>,
{
    fn from(repr: (String, HashMap<String, GenericCircuit<T>>)) -> Self {
        let (top_name, mut mappings) = repr;
        let mut flattener = CircuitFlattener {
            top: mappings.remove(&*top_name).expect("Missing top circuit"),
            ..Default::default()
        };

        for (name, circuit) in mappings.drain() {
            flattener.add_subcircuit(name, circuit);
        }

        flattener
    }
}
