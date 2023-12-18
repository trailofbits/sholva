use std::collections::{HashMap, HashSet};
use std::fs::File;
use std::io::BufReader;

use clap::{App, Arg};

use mcircuit::{CombineOperation, HasIO, Identity, Operation};

fn main() {
    let matches = App::new("sv-bin-stat")
        .version(env!("CARGO_PKG_VERSION"))
        .author("Eric Hennenfent <eric.hennenfent@trailofbits.com>")
        .about("Reads a binary circuit off the disk and prints information about it")
        .arg(
            Arg::with_name("operation")
                .long("count")
                .short("c")
                .help("Specify whether to count wires or gates")
                .possible_values(&["wires", "gates"])
                .empty_values(false)
                .required(true),
        )
        .arg(
            Arg::with_name("circuit")
                .short("i")
                .long("circuit")
                .takes_value(true)
                .help("Binary file output by sv-compositor"),
        )
        .get_matches();

    let circuit_file = matches
        .value_of("circuit")
        .expect("No circuit file provided");

    let reader = BufReader::new(File::open(circuit_file).expect("Failed to open circuit file"));

    let gates: Vec<CombineOperation> = bincode::deserialize_from(reader).expect(
        "Failed to deserialize composite circuit. Is this binary file in the correct format?",
    );

    match matches.value_of("operation").unwrap() {
        "gates" => {
            let mut counts: HashMap<&str, usize> = HashMap::new();

            for g in gates.iter() {
                let key: &str = gate_to_str(g);
                *counts.entry(key).or_insert(0) += 1;
            }

            log::debug!("{counts:?}");
        }
        "wires" => {
            let mut arith_wires: HashSet<usize> = HashSet::new();
            let mut bool_wires: HashSet<usize> = HashSet::new();

            for gate in gates.iter() {
                match gate {
                    CombineOperation::GF2(g) => bool_wires.extend(g.inputs().chain(g.outputs())),
                    CombineOperation::Z64(g) => arith_wires.extend(g.inputs().chain(g.outputs())),
                    _ => {}
                }
            }

            log::debug!(
                "{{\"boolean_wires\": {}, \"arithmetic_wires\": {} }}",
                bool_wires.len(),
                arith_wires.len()
            )
        }
        _ => {
            log::debug!("Count options are: gates, wires")
        }
    }
}

fn gate_to_str(gate: &CombineOperation) -> &str {
    match gate {
        CombineOperation::GF2(g) => match g {
            buf if buf.is_identity() => "GF2::Buffer",
            Operation::Input(_) => "GF2::Input",
            Operation::Random(_) => "GF2::Random",
            Operation::Add(_, _, _) => "GF2::Add",
            Operation::AddConst(_, _, _) => "GF2::AddConst",
            Operation::Sub(_, _, _) => "GF2::Sub",
            Operation::SubConst(_, _, _) => "GF2::SubConst",
            Operation::Mul(_, _, _) => "GF2::Mul",
            Operation::MulConst(_, _, _) => "GF2::MulConst",
            Operation::AssertZero(_) => "GF2::AssertZero",
            Operation::Const(_, _) => "GF2::Const",
        },
        CombineOperation::Z64(g) => match g {
            buf if buf.is_identity() => "Z64::Buffer",
            Operation::Input(_) => "Z64::Input",
            Operation::Random(_) => "Z64::Random",
            Operation::Add(_, _, _) => "Z64::Add",
            Operation::AddConst(_, _, _) => "Z64::AddConst",
            Operation::Sub(_, _, _) => "Z64::Sub",
            Operation::SubConst(_, _, _) => "Z64::SubConst",
            Operation::Mul(_, _, _) => "Z64::Mul",
            Operation::MulConst(_, _, _) => "Z64::MulConst",
            Operation::AssertZero(_) => "Z64::AssertZero",
            Operation::Const(_, _) => "Z64::Const",
        },
        CombineOperation::B2A(_, _) => "B2A",
        CombineOperation::SizeHint(_, _) => "SizeHint",
    }
}
