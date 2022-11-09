use std::io::{stderr, stdout, Write};
use std::process;

use anyhow::{anyhow, Result};
use clap::{Arg, ArgGroup, Command};

mod dump;
mod tiny86;
mod trace;

use tiny86::{Bitstring, Tiny86Write};

fn app() -> Command<'static> {
    Command::new(env!("CARGO_PKG_NAME"))
        .version(env!("CARGO_PKG_VERSION"))
        .about(env!("CARGO_PKG_DESCRIPTION"))
        .arg(
            Arg::new("output-format")
                .help("The output format to use")
                .short('F')
                .long("format")
                .takes_value(true)
                .possible_values(&["jsonl", "tiny86", "tiny86-text", "inst-count"])
                .default_value("jsonl"),
        )
        .arg(
            Arg::new("mode")
                .help("The CPU mode to decode instructions with")
                .short('m')
                .long("mode")
                .takes_value(true)
                .possible_values(&["32", "64"])
                .default_value("64"),
        )
        .arg(
            Arg::new("ignore-unsupported-memops")
                .help("Ignore unsupported memory ops instead of failing")
                .short('I')
                .long("ignore-unsupported-memops"),
        )
        .arg(
            Arg::new("tiny86-only")
                .help("Fail if the tracer encounters x86 functionality that Tiny86 doesn't support")
                .short('t')
                .long("tiny86-only"),
        )
        .arg(
            Arg::new("syscall-model")
                .help("For Tiny86: which syscall model to use when emulating syscalls")
                .long("syscall-model")
                .possible_values(&["decree", "linux32"])
                .default_value("decree")
                .requires("tiny86-only"),
        )
        .arg(
            Arg::new("debug-on-fault")
                .help("Suspend the tracee and detach if a memory access faults")
                .short('d')
                .long("debug-on-fault"),
        )
        .arg(
            Arg::new("disable-aslr")
                .help("Disable ASLR on the tracee")
                .short('A')
                .long("disable-aslr"),
        )
        .arg(
            Arg::new("memory-file")
                .help("the path to write the memory dump to (defaults to <pid>.memory")
                .short('M')
                .long("memory-file")
                .takes_value(true),
        )
        .arg(
            Arg::new("tracee-pid")
                .help("Attach to the given PID for tracing")
                .short('a')
                .long("attach")
                .conflicts_with("disable-aslr")
                .takes_value(true),
        )
        .arg(
            Arg::new("tracee-name")
                .help("The program to trace")
                .conflicts_with("memory-file")
                .index(1),
        )
        .arg(
            Arg::new("tracee-args")
                .help("The command-line arguments to execute the tracee with")
                .raw(true)
                .multiple_values(true)
                .index(2),
        )
        .group(
            ArgGroup::new("target")
                .required(true)
                .args(&["tracee-pid", "tracee-name"]),
        )
}

fn run() -> Result<()> {
    let matches = app().get_matches();
    let tracer = trace::Tracer::from(&matches);

    let mut traces = tracer.trace()?;

    match matches.value_of("output-format").unwrap() {
        "jsonl" => {
            traces.try_for_each(|s| jsonl::write(stdout(), &s?).map_err(|e| anyhow!("{:?}", e)))?
        }
        "tiny86" => traces.try_for_each(|s| s?.tiny86_write(&mut stdout()))?,
        "tiny86-text" => traces.try_for_each(|s| {
            // TODO(ww): Clean this up.
            s?.bitstring()
                .and_then(|bs| Ok(writeln!(stdout(), "{}", bs)?))
        })?,
        "inst-count" => match traces.count_instructions() {
            Ok(count) => {
                write!(stdout(), "{}", count)?;
                stdout().flush()?;
                writeln!(stderr(), " instructions")?;
                stderr().flush()?;
            }
            Err(error) => {
                writeln!(stderr(), "Error counting instructions: {}", error)?;
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
            eprintln!("Fatal: {:#}", e);
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
