use anyhow::{anyhow, bail, Result};
use mcircuit::{parsers::blif::BlifParser, Parse};

use crate::{GenericCircuit, SVCircuitError, Witness, WitnessStep};
use std::convert::TryInto;
use std::fs::File;
use std::io::{BufRead, BufReader};

fn witness_line(step: String) -> Result<WitnessStep> {
    step.chars()
        .flat_map(|c| match c {
            '0' => Ok(false),
            '1' => Ok(true),
            _ => bail!("bad bit {:?} in witness!", c),
        })
        .collect::<Vec<_>>()
        .try_into()
        .map_err(|v| anyhow!("bad witness step {:?}", v))
}

pub fn witness(f: BufReader<File>) -> Result<Witness> {
    f.lines().flat_map(|l| l.map(witness_line)).collect()
}

pub fn blif(mut blif: BlifParser<bool>) -> Result<GenericCircuit<bool>> {
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
