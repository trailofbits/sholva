use mcircuit::parsers::blif::BlifParser;
use mcircuit::{Operation, Parse};
use std::fs::File;
use std::io::BufReader;
use sv_circuit;

#[test]
fn test_flatten_simple() {
    _test_in_folder("simple");
}

#[test]
fn test_flatten_multi() {
    _test_in_folder("multi");
}

fn _test_in_folder(folder: &str) {
    let reader = BufReader::new(
        File::open(format!("tests/data/{}/src.blif", folder)).expect("Failed to open input file"),
    );
    let (flat, _, _) = sv_circuit::flatten(BlifParser::<bool>::new(reader));

    let reader = BufReader::new(
        File::open(format!("tests/data/{}/flat.blif", folder)).expect("Failed to open target file"),
    );
    let (expected, _, _) = sv_circuit::flatten(BlifParser::<bool>::new(reader));

    let flat_topo: Vec<Operation<bool>> = flat.topo_iter().cloned().collect();
    let expected_topo: Vec<Operation<bool>> = expected.topo_iter().cloned().collect();

    assert_eq!(flat_topo, expected_topo);
}
