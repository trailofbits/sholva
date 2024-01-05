//! Syscall models for mttn.
//!
//! These are only used in "Tiny86" tracing mode.

use crate::trace::Step;
use crate::trace::{LinuxSyscall, MemoryHint, RegisterFile, SyscallState, Tracee};
use anyhow::{anyhow, Result};

pub trait SyscallDFA {
    const POINTER_TRANSITION_BYTES: u32 = 8; // number of pointer bytes offset per syscall transition
    const DATA_TRANSITION_BYTES: u32 = 8; // number of data bytes consumed per syscall transition
    fn transition(&self, syscall: LinuxSyscall, ebx: u32, ecx: u32, edx: u32) -> Result<Vec<Step>>;
}

impl<'a> SyscallDFA for Tracee<'a> {
    fn transition(
        &self,
        syscall: LinuxSyscall,
        mut ebx: u32,
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
            LinuxSyscall::Brk => {
                log::info!("brk: @{:#04x}", ebx);
                Ok(vec![Step {
                    hints: vec![MemoryHint {
                        syscall_state: SyscallState::Done,
                        ..Default::default()
                    }],
                    ..Default::default()
                }])
            }
            LinuxSyscall::Mmap => {
                log::info!("mmap: length {} @{:#04x}", ecx, ebx);
                Ok(vec![Step {
                    hints: vec![MemoryHint {
                        syscall_state: SyscallState::Done,
                        ..Default::default()
                    }],
                    ..Default::default()
                }])
            }
            LinuxSyscall::Munmap => {
                log::info!("munmap: length {} @{:#04x}", ecx, ebx);
                Ok(vec![Step {
                    hints: vec![MemoryHint {
                        syscall_state: SyscallState::Done,
                        ..Default::default()
                    }],
                    ..Default::default()
                }])
            }
            LinuxSyscall::GetRandom => {
                log::info!(
                    "getrandom: buffer @{:#04x} of length {} with flags {}",
                    ebx,
                    ecx,
                    edx
                );

                let mut dfa = vec![];
                let mut state = SyscallState::Write;

                while ecx > 0 {
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

                    if ecx <= Self::DATA_TRANSITION_BYTES {
                        state = SyscallState::Done;
                        ebx += ecx; // increment pointer by the remaining size
                        ecx -= ecx; // consume the remaining bytes
                    } else {
                        ebx += Self::POINTER_TRANSITION_BYTES;
                        ecx -= Self::DATA_TRANSITION_BYTES;
                    }
                }

                Ok(dfa)
            }
            _ => Err(anyhow!("unhandled DFA transition {:?}", self)),
        }
    }
}
