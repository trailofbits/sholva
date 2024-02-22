#![feature(type_alias_impl_trait)]
#![feature(impl_trait_in_assoc_type)]

mod compositor;
pub mod errors;
pub mod export;
mod generic;
pub mod parse;

#[macro_use]
extern crate maplit;

pub use crate::compositor::CircuitCompositor;
pub use crate::errors::SVCircuitError;
pub use crate::generic::circuit::GenericCircuit;





pub const WITNESS_LEN: usize = 656;
pub type WitnessStep = [bool; WITNESS_LEN];
pub type TimeStamp = usize;
pub type Witness = Vec<(WitnessStep, TimeStamp)>;

pub type ArithCircuit = GenericCircuit<u64>;
pub type BoolCircuit = GenericCircuit<bool>;
