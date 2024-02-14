use crate::generic::{NodeIdx, Wire};
use thiserror::Error;

/// enumerates all possible errors that can occur during circuit flattening
#[derive(Error, Debug)]
pub enum SVCircuitError {
    #[error("Malformed BLIF: {0}")]
    BlifError(String),

    #[error("No circuit named '{dependency}' available (referenced by {parent})")]
    MissingDependency { dependency: String, parent: String },

    #[error(
        "Gate {gate_index} in {parent} reads from wire {wire}, but nothing outputs to this wire"
    )]
    UndrivenGate {
        parent: String,
        gate_index: NodeIdx,
        wire: Wire,
    },

    #[error("Multiple entities try to write to wire {wire}")]
    DriveConflict { wire: Wire },

    #[error("Wire {wire} of circuit '{dependency}' is not an I/O port (accessed by {parent})")]
    EncapsulationViolation {
        dependency: String,
        parent: String,
        wire: Wire,
    },

    #[error("This circuit is not topologically-sorted")]
    NonTopo,

    #[error("Circuit {name} is missing output bits: {wires:?}")]
    UndrivenOutput { name: String, wires: Vec<Wire> },
}
