//! Syscall models for mttn.
//!
//! These are only used in "Tiny86" tracing mode.

use crate::trace::Step;
use crate::trace::{MemoryHint, MemoryMask, MemoryOp, RegisterFile, SyscallState, Tracee};
use anyhow::{anyhow, Result};
use itertools::Itertools;
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
    Brk = 45,
    Mmap = 90,
    Munmap = 91,
    GetRandom = 355,
}

impl TryFrom<u32> for LinuxSyscall {
    type Error = anyhow::Error;

    fn try_from(syscall: u32) -> Result<Self> {
        Ok(match syscall {
            1 => Self::Exit,
            3 => Self::Read,
            4 => Self::Write,
            45 => Self::Brk,
            90 => Self::Mmap,
            91 => Self::Munmap,
            355 => Self::GetRandom,
            _ => return Err(anyhow!("unhandled Linux syscall: {}", syscall)),
        })
    }
}

impl TryFrom<DecreeSyscall> for LinuxSyscall {
    type Error = anyhow::Error;

    fn try_from(decree: DecreeSyscall) -> Result<Self> {
        match decree {
            DecreeSyscall::Terminate => Ok(LinuxSyscall::Exit),
            DecreeSyscall::Transmit => Ok(LinuxSyscall::Write),
            DecreeSyscall::Receive => Ok(LinuxSyscall::Read),
            DecreeSyscall::Fdwait => Err(anyhow!("cannot decompose Decree syscall Fdwait!")),
            DecreeSyscall::Allocate => Ok(LinuxSyscall::Mmap),
            DecreeSyscall::Deallocate => Ok(LinuxSyscall::Munmap),
            DecreeSyscall::Random => Ok(LinuxSyscall::GetRandom),
        }
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

impl<'a> Tracee<'a> {
    /// Collect the associated MemoryHints for a given pointer and count.
    /// Decompose into 32-bit (DWord) hints plus a possible leftover Word/Byte hint.
    fn hint_data(
        &self,
        mut ptr: u32,
        mut count: u32,
        operation: MemoryOp,
    ) -> Result<Vec<MemoryHint>> {
        // (1) pre-allocate, count expressed as bytes, hints as 32-bit double-word
        let mut hints = Vec::with_capacity((count / 4 + 1) as usize);

        // (2) generate as many 32-bit hints as possible
        while count >= 4 {
            hints.push(MemoryHint {
                address: ptr as u64,
                operation,
                syscall_state: SyscallState::try_from(operation)?,
                mask: MemoryMask::DWord,
                data: self.tracee_data(u64::from(ptr), MemoryMask::DWord)?,
            });
            count -= 4;
            ptr += 4;
        }

        // (3) generate appropriately sized hint for any remainder
        if let Some(mask) = match count {
            0 => None,
            1 => Some(MemoryMask::Byte),
            2 => Some(MemoryMask::Word),
            3 => Some(MemoryMask::DWord), // NOTE(jl): cannot use straightforward `try_from()` here, explicitly round up 3-bytes.
            _ => unreachable!(),
        } {
            hints.push(MemoryHint {
                address: u64::from(ptr),
                operation,
                syscall_state: SyscallState::try_from(operation)?,
                mask,
                data: self.tracee_data(u64::from(ptr), mask)?,
            });
        }

        Ok(hints)
    }
}

pub trait SyscallDFA {
    const POINTER_TRANSITION_BYTES: u32 = 8; // number of pointer bytes offset per syscall transition
    const DATA_TRANSITION_BYTES: u32 = 8; // number of data bytes consumed per syscall transition
    fn syscall_model(
        &self,
        syscall: LinuxSyscall,
        rax_return: u32,
        ebx: u32,
        ecx: u32,
        edx: u32,
    ) -> Result<Vec<Step>>;
}

impl<'a> SyscallDFA for Tracee<'a> {
    fn syscall_model(
        &self,
        syscall: LinuxSyscall,
        rax_return: u32,
        mut ebx: u32,
        mut ecx: u32,
        mut edx: u32,
    ) -> Result<Vec<Step>> {
        // NOTE(jl): assuming a fully Linux-syscall centric approach.
        match syscall {
            LinuxSyscall::Exit => Ok(vec![]),
            // ssize_t read(int fd, void buf[.count], size_t count);
            LinuxSyscall::Read => {
                log::info!("read: FD {} of length {} to buffer @{:#04x}", ebx, edx, ecx);

                let mut dfa = vec![];
                let memory_hints = self.hint_data(ecx, edx, MemoryOp::Write)?;
                for memory_hint_chunk in &memory_hints.iter().cloned().chunks(2) {
                    let regs = RegisterFile {
                        s_ebx: ebx,
                        s_ecx: ecx,
                        s_edx: edx,
                        ..Default::default()
                    };

                    dfa.push(Step {
                        regs,
                        hints: memory_hint_chunk.collect(),
                        ..Default::default()
                    });

                    ecx = ecx.wrapping_add(Self::POINTER_TRANSITION_BYTES);
                    edx = edx.wrapping_sub(Self::DATA_TRANSITION_BYTES);
                }

                Ok(dfa)
            }
            // ssize_t write(int fd, const void buf[.count], size_t count);
            LinuxSyscall::Write => {
                log::info!(
                    "write: buffer @{:#04x} of length {} to FD {}",
                    ecx,
                    edx,
                    ebx
                );

                let mut dfa = vec![];
                let memory_hints = self.hint_data(ecx, edx, MemoryOp::Read)?;
                for memory_hint_chunk in &memory_hints.iter().cloned().chunks(2) {
                    let regs = RegisterFile {
                        s_ebx: ebx,
                        s_ecx: ecx,
                        s_edx: edx,
                        ..Default::default()
                    };

                    dfa.push(Step {
                        regs,
                        hints: memory_hint_chunk.collect(),
                        ..Default::default()
                    });

                    ecx = ecx.wrapping_add(Self::POINTER_TRANSITION_BYTES);
                    edx = edx.wrapping_sub(Self::DATA_TRANSITION_BYTES);
                }

                Ok(dfa)
            }
            // int brk(void *addr);
            LinuxSyscall::Brk => {
                log::info!("brk: @{:#04x}", ebx);
                Ok(vec![Step {
                    regs: RegisterFile {
                        rax: rax_return as u64,
                        ..Default::default()
                    },
                    hints: vec![MemoryHint {
                        syscall_state: SyscallState::Done,
                        ..Default::default()
                    }],
                    ..Default::default()
                }])
            }
            // void *mmap(void addr[.length], size_t length, int prot, int flags, int fd, off_t offset);
            LinuxSyscall::Mmap => {
                log::info!("mmap: length {} @{:#04x}", ecx, ebx);
                Ok(vec![Step {
                    regs: RegisterFile {
                        rax: rax_return as u64,
                        ..Default::default()
                    },
                    hints: vec![MemoryHint {
                        syscall_state: SyscallState::Done,
                        ..Default::default()
                    }],
                    ..Default::default()
                }])
            }
            // int munmap(void addr[.length], size_t length);
            LinuxSyscall::Munmap => {
                log::info!("munmap: length {} @{:#04x}", ecx, ebx);
                Ok(vec![Step {
                    regs: RegisterFile {
                        rax: rax_return as u64,
                        ..Default::default()
                    },
                    hints: vec![MemoryHint {
                        syscall_state: SyscallState::Done,
                        ..Default::default()
                    }],
                    ..Default::default()
                }])
            }
            // ssize_t getrandom(void buf[.buflen], size_t buflen, unsigned int flags);
            LinuxSyscall::GetRandom => {
                log::info!(
                    "getrandom: buffer @{:#04x} of length {} with flags {}",
                    ebx,
                    ecx,
                    edx
                );

                let mut dfa = vec![];
                let memory_hints = self.hint_data(ebx, ecx, MemoryOp::Write)?;
                for memory_hint_chunk in &memory_hints.iter().cloned().chunks(2) {
                    let regs = RegisterFile {
                        s_ebx: ebx,
                        s_ecx: ecx,
                        s_edx: edx,
                        ..Default::default()
                    };

                    dfa.push(Step {
                        regs,
                        hints: memory_hint_chunk.collect(),
                        ..Default::default()
                    });

                    ebx = ecx.wrapping_add(Self::POINTER_TRANSITION_BYTES);
                    ecx = edx.wrapping_sub(Self::DATA_TRANSITION_BYTES);
                }

                Ok(dfa)
            }
        }
    }
}
