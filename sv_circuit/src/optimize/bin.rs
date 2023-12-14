use std::io::{self, BufRead, Write};

use mcircuit::CombineOperation as Op;

pub fn load_serialized<R: BufRead>(reader: &mut R) -> Result<Vec<Op>, io::Error> {
    let program: Vec<Op> = bincode::deserialize_from(reader).unwrap();
    Ok(program)
}

pub fn store_serialized<W: Write>(w: &mut W, circuit: &[Op]) -> Result<(), io::Error> {
    bincode::serialize_into(w, circuit).expect("Failed to write composite circuit");
    Ok(())
}
