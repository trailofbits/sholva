use anyhow::{Context, Result};

pub use crate::BoolCircuit;
use crate::Witness;
use itertools::Itertools;
use mcircuit::Operation;
use std::collections::VecDeque;

use std::io::Write;
use std::ops::Range;

pub fn intra_bucket() -> Result<BoolCircuit> {
    use crate::parse;
    use mcircuit::parsers::blif::BlifParser;
    use mcircuit::Parse;
    use std::fs::File;
    use std::io::BufReader;

    File::open("gadgets/intra_bucket.blif")
        .map(BufReader::new)
        .map(BlifParser::<bool>::new)
        .map(parse::blif)?
}

pub fn public<F: Write>(writer: &mut F) -> Result<()> {
    writeln!(writer, "version 2.0.0-beta;")?;
    writeln!(writer, "public_input;")?;
    writeln!(writer, "@type field 2;")?;
    writeln!(writer, "@begin")?;

    // Empty

    writeln!(writer, "@end")?;

    Ok(())
}

pub fn private<F: Write>(writer: &mut F, witness: &Witness) -> Result<()> {
    writeln!(writer, "version 2.0.0-beta;")?;
    writeln!(writer, "private_input;")?;
    writeln!(writer, "@type field 2;")?;
    writeln!(writer, "@begin")?;

    for (i, step) in witness.iter().enumerate() {
        writeln!(writer, "// step {}", i)?;
        for wit_value in step {
            writeln!(writer, "< {} > ;", *wit_value as u32)?;
        }
    }
    writeln!(writer, "@end")?;

    Ok(())
}

/// emit total IR0 circuit.
fn execution<F: Write>(
    circuit_writer: &mut F,
    tiny86: &BoolCircuit,
    witness: &Witness,
) -> Result<()> {
    writeln!(circuit_writer, "version 2.0.0-beta;")?;
    writeln!(circuit_writer, "circuit;")?;
    writeln!(circuit_writer, "@type field 2;")?;
    writeln!(circuit_writer, "@begin")?;

    // emit circuit @function.
    writeln!(
        circuit_writer,
        "@function({}, @out: 0:{}, @in: 0:{}, 0:{})",
        tiny86.name,
        tiny86.outputs.len(),
        // NOTE(jl): guaranteed two inputs of same size in `check.v`.
        tiny86.inputs.len() / 2,
        tiny86.inputs.len() / 2
    )?;
    // NOTE(lo): wire numbering in function bodies starts with the output and proceeds sequentially through the inputs
    // e.g. for the function signature above, which corresponds to circuit(step1, step2)
    // $0 is the output wire, i.e., the value written to ok in check.v
    // $1 ... $656 are the step1 input wires
    // $657 ... $1312 are the step2 input wires

    // FIXME(lo): we need a counter to increment through the input wire indices for the Operation::Input case below, i.e.,
    // let mut input_wire_idx: usize = 0;
    // but tiny86.topo_iter() already comes with a numbering that may conflict with these indices...
    // We also don't appear to hit the Operation::Input case.

    for gate in tiny86.topo_iter() {
        write!(circuit_writer, "  ")?; // indent body
        match gate {
            Operation::Input(_) => panic!("Input in circuit body!"),
            Operation::Random(_) => panic!("Random unsupported!"),
            Operation::Add(o, l, r) => {
                writeln!(circuit_writer, "${} <- @add(${}, ${});", o, l, r)
            }
            Operation::AddConst(o, i, c) => {
                writeln!(
                    circuit_writer,
                    "${} <- @addc(${}, < {} >);",
                    o, i, *c as u32
                )
            }
            Operation::Sub(o, l, r) => {
                writeln!(circuit_writer, "${} <- @add(${}, ${});", o, l, r)
            }
            Operation::SubConst(o, i, c) => {
                writeln!(
                    circuit_writer,
                    "${} <- @addc(${}, < {} >);",
                    o, i, *c as u32
                )
            }
            Operation::Mul(o, l, r) => {
                writeln!(circuit_writer, "${} <- @mul(${}, ${});", o, l, r)
            }
            Operation::MulConst(o, i, c) => {
                writeln!(
                    circuit_writer,
                    "${} <- @mulc(${}, < {} >);",
                    o, i, *c as u32
                )
            }
            Operation::AssertZero(_) => panic!("Unexpected assertion in circuit!"),
            Operation::Const(w, c) => {
                writeln!(circuit_writer, "${} <- < {} >;", w, *c as u32)
            }
        }?;
    }
    // HACK(jl): this exporting function should be independent of our circuit geometry;
    // here we're just lucky the number of outputs slots nicely into the area reserved for Bristol
    // True/False constants.
    assert!(tiny86.outputs.len() == 1);
    for output in tiny86.outputs.iter().sorted() {
        writeln!(circuit_writer, "$0 <- ${};", output)?;
    }

    // FIXME(lo): ok bit needs to be negated and assigned to output wire $0
    // writeln!(circuit_writer, ${} <- ${}, ok_bit_idx + 1, ok_bit_idx)?;
    // writeln!(circuit_writer, "$0 <- ${}", ok_bit_idx + 1)?;
    writeln!(circuit_writer, "@end")?;
    writeln!(circuit_writer, "\n")?;

    // FIXME(jl): note about inputs, outputs, @functions, and flattening.
    // because our wires are identified just by a unique integer,
    // flattening reserves space for:
    // - 2 wires, true and false (used for Bristol -- don't hurt us but also don't need).
    // - all inputs -- so, here the circuit doesn't start until 2 + 656 I think.
    // - all outputs -- so, we can't use those wires for other assignments!
    //
    // I think this is missing:
    // - we have to generate $stepsize number of wires for each private input bit.
    // - plus a wire for the `ok` bit.
    // - plus a wire to invert it -- maybe, if we do really want an `@assert_one`.
    // there's going to be some funky managing to begin counting anew outside the function body.
    //
    // So we can either hack around it,
    // or maybe enable a flattening "mode" where it doesn't
    // do any reserving of bits -- then if we have a way of knowing where the flattener left off counting,
    // so just the number of wires the circuit body uses (currently ~46k),
    // then we can pick up counting here as we please.

    // HACK(jl): number sufficiently large enough I know the circuit won't conflict.
    // FIXME(jl): this should start from the last assigned wire of the circuit body.
    let mut wire_counter: usize = 0;

    // emit circuit data.
    // FIXME(jl): ideally this can be caught much earlier.
    // NOTE(jl): need at least 2 traces to compare.
    assert!(witness.len() >= 2);

    let mut steps: VecDeque<Range<usize>> = VecDeque::with_capacity(2);

    for (step_count, step) in witness.iter().enumerate() {
        // fetch the private input;
        // 1. allocate a contiguous wire range with `@new`, using the circuit step size,
        // 2. emit an `@private` for each bit of the the inputs step, maintaining pairs
        //    of steps in 2-depth deque,
        // 3. emit an `@call` to the circuit function with step pair,
        writeln!(circuit_writer, "// step {}", step_count)?;
        // 1.
        writeln!(
            circuit_writer,
            "@new(${} ... ${});", // NOTE(jl): this end range is asserted at exit of this loop.
            wire_counter,
            wire_counter + tiny86.inputs.len() / 2 - 1
        )?;

        // 2.
        let start = wire_counter;
        for _ in step {
            writeln!(circuit_writer, "${} <- @private();", wire_counter)?;
            wire_counter += 1;
        }
        let end = wire_counter;
        assert!(end == start + tiny86.inputs.len() / 2);
        // push current step onto deque
        let step_range = Range { start, end };
        steps.push_front(step_range);

        if step_count > 0 {
            // 3.
            let back = steps.back().context("missing back step")?;
            let front = steps.front().context("missing front step")?;
            writeln!(
                circuit_writer,
                "${} <- @call({}, ${} ... ${}, ${} ... ${});",
                wire_counter,
                tiny86.name,
                // previous step wire range.
                back.clone().min().context("no back step minimum")?,
                back.clone().max().context("no back step maximum")?,
                // current step wire range.
                front.clone().min().context("no back step minimum")?,
                front.clone().max().context("no back step maximum")?,
            )?;
            // 4.
            writeln!(circuit_writer, "@assert_zero(${});", wire_counter)?;
            wire_counter += 1;
            // pop verified step off of deque
            steps.pop_back();
        }
    }
    writeln!(circuit_writer, "@end")?;
    Ok(())
}

