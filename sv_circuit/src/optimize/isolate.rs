use mcircuit::{largest_wires, smallest_wires, CombineOperation, HasIO, Translatable};

pub(crate) fn combine_arithmetic_namespace(
    mut circuit: Vec<CombineOperation>,
) -> Vec<CombineOperation> {
    let mut bool_portion: Vec<CombineOperation> = Vec::new();
    let mut connection: Vec<CombineOperation> = Vec::new();
    let mut arith_portion: Vec<CombineOperation> = Vec::new();

    for g in circuit.drain(..) {
        match g {
            CombineOperation::GF2(_) => bool_portion.push(g),
            CombineOperation::Z64(_) => arith_portion.push(g),
            CombineOperation::B2A(_, _) => connection.push(g),
            CombineOperation::SizeHint(_, _) => {}
        }
    }

    let (_, largest_bool) = largest_wires(&bool_portion);

    bool_portion
        .drain(..)
        .chain(connection.drain(..).map(|g| {
            g.translate(g.inputs(), g.outputs().map(|i| i + largest_bool + 1))
                .unwrap()
        }))
        .chain(arith_portion.drain(..).map(|g| {
            g.translate(
                g.inputs().map(|i| i + largest_bool + 1),
                g.outputs().map(|i| i + largest_bool + 1),
            )
            .unwrap()
        }))
        .collect()
}

pub(crate) fn isolate_arithmetic_wires(
    mut circuit: Vec<CombineOperation>,
) -> Vec<CombineOperation> {
    let mut bool_portion: Vec<CombineOperation> = Vec::new();
    let mut connection: Vec<CombineOperation> = Vec::new();
    let mut arith_portion: Vec<CombineOperation> = Vec::new();

    for g in circuit.drain(..) {
        match g {
            CombineOperation::GF2(_) => bool_portion.push(g),
            CombineOperation::Z64(_) => arith_portion.push(g),
            CombineOperation::B2A(_, _) => connection.push(g),
            CombineOperation::SizeHint(_, _) => {}
        }
    }

    let (smallest_arith, _) = smallest_wires(&arith_portion);

    bool_portion
        .drain(..)
        .chain(connection.drain(..).map(|g| {
            g.translate(g.inputs(), g.outputs().map(|i| i - (smallest_arith - 2)))
                .unwrap()
        }))
        .chain(arith_portion.drain(..).map(|g| {
            g.translate(
                g.inputs().map(|i| i - (smallest_arith - 2)),
                g.outputs().map(|i| i - (smallest_arith - 2)),
            )
            .unwrap()
        }))
        .collect()
}

pub(crate) fn insert_size_hint(circuit: &mut Vec<CombineOperation>) {
    let (largest_arith, largest_bool) = largest_wires(circuit);
    circuit.insert(0, CombineOperation::SizeHint(largest_arith, largest_bool));
}
