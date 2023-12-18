use anyhow::{anyhow, bail, Result};

use crate::{Witness, WitnessStep};
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
