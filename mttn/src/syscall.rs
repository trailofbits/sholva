//! Syscall models for mttn.
//!
//! These are only used in "Tiny86" tracing mode.

use crate::trace::Step;
use crate::trace::{DecreeSyscall, Tracee};
use anyhow::{anyhow, Result};

pub trait SyscallDFA {
    fn transition(&self, syscall: DecreeSyscall, rbx: u64, rcx: u64, rdx: u64)
        -> Result<Vec<Step>>;
}

impl<'a> SyscallDFA for Tracee<'a> {
    fn transition(
        &self,
        syscall: DecreeSyscall,
        rbx: u64,
        rcx: u64,
        rdx: u64,
    ) -> Result<Vec<Step>> {
        match syscall {
            DecreeSyscall::Terminate => Ok(vec![]),
            DecreeSyscall::Transmit => {
                log::debug!(
                    "transmit: buffer @{:#04x} of length {} to FD {}",
                    rcx,
                    rdx,
                    rbx
                );
                Ok(vec![Step {
                    instr: Default::default(),
                    regs: Default::default(),
                    hints: Default::default(),
                }])
            }
            DecreeSyscall::Receive => {
                let fd = rbx;
                let buf = rcx;
                let count = rdx;
                log::debug!(
                    "recieve: FD {} of length {} to buffer @{:#04x}",
                    fd,
                    count,
                    buf
                );

                todo!()
            }
            _ => Err(anyhow!("unhandled DFA transition {:?}", self)),
        }
    }
}
