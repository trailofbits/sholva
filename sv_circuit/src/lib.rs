#![feature(type_alias_impl_trait)]
#![feature(impl_trait_in_assoc_type)]

mod compositor;
pub mod export;
mod generic;
pub mod parse;

#[macro_use]
extern crate maplit;

pub use crate::compositor::CircuitCompositor;
pub use crate::generic::circuit::GenericCircuit;
pub use crate::generic::flattener::CircuitFlattener;
use crate::generic::SVCircuitError;
use mcircuit::parsers::blif::{BlifParser, BlifSubcircuitDesc, CanConstructVariant};
use mcircuit::parsers::WireHasher;
use mcircuit::{Gate, Operation, Parse, WireValue};
use std::collections::HashMap;

pub const WITNESS_LEN: usize = 656;
pub type WitnessStep = [bool; WITNESS_LEN];
pub type Witness = Vec<WitnessStep>;

pub type ArithCircuit = GenericCircuit<u64>;
pub type BoolCircuit = GenericCircuit<bool>;

pub fn flatten<T: WireValue>(mut parser: BlifParser<T>) -> (GenericCircuit<T>, String, WireHasher)
where
    BlifParser<T>: CanConstructVariant<T>,
    Operation<T>: Gate<T>,
{
    let mut top: Option<String> = None;
    let mut subcircuit_mappings: HashMap<String, Vec<BlifSubcircuitDesc>> = HashMap::new();
    let mut circuits: HashMap<String, GenericCircuit<T>> = HashMap::new();

    while let Some(circuit) = parser.next() {
        if top.is_none() {
            top = Some(circuit.name.clone());
        }
        subcircuit_mappings.insert(circuit.name.clone(), circuit.subcircuits.clone());
        circuits.insert(circuit.name.clone(), circuit.into());
    }

    let mut keys: Vec<String> = circuits.keys().cloned().collect();

    for name in keys.drain(..) {
        if let Some(sub_mappings) = subcircuit_mappings.get(&name) {
            for sub_desc in sub_mappings {
                let sub_model = circuits.get(&sub_desc.name).unwrap_or_else(|| {
                    panic!("No model for required subcircuit {}", sub_desc.name)
                });

                let mut in_map: Vec<(usize, usize)> = Vec::new();
                let mut out_map: Vec<(usize, usize)> = Vec::new();

                for (own_wire, sub_wire) in sub_desc.connections.iter() {
                    if sub_model.inputs.contains(sub_wire) {
                        in_map.push((*own_wire, *sub_wire));
                    }
                    if sub_model.outputs.contains(sub_wire) {
                        out_map.push((*own_wire, *sub_wire));
                    }
                }

                circuits.get_mut(&name).unwrap().add_subcircuit(
                    sub_desc.name.clone(),
                    in_map,
                    out_map,
                );
            }
        }
    }

    let top = top.expect("No circuits found in this BLIF file");

    let mut flattener: CircuitFlattener<T> = (top.clone(), circuits).into();

    let flat = match flattener.flatten() {
        Ok(flat) => flat,
        Err(e) => match e {
            SVCircuitError::UndrivenOutput { name, wires } => {
                let missing: Vec<String> = wires
                    .iter()
                    .map(|x| parser.hasher.backref(*x).unwrap_or(&x.to_string()).clone())
                    .collect();

                panic!(
                    "Circuit '{}' doesn't drive the following wires: {:?} ({} in total)",
                    name,
                    missing,
                    missing.len()
                )
            }
            SVCircuitError::UndrivenGate {
                parent,
                gate_index: _,
                wire,
            } => {
                let name: String = parser
                    .hasher
                    .backref(wire)
                    .unwrap_or(&wire.to_string())
                    .clone();
                panic!(
                    "{}.{} is not driven by a gate, input, or subcircuit",
                    parent, name
                );
            }
            _ => {
                panic!("An error occurred during flattening: {:?}", e)
            }
        },
    };

    (flat, top, parser.hasher)
}
