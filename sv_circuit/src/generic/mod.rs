use std::collections::hash_map::DefaultHasher;
use std::collections::{HashMap, HashSet};
use std::hash::{Hash, Hasher};
use std::iter::FromIterator;

use mcircuit::{HasIO, Operation, Translatable, WireValue};

pub use crate::errors::SVCircuitError;
pub mod circuit;

pub type Wire = usize;
pub type NodeIdx = usize;

/// Returns a version of `gate` with wires specified as keys in `remap` replaced with the
/// corresponding values.
fn translate_gate<T: WireValue>(
    gate: &Operation<T>,
    remap: &HashMap<Wire, Wire>,
    frozen: Option<&HashSet<Wire>>,
) -> Operation<T> {
    fn translate<'a>(
        wire: &'a Wire,
        remap: &'a HashMap<Wire, Wire>,
        frozen: Option<&HashSet<Wire>>,
    ) -> &'a Wire {
        if let Some(freeze) = frozen {
            if freeze.contains(wire) {
                return wire;
            }
        }
        remap.get(wire).unwrap_or(wire)
    }

    let new_win = gate.inputs().map(|wire| *translate(&wire, remap, frozen));
    let new_wout = gate.outputs().map(|wire| *translate(&wire, remap, frozen));
    gate.translate(new_win.into_iter(), new_wout.into_iter())
        .unwrap()
}

/// Uses the Module ID provided to generate unique per-instance wire IDs for the provided gate.
/// Returns the newly-localized gate and a hashmap of the rewritten wire IDs (old --> new).
fn localize_gate<T: WireValue>(
    id: &ModId,
    gate: &Operation<T>,
    frozen: Option<&HashSet<Wire>>,
) -> (Operation<T>, HashMap<Wire, Wire>) {
    fn translate<'a>(wire: &'a Wire, id: &'a ModId, frozen: Option<&HashSet<Wire>>) -> Wire {
        if let Some(freeze) = frozen {
            if freeze.contains(wire) {
                return *wire;
            } else {
                let remap = id.to_wire(wire);
                assert!(!freeze.contains(&remap));
                return remap;
            }
        }
        id.to_wire(wire)
    }
    let translation_table: HashMap<Wire, Wire> = HashMap::from_iter(
        gate.inputs()
            .chain(gate.outputs())
            .map(|wire| (wire, translate(&wire, id, frozen))),
    );

    (
        gate.translate_from_hashmap(translation_table.clone())
            .unwrap(),
        translation_table,
    )
}

/// Combines a module ID for the parent module with a module ID for the current module
/// instance. This used to be a recursive type, but now that it uses random IDs it probably
/// doesn't need to be this complex.
#[derive(Hash, Clone)]
pub struct ModId {
    // TODO - can I make this a tuple? Or even a flat u64?
    pub parent: usize,
    pub own: usize,
}

impl ModId {
    /// Takes a wire ID and hashes it with the parent and self IDs to create a unique ID for the
    /// wire _in this instance of the module_
    #[inline(always)]
    fn to_wire(&self, own_wire: &Wire) -> Wire {
        let mut s = DefaultHasher::new();
        self.hash(&mut s);
        own_wire.hash(&mut s);
        s.finish() as Wire
    }

    fn new(parent: usize) -> ModId {
        ModId {
            parent,
            own: rand::random(),
        }
    }
}

/// Descriptor for a submodule of a circuit. Does not provide an implementation - only an interface
#[derive(Clone)]
pub struct SubCircuitDesc {
    /// Name of the subcircuit to look for
    pub name: String,
    /// Pairings between wire IDs in the parent namespace and wire IDs in the subcircuit's namespace
    pub inputs: Vec<(Wire, Wire)>,
    /// Pairings between wire IDs in the parent namespace and wire IDs in the subcircuit's namespace
    pub outputs: Vec<(Wire, Wire)>,
    /// Unique ID for this subcircuit. Generally the ID actually stored _on_ the subcircuit is
    /// ignored in favor of this one - so we can probably get rid of it.
    pub id: ModId,
}