fn memory<F: Write>(circuit_writer: &mut F) -> Result<()> {
    for gate in intra_bucket()?.topo_iter() {
        write!(circuit_writer, "  ")?; // indent body
        match gate {
            Operation::Input(_) => panic!("Input in circuit body!"),
            Operation::Random(_) => panic!("Random unsupported!"),
            Operation::Add(o, l, r) => {
                writeln!(circuit_writer, "${} <- @add(${}, ${});", o, l, r)
            }
            Operation::AddConst(o, i, c) => {
                writeln!(
                    circuit_writer,
                    "${} <- @addc(${}, < {} >);",
                    o, i, *c as u32
                )
            }
            Operation::Sub(o, l, r) => {
                writeln!(circuit_writer, "${} <- @add(${}, ${});", o, l, r)
            }
            Operation::SubConst(o, i, c) => {
                writeln!(
                    circuit_writer,
                    "${} <- @addc(${}, < {} >);",
                    o, i, *c as u32
                )
            }
            Operation::Mul(o, l, r) => {
                writeln!(circuit_writer, "${} <- @mul(${}, ${});", o, l, r)
            }
            Operation::MulConst(o, i, c) => {
                writeln!(
                    circuit_writer,
                    "${} <- @mulc(${}, < {} >);",
                    o, i, *c as u32
                )
            }
            Operation::AssertZero(_) => panic!("Unexpected assertion in circuit!"),
            Operation::Const(w, c) => {
                writeln!(circuit_writer, "${} <- < {} >;", w, *c as u32)
            }
        }?;
    }
    Ok(())
}

pub fn circuit<F: Write>(
    circuit_writer: &mut F,
    tiny86: &BoolCircuit,
    witness: &Witness,
) -> Result<()> {
    execution(circuit_writer, tiny86, witness)?;
    memory(circuit_writer)?;
    Ok(())
}
