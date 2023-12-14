use std::fs::File;
use std::io::{BufReader, BufWriter};
use std::path::{PathBuf};

use anyhow::Result;
use clap::{command, Parser};

use sv_circuit::Witness;

use mcircuit::parsers::blif::BlifParser;
use mcircuit::Parse;

#[derive(Parser)]
#[command(author, version, about, long_about = None)]
struct Cli {
    #[clap(short, long, value_name = "BLIF")]
    blif: PathBuf,

    #[clap(short, long, value_name = "WITNESS")]
    witness: PathBuf,

    #[clap(short, long, value_name = "OUTPUT")]
    output: String,
}

/// Rust version of circuit compositor
fn main() -> Result<()> {
    let cli = Cli::parse();

    // Parse and process input BLIF.
    let blif = File::open(cli.blif)
        .map(BufReader::new)
        .map(BlifParser::<bool>::new)?;
    let (circuit, _, _) = sv_circuit::flatten(blif);

    // Parse and process input witness.
    let witness: Witness = File::open(cli.witness)
        .map(BufReader::new)
        .map(sv_circuit::parse::witness)??;

    File::create(format!("{}.circuit", &cli.output))
        .map(BufWriter::new)
        .map(|mut f| sv_circuit::export::circuit(&mut f, &circuit, &witness))??;

    File::create(format!("{}.public_input", &cli.output))
        .map(BufWriter::new)
        .map(|mut f| sv_circuit::export::public(&mut f))??;

    File::create(format!("{}.private_input", &cli.output))
        .map(BufWriter::new)
        .map(|mut f| sv_circuit::export::private(&mut f, &witness))??;

    Ok(())
}
