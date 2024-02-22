use anyhow::{anyhow, bail};
use mcircuit::{parsers::blif::BlifParser, Parse};

use crate::{GenericCircuit, SVCircuitError, Witness, WitnessStep};
use std::convert::TryInto;
use std::fs::File;
use std::io::{BufRead, BufReader};

fn witness_line(step: String) -> Result<WitnessStep, SVCircuitError> {
    step.chars()
        .flat_map(|c| match c {
            '0' => Ok(false),
            '1' => Ok(true),
            _ => Err(SVCircuitError::WitnessError(format!(
                "unexpected character {}",
                c
            ))),
        })
        .collect::<Vec<_>>()
        .try_into()
        .map_err(|_| SVCircuitError::WitnessError("bad witness step".to_string()))
}

pub fn witness(f: BufReader<File>) -> Result<Witness, SVCircuitError> {
    Ok(f.lines()
        .map(|l| witness_line(l.unwrap()))
        .collect::<Result<Vec<_>, _>>()?
        .into_iter()
        .zip(0..)
        .collect())
}

pub fn blif(mut blif: BlifParser<bool>) -> anyhow::Result<GenericCircuit<bool>> {
    let circuit = blif
        .next()
        .ok_or(SVCircuitError::BlifError(
            "contains no circuits!".to_string(),
        ))?
        .into();
    if blif.next().is_some() {
        Err(SVCircuitError::BlifError(
            "circuit is unflattened: yosys flattening should be used to inline all subcircuits!"
                .to_string(),
        )
        .into())
    } else {
        Ok(circuit)
    }
}
