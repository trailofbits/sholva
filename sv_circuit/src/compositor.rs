use itertools::Itertools;
use mcircuit::{CombineOperation, Operation};
use serde::{Serialize, Serializer};

use crate::generic::Wire;
use crate::ArithCircuit;
use crate::BoolCircuit;

/// A module that takes a top-level circuit representation and several subcircuit representations and
/// produces a flattened circuit out of only logic gates. Like the BoolCircuit, this is a wrapper around
/// CircuitFlattener<bool> due to the quirks of PyO3.

pub struct CircuitCompositor {
    boolean: BoolCircuit,
    arithmetic: ArithCircuit,
    connection: Vec<CombineOperation>,
}

impl CircuitCompositor {
    pub fn new(boolean: BoolCircuit, arithmetic: ArithCircuit) -> Self {
        Self {
            boolean,
            arithmetic,
            connection: vec![],
        }
    }

    /// Add a BtoA gate to the connection circuit. Boolean wire ranges are given as [low, low + 64),
    /// but we only ask for the low wire here
    pub fn connect(&mut self, arith_wire: Wire, lo: Wire) {
        self.connection.push(CombineOperation::B2A(arith_wire, lo));
    }

    /// Add a random challenge gate to the connection circuit.
    pub fn challenge(&mut self, dst: Wire) {
        // self.arithmetic.circuit.inputs.remove(&dst);
        self.arithmetic._add_gate(Operation::Random(dst)).unwrap();
        self.arithmetic._build().unwrap();
    }

    pub fn gate_stats(&self) -> (usize, usize, usize, usize, usize) {
        (
            self.boolean.ngate(),
            self.boolean.nwire(),
            self.connection.len(),
            self.arithmetic.ngate(),
            self.arithmetic.nwire(),
        )
    }
}

impl Serialize for CircuitCompositor {
    fn serialize<S>(&self, serializer: S) -> Result<<S as Serializer>::Ok, <S as Serializer>::Error>
    where
        S: Serializer,
    {
        serializer.collect_seq(
            // Size Hint - helps Reverie know how much memory to allocate
            std::iter::once(CombineOperation::SizeHint(
                self.arithmetic.nwire() + 1,
                self.boolean.nwire() + 1,
            ))
            .chain(
                // Boolean Circuit Inputs
                self.boolean
                    .inputs
                    .iter()
                    .sorted()
                    .map(|i| CombineOperation::GF2(Operation::Input(*i))),
            )
            // Boolean Circuit Gates
            .chain(self.boolean.topo_iter().map(|g| CombineOperation::GF2(*g)))
            // Connection Circuit
            .chain(self.connection.iter().cloned())
            // Arithmetic Circuit Gates
            .chain(
                self.arithmetic
                    .topo_iter()
                    .map(|g| CombineOperation::Z64(*g)),
            )
            // Arithmetic Circuit Outputs
            .chain(
                self.arithmetic
                    .outputs
                    .iter()
                    .sorted()
                    .map(|o| CombineOperation::Z64(Operation::AssertZero(*o))),
            ),
        )
    }
}
