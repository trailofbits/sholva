use std::io::{stderr, stdout, Write};
use std::process;

use anyhow::{anyhow, Result};
use clap::{arg, command, ArgAction, ArgGroup, Command};

mod dump;
mod syscall;
mod tiny86;
mod trace;

use tiny86::{Bitstring, Tiny86Write};

fn app() -> Command {
    command!()
        .arg(
            arg!(-F --format <OUTPUT_FORMAT> "The output format to use")
                .value_parser(["jsonl", "tiny86", "tiny86-text", "inst-count"])
                .default_value("jsonl")
        )
        .arg(
            arg!(-m --mode <MODE> "The CPU mode to decode instructions with")
                .value_parser(["32", "64"])
                .default_value("64")
        )
        .arg(arg!(-i --ignore_unsupported_memops "Ignore unsupported memory ops instead of failing"))
        .arg(arg!(-t --tiny86_only "Fail if the tracer encounters x86 functionality that Tiny86 doesn't support"))
        .arg(
            arg!(-s --syscall_model <MODEL> "For Tiny86: which syscall model to use when emulating syscalls")
                .value_parser(["decree", "linux32"])
                .default_value("linux32")
                .requires("tiny86_only"),
        )
        .arg(arg!(-d --debug_on_fault "Suspend the tracee and detach if a memory access faults"))
        .arg(arg!(-A --disable_aslr "Disable ASLR on the tracee"))
        .arg(arg!(-M --memory_file <FILE> "the path to write the memory dump to (defaults to <pid>.memory"))
        .arg(
            arg!(-a --attach <TRACEE_PID> "Attach to the given PID for tracing")
                .conflicts_with("disable_aslr")
        )
        .arg(
            arg!([tracee_name] "The program to trace")
                .conflicts_with("memory_file")
                .index(1),
        )
        .arg(
            arg!([tracee_args] "The command-line arguments to execute the tracee with")
                .raw(true)
                .action(ArgAction::Append)
                .index(2),
        )
        .group(
            ArgGroup::new("target")
                .required(true)
                .args(["attach", "tracee_name"]),
        )
}

fn run() -> Result<()> {
    let matches = app().get_matches();
    let tracer = trace::Tracer::from(&matches);

    let mut traces = tracer.trace()?;

    match matches.get_one::<String>("format").unwrap().as_ref() {
        "jsonl" => traces
            .iter()
            .try_for_each(|s| jsonl::write(stdout(), &s).map_err(|e| anyhow!("{:?}", e)))?,
        "tiny86" => traces
            .iter()
            .try_for_each(|s| s.tiny86_write(&mut stdout()))?,
        "tiny86-text" => traces
            .iter()
            .try_for_each(|s| s.bitstring().and_then(|bs| Ok(writeln!(stdout(), "{bs}")?)))?,
        "inst-count" => match traces.count_instructions() {
            Ok(count) => {
                write!(stdout(), "{count}")?;
                stdout().flush()?;
                writeln!(stderr(), " instructions")?;
                stderr().flush()?;
            }
            Err(error) => {
                writeln!(stderr(), "Error counting instructions: {error}")?;
            }
        },
        _ => unreachable!(),
    };

    Ok(())
}

fn main() {
    env_logger::init();

    process::exit(match run() {
        Ok(()) => 0,
        Err(e) => {
            eprintln!("Fatal: {e:#}");
            1
        }
    });
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_app() {
        app().debug_assert();
    }
}
