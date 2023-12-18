use std::cmp::{max, Reverse};
use std::collections::{BinaryHeap, HashMap};

// since the keys are machine words
use fnv::FnvBuildHasher;
use indicatif::{ProgressBar, ProgressIterator};

use mcircuit::Translatable;
use mcircuit::{largest_wires, HasIO};
use mcircuit::{CombineOperation as Op, CombineOperation};

/// We attempt to allocate registers that are consecutive ("small index") as best we can:
/// To improve cache locality in the prover.
///
/// This is done by using a binary (min) heap over the free registers
/// and always allocating the smallest available free register.

pub fn register_aliasing(circuit: &[Op], max_wire: usize) -> Vec<Op> {
    log::debug!("Calculating time of last use...");

    let progress = ProgressBar::new(circuit.len() as u64);
    progress.set_draw_rate(4);

    // pass 1: time of last use
    let mut last_use = HashMap::with_capacity_and_hasher(circuit.len(), FnvBuildHasher::default());
    let mut contig_blocks =
        HashMap::with_capacity_and_hasher(circuit.len(), FnvBuildHasher::default());
    for (i, op) in circuit.iter().enumerate().progress_with(progress) {
        for win in op.inputs() {
            last_use.insert(win, i);
        }
        if let CombineOperation::B2A(_z64, gf2_base) = op {
            for win in op.inputs() {
                contig_blocks.insert(win, *gf2_base);
            }
        }
    }

    // pass 2: alias registers
    let mut free: BinaryHeap<Reverse<usize>> = BinaryHeap::new(); // heap of free registers
    let mut next: usize = 0; // next unused wire label
    let mut alias = HashMap::with_hasher(FnvBuildHasher::default()); // map[old_wire] -> new_wire
    let mut max_mem = 0;

    let mut new_circuit = Vec::with_capacity(circuit.len());

    let mut new_wins = Vec::with_capacity(4);
    let mut new_wouts = Vec::with_capacity(4);

    log::debug!("Aliasing registers...");
    let progress = ProgressBar::new(circuit.len() as u64);
    progress.set_draw_rate(4);

    for (i, op) in circuit.iter().enumerate().progress_with(progress) {
        new_wins.clear();
        new_wouts.clear();

        // translate inputs
        for win in op.inputs() {
            new_wins.push(
                *alias
                    .get(&win)
                    .expect("No alias assigned to this wire yet!"),
            );
        }

        // try to garbage collect inputs
        for win in op.inputs() {
            if i >= last_use[&win] {
                let new_win = alias.remove(&win).unwrap();
                free.push(Reverse(new_win));
            }
        }

        // translate outputs
        for wout in op.outputs() {
            // If this wire goes to a B2A gate, we need to translate the entire block of input
            // wires so that they'll be contiguous
            if contig_blocks.contains_key(&wout) {
                let block_base = contig_blocks.remove(&wout).unwrap();

                for w in block_base..block_base + 64 {
                    alias.insert(w, next);
                    next += 1;
                    contig_blocks.remove(&w);
                }
            } else {
                alias.entry(wout).or_insert_with(|| {
                    let new_wout: usize = match free.pop() {
                        Some(Reverse(new_wout)) => new_wout,
                        None => {
                            let l = next;
                            next += 1;
                            l
                        }
                    };
                    new_wout
                });
            }
            max_mem = max(max_mem, alias.len());
            new_wouts.push(alias[&wout]);
        }

        // translate instruction
        if let Some(translated) = op.translate(new_wins.iter().copied(), new_wouts.iter().copied())
        {
            new_circuit.push(translated);
        }
    }

    let (largest_arith, largest_bool) = largest_wires(&new_circuit);
    let max_mem = max(largest_bool, largest_arith);

    log::debug!(
        "register use: {} / {} ({:.2} % register reduction)",
        max_mem,
        max_wire,
        (1. - ((max_mem as f64) / (max_wire as f64))) * 100.
    );

    new_circuit
}
