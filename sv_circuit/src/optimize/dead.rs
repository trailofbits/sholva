use mcircuit::{Operation, Translatable};
use mcircuit::CombineOperation as Op;

/// This code assumes that wire indexes are no greater than |circuit|

pub fn eliminate_dead_code(circuit: &[Op], max_wire: usize) -> Vec<Op> {
    // pass 1: do the reference count
    let mut wire_refs: Vec<usize> = vec![0; max_wire];
    for op in circuit.iter() {
        for win in op.inputs() {
            wire_refs[win] += 1;
        }
    }

    // pass 2 (backwards): eliminate wires recursively
    let mut num_dead = 0;
    for op in circuit.iter().rev() {
        for wout in op.outputs() {
            if wire_refs[wout] == 0 {
                // wire is not live,
                num_dead += 1;

                // decrease references to inputs
                for win in op.inputs() {
                    wire_refs[win] -= 1;
                }
            }
        }
    }

    log::info!(
        "dead: {}, total: {} ({:.2}% circuit size reduction)",
        num_dead,
        circuit.len(),
        ((num_dead as f64) / (circuit.len() as f64)) * 100.,
    );

    // pass 3: eliminate any gate which assigns to a wire with refs[wout] = 0
    let mut new_circuit: Vec<Op> = Vec::with_capacity(circuit.len() - num_dead);
    for op in circuit.iter() {
        // check if the assigned wire has 0 references
        let mut is_dead = false;
        for wout in op.outputs() {
            if wire_refs[wout] == 0 {
                is_dead = true;
            }
        }

        // if the dead gate is an input gate we would need
        // to eliminate part of the witness, might decide to do so in the future...
        match op {
            CombineOperation::GF2(domain_op) => match *domain_op {
                Operation::Input(_) => {
                    is_dead = false;
                }
                Operation::Random(_) => {
                    is_dead = false;
                }
                _ => (),
            },
            CombineOperation::Z64(domain_op) => match *domain_op {
                Operation::Input(_) => {
                    is_dead = false;
                }
                Operation::Random(_) => {
                    is_dead = false;
                }
                _ => (),
            },
            _ => (),
        };

        // add to circuit if live
        if !is_dead {
            new_circuit.push(*op)
        }
    }

    new_circuit
}
