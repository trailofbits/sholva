//! Syscall models for mttn.
//!
//! These are only used in "Tiny86" tracing mode.

use crate::trace::Step;
use crate::trace::{MemoryHint, MemoryMask, MemoryOp, RegisterFile, SyscallState, Tracee};
use anyhow::{anyhow, Result};
use serde::Serialize;

#[derive(Copy, Clone, Debug, PartialEq, Eq, Serialize)]
#[repr(u8)]
pub enum DecreeSyscall {
    Terminate = 1,
    Transmit = 2,
    Receive = 3,
    Fdwait = 4,
    Allocate = 5,
    Deallocate = 6,
    Random = 7,
}

impl TryFrom<u32> for DecreeSyscall {
    type Error = anyhow::Error;

    fn try_from(syscall: u32) -> Result<Self> {
        Ok(match syscall {
            1 => Self::Terminate,
            2 => Self::Transmit,
            3 => Self::Receive,
            4 => Self::Fdwait,
            5 => Self::Allocate,
            6 => Self::Deallocate,
            7 => Self::Random,
            _ => return Err(anyhow!("unknown DECREE syscall: {}", syscall)),
        })
    }
}

#[derive(Copy, Clone, Debug, PartialEq, Eq, Serialize)]
#[repr(u32)]
/// NOTE: https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscall_32.tbl
pub enum LinuxSyscall {
    Exit = 1,
    Read = 3,
    Write = 4,
    Open = 5,
    Close = 6,
}

impl TryFrom<u32> for LinuxSyscall {
    type Error = anyhow::Error;

    fn try_from(syscall: u32) -> Result<Self> {
        Ok(match syscall {
            1 => Self::Exit,
            3 => Self::Read,
            4 => Self::Write,
            5 => Self::Open,
            6 => Self::Close,
            _ => return Err(anyhow!("unhandled Linux syscall: {}", syscall)),
        })
    }
}

impl TryFrom<DecreeSyscall> for LinuxSyscall {
    type Error = anyhow::Error;

    fn try_from(decree: DecreeSyscall) -> Result<Self> {
        Ok(match decree {
            DecreeSyscall::Receive => LinuxSyscall::Read,
            DecreeSyscall::Transmit => LinuxSyscall::Write,
            DecreeSyscall::Terminate => LinuxSyscall::Exit,
            _ => todo!(),
        })
    }
}

impl TryFrom<MemoryOp> for SyscallState {
    type Error = anyhow::Error;

    fn try_from(op: MemoryOp) -> Result<SyscallState> {
        Ok(match op {
            MemoryOp::Read => SyscallState::Read,
            MemoryOp::Write => SyscallState::Write,
        })
    }
}

pub trait SyscallDFA {
    const POINTER_TRANSITION_BYTES: u32 = 8; // number of pointer bytes offset per syscall transition
    const DATA_TRANSITION_BYTES: u32 = 8; // number of data bytes consumed per syscall transition
    fn transition(&self, syscall: LinuxSyscall, ebx: u32, ecx: u32, edx: u32) -> Result<Vec<Step>>;
}

impl<'a> SyscallDFA for Tracee<'a> {
    fn transition(
        &self,
        syscall: LinuxSyscall,
        ebx: u32, // NOTE(jl): non-`mut`; constant FD for currently supported syscalls.
        mut ecx: u32,
        mut edx: u32,
    ) -> Result<Vec<Step>> {
        // NOTE(jl): assuming a fully Linux-syscall centric approach.
        match syscall {
            LinuxSyscall::Exit => Ok(vec![]),
            LinuxSyscall::Write => {
                log::info!(
                    "write: buffer @{:#04x} of length {} to FD {}",
                    ecx,
                    edx,
                    ebx
                );

                let mut dfa = vec![];
                let mut state = SyscallState::Read;

                while edx > 0 {
                    dfa.push(Step {
                        instr: Default::default(),
                        regs: RegisterFile {
                            s_ebx: ebx,
                            s_ecx: ecx,
                            s_edx: edx,
                            ..Default::default()
                        },
                        hints: vec![MemoryHint {
                            syscall_state: state,
                            ..Default::default()
                        }],
                    });

                    if edx <= Self::DATA_TRANSITION_BYTES {
                        // last transmission, finish.
                        state = SyscallState::Done;
                        ecx += edx; // increment pointer by the remaining size
                        edx -= edx; // consume the remaining bytes
                        log::debug!("write: DONE")
                    } else {
                        ecx += Self::POINTER_TRANSITION_BYTES;
                        edx -= Self::DATA_TRANSITION_BYTES;
                        log::debug!("write: @{:#04x} remaining {}", ecx, edx)
                    }
                }

                Ok(dfa)
            }
            LinuxSyscall::Read => {
                log::info!("read: FD {} of length {} to buffer @{:#04x}", ebx, edx, ecx);

                let mut dfa = vec![];
                let mut state = SyscallState::Write;

                while edx > 0 {
                    dfa.push(
                        // Last receive, finished.
                        Step {
                            instr: Default::default(),
                            regs: RegisterFile {
                                s_ebx: ebx,
                                s_ecx: ecx,
                                s_edx: edx,
                                ..Default::default()
                            },
                            hints: vec![MemoryHint {
                                syscall_state: state,
                                ..Default::default()
                            }],
                        },
                    );

                    if edx <= Self::DATA_TRANSITION_BYTES {
                        // last transmission, finish.
                        state = SyscallState::Done;
                        ecx += edx; // increment pointer by the remaining size
                        edx -= edx; // consume the remaining bytes
                    } else {
                        ecx += Self::POINTER_TRANSITION_BYTES;
                        edx -= Self::DATA_TRANSITION_BYTES;
                    }
                }

                Ok(dfa)
            }
            _ => Err(anyhow!("unhandled DFA transition {:?}", self)),
        }
    }
}