#[cfg(test)]
mod tests {
    use crate::generic::{localize_gate, translate_gate, ModId, Wire};
    use mcircuit::Operation;
    use std::collections::{HashMap, HashSet};
    use std::iter::FromIterator;

    #[test]
    fn test_translate_simple() {
        let gate: Operation<bool> = Operation::Add(3, 1, 2);
        let target: Operation<bool> = Operation::Add(6, 4, 5);

        let translations: HashMap<Wire, Wire> = HashMap::from_iter([(1, 4), (2, 5), (3, 6)]);

        assert_eq!(target, translate_gate(&gate, &translations, None));
    }

    #[test]
    fn test_translate_reuse() {
        let gate: Operation<bool> = Operation::Add(3, 1, 2);
        let target: Operation<bool> = Operation::Add(4, 2, 3);

        let translations: HashMap<Wire, Wire> = HashMap::from_iter([(1, 2), (2, 3), (3, 4)]);

        assert_eq!(target, translate_gate(&gate, &translations, None));
    }

    #[test]
    fn test_translate_frozen() {
        let gate: Operation<bool> = Operation::Add(3, 1, 2);
        let target: Operation<bool> = Operation::Add(6, 1, 5);

        let translations: HashMap<Wire, Wire> = HashMap::from_iter([(1, 4), (2, 5), (3, 6)]);

        assert_eq!(
            target,
            translate_gate(&gate, &translations, Some(&HashSet::<Wire>::from_iter([1])))
        );
    }

    #[test]
    fn test_translate_frozen_const() {
        let gate: Operation<bool> = Operation::AddConst(3, 1, true);
        let target: Operation<bool> = Operation::AddConst(6, 1, true);

        let translations: HashMap<Wire, Wire> = HashMap::from_iter([(1, 4), (2, 5), (3, 6)]);

        assert_eq!(
            target,
            translate_gate(&gate, &translations, Some(&HashSet::<Wire>::from_iter([1])))
        );
    }

    #[test]
    fn test_localization() {
        let mod_id = ModId::new(rand::random());
        let gate: Operation<bool> = Operation::Add(3, 1, 2);
        let target: Operation<bool> =
            Operation::Add(mod_id.to_wire(&3), mod_id.to_wire(&1), mod_id.to_wire(&2));

        let expected_remappings: HashMap<Wire, Wire> = HashMap::from_iter([
            (3, mod_id.to_wire(&3)),
            (1, mod_id.to_wire(&1)),
            (2, mod_id.to_wire(&2)),
        ]);

        assert_eq!(
            (target, expected_remappings),
            localize_gate(&mod_id, &gate, None)
        );
    }

    #[test]
    fn test_localization_frozen() {
        let mod_id = ModId::new(rand::random());
        let gate: Operation<bool> = Operation::Add(6, 4, 5);
        let target: Operation<bool> = Operation::Add(mod_id.to_wire(&6), 4, mod_id.to_wire(&5));

        let expected_remappings: HashMap<Wire, Wire> =
            HashMap::from_iter([(6, mod_id.to_wire(&6)), (4, 4), (5, mod_id.to_wire(&5))]);

        assert_eq!(
            (target, expected_remappings),
            localize_gate(&mod_id, &gate, Some(&HashSet::<Wire>::from_iter([4])))
        );
    }

    #[test]
    fn test_localization_frozen_const() {
        let mod_id = ModId::new(rand::random());
        let gate: Operation<bool> = Operation::AddConst(6, 4, true);
        let target: Operation<bool> = Operation::AddConst(mod_id.to_wire(&6), 4, true);

        let expected_remappings: HashMap<Wire, Wire> =
            HashMap::from_iter([(6, mod_id.to_wire(&6)), (4, 4)]);

        assert_eq!(
            (target, expected_remappings),
            localize_gate(&mod_id, &gate, Some(&HashSet::<Wire>::from_iter([4])))
        );
    }
}
