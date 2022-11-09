use std::convert::{TryFrom, TryInto};
use std::io::IoSliceMut;
use std::os::unix::process::CommandExt;
use std::process::Command;

use anyhow::{anyhow, Context, Result};
use derivative::Derivative;
use iced_x86::{
    Code, Decoder, DecoderOptions, Instruction, InstructionInfoFactory, InstructionInfoOptions,
    MemorySize, Mnemonic, OpAccess, Register,
};
use nix::errno::Errno;
use nix::sys::personality::{self, Persona};
use nix::sys::ptrace;
use nix::sys::signal;
use nix::sys::uio;
use nix::sys::wait;
use nix::unistd::Pid;
use serde::Serialize;
use spawn_ptrace::CommandPtraceSpawn;

use crate::dump;

const MAX_INSTR_LEN: usize = 15;
const RFLAGS_RESERVED_MASK: u64 = 2;
const RFLAGS_IF_MASK: u64 = 512;

pub trait CommandPersonality {
    fn personality(&mut self, persona: Persona);
}

impl CommandPersonality for Command {
    fn personality(&mut self, persona: Persona) {
        unsafe { self.pre_exec(move || Ok(personality::set(persona).map(|_| ())?)) };
    }
}

#[derive(Copy, Clone, Debug, PartialEq, Eq, Serialize)]
#[repr(u8)]
pub enum DecreeSyscall {
    Terminate = 1,
    Transmit = 2,
    Recieve = 3,
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
            3 => Self::Recieve,
            4 => Self::Fdwait,
            5 => Self::Allocate,
            6 => Self::Deallocate,
            7 => Self::Random,
            _ => return Err(anyhow!("unknown DECREE syscall: {}", syscall)),
        })
    }
}

/// Represents the width of a concrete memory operation.
///
/// All `mttn` memory operations are 1, 2, 4, or 8 bytes.
/// Larger operations are either modeled as multiple individual operations
/// (if caused by a `REP` prefix), ignored (if configured), or cause a fatal error.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize)]
#[repr(u8)]
pub enum MemoryMask {
    Byte,
    Word,
    DWord,
    QWord,
}

impl MemoryMask {
    pub fn as_size(&self) -> usize {
        match *self {
            MemoryMask::Byte => 1,
            MemoryMask::Word => 2,
            MemoryMask::DWord => 4,
            MemoryMask::QWord => 8,
        }
    }
}

impl TryFrom<u64> for MemoryMask {
    type Error = anyhow::Error;

    fn try_from(size: u64) -> Result<Self> {
        Ok(match size {
            1 => MemoryMask::Byte,
            2 => MemoryMask::Word,
            4 => MemoryMask::DWord,
            8 => MemoryMask::QWord,
            _ => return Err(anyhow!("size {} doesn't have a supported mask", size)),
        })
    }
}

impl TryFrom<Register> for MemoryMask {
    type Error = anyhow::Error;

    fn try_from(reg: Register) -> Result<Self> {
        (reg.info().size() as u64).try_into()
    }
}

/// The access disposition of a concrete memory operation.
///
/// All `mttn` operations are either `Read` or `Write`. Instructions that
/// perform a read-and-update are modeled with two separate operations.
/// Instructions that perform conditional reads or writes are modeled only
/// if the conditional memory operation actually took place during the trace.
#[derive(Clone, Copy, Debug, PartialEq, Eq, Serialize)]
#[repr(u8)]
pub enum MemoryOp {
    Read,
    Write,
}

/// Represents an entire traced memory operation, including its kind (`MemoryOp`),
/// size (`MemoryMask`), concrete address, and actual read or written data.
#[derive(Clone, Debug, PartialEq, Eq, Serialize)]
pub struct MemoryHint {
    pub address: u64,
    pub operation: MemoryOp,
    pub mask: MemoryMask,
    pub data: Vec<u8>,
}

/// Represents an individual step in the trace, including the raw instruction bytes,
/// the register file state before execution, and any memory operations that result
/// from execution.
#[derive(Debug, PartialEq, Eq, Serialize)]
pub struct Step {
    pub instr: Vec<u8>,
    pub regs: RegisterFile,
    pub hints: Vec<MemoryHint>,
}

/// Represents the (usermode) register file.
///
/// Only the standard addressable registers, plus `RFLAGS`, are recorded.
///
/// Other registers are tracked as an implementation detail, but are not
/// recorded in each trace step.
#[derive(Clone, Copy, Debug, Default, Derivative, PartialEq, Eq, Serialize)]
pub struct RegisterFile {
    pub rax: u64,
    pub rbx: u64,
    pub rcx: u64,
    pub rdx: u64,
    pub rsi: u64,
    pub rdi: u64,
    pub rsp: u64,
    pub rbp: u64,
    pub r8: u64,
    pub r9: u64,
    pub r10: u64,
    pub r11: u64,
    pub r12: u64,
    pub r13: u64,
    pub r14: u64,
    pub r15: u64,
    pub rip: u64,
    // NOTE(ww): The second bit of RFLAGS is always high.
    #[derivative(Default(value = "2"))]
    pub rflags: u64,
    pub fs_base: u64,
    pub gs_base: u64,
    // TODO: Are this needed?
    pub orig_rax: u64,
    pub cs: u64,
    pub ds: u64,
    pub es: u64,
    pub fs: u64,
    pub gs: u64,
    pub ss: u64,
}

impl RegisterFile {
    /// Given a symbolic iced-x86 register, concretize it against the register file.
    /// Narrows the result, as appropriate.
    ///
    /// Untracked registers result in an `Err` result.
    fn value(&self, reg: Register) -> Result<u64> {
        match reg {
            // 8 bit regs.
            Register::AL => Ok((self.rax as u8).into()),
            Register::BL => Ok((self.rbx as u8).into()),
            Register::CL => Ok((self.rcx as u8).into()),
            Register::DL => Ok((self.rdx as u8).into()),
            Register::AH => Ok(((self.rax >> 8) as u8).into()),
            Register::BH => Ok(((self.rbx >> 8) as u8).into()),
            Register::CH => Ok(((self.rcx >> 8) as u8).into()),
            Register::DH => Ok(((self.rdx >> 8) as u8).into()),
            Register::R8L => Ok((self.r8 as u8).into()),
            Register::R9L => Ok((self.r9 as u8).into()),
            Register::R10L => Ok((self.r10 as u8).into()),
            Register::R11L => Ok((self.r11 as u8).into()),
            Register::R12L => Ok((self.r12 as u8).into()),
            Register::R13L => Ok((self.r13 as u8).into()),
            Register::R14L => Ok((self.r14 as u8).into()),
            Register::R15L => Ok((self.r15 as u8).into()),

            // 16 bit regs.
            Register::AX => Ok((self.rax as u16).into()),
            Register::BX => Ok((self.rbx as u16).into()),
            Register::CX => Ok((self.rcx as u16).into()),
            Register::DX => Ok((self.rdx as u16).into()),
            Register::SI => Ok((self.rsi as u16).into()),
            Register::DI => Ok((self.rdi as u16).into()),
            Register::SP => Ok((self.rsp as u16).into()),
            Register::BP => Ok((self.rbp as u16).into()),
            Register::R8W => Ok((self.r8 as u16).into()),
            Register::R9W => Ok((self.r9 as u16).into()),
            Register::R10W => Ok((self.r10 as u16).into()),
            Register::R11W => Ok((self.r11 as u16).into()),
            Register::R12W => Ok((self.r12 as u16).into()),
            Register::R13W => Ok((self.r13 as u16).into()),
            Register::R14W => Ok((self.r14 as u16).into()),
            Register::R15W => Ok((self.r15 as u16).into()),

            // 32 bit regs.
            Register::EAX => Ok((self.rax as u32).into()),
            Register::EBX => Ok((self.rbx as u32).into()),
            Register::ECX => Ok((self.rcx as u32).into()),
            Register::EDX => Ok((self.rdx as u32).into()),
            Register::ESI => Ok((self.rsi as u32).into()),
            Register::EDI => Ok((self.rdi as u32).into()),
            Register::ESP => Ok((self.rsp as u32).into()),
            Register::EBP => Ok((self.rbp as u32).into()),
            Register::R8D => Ok((self.r8 as u32).into()),
            Register::R9D => Ok((self.r9 as u32).into()),
            Register::R10D => Ok((self.r10 as u32).into()),
            Register::R11D => Ok((self.r11 as u32).into()),
            Register::R12D => Ok((self.r12 as u32).into()),
            Register::R13D => Ok((self.r13 as u32).into()),
            Register::R14D => Ok((self.r14 as u32).into()),
            Register::R15D => Ok((self.r15 as u32).into()),
            Register::EIP => Ok((self.rip as u32).into()),

            // 64 bit regs.
            Register::RAX => Ok(self.rax),
            Register::RBX => Ok(self.rbx),
            Register::RCX => Ok(self.rcx),
            Register::RDX => Ok(self.rdx),
            Register::RSI => Ok(self.rsi),
            Register::RDI => Ok(self.rdi),
            Register::RSP => Ok(self.rsp),
            Register::RBP => Ok(self.rbp),
            Register::R8 => Ok(self.r8),
            Register::R9 => Ok(self.r9),
            Register::R10 => Ok(self.r10),
            Register::R11 => Ok(self.r11),
            Register::R12 => Ok(self.r12),
            Register::R13 => Ok(self.r13),
            Register::R14 => Ok(self.r14),
            Register::R15 => Ok(self.r15),
            Register::RIP => Ok(self.rip),

            // FS and GS: We support these because Linux uses them for TLS.
            // We return the FSBASE and GSBASE values here, since we're returning by address
            // and not by descriptor value.
            Register::FS => Ok(self.fs_base),
            Register::GS => Ok(self.gs_base),

            // All other segment registers are treated as 0, per the Tiny86 model.
            Register::SS | Register::CS | Register::DS | Register::ES => Ok(0),

            // Everything else (vector regs, control regs, debug regs, etc) is unsupported.
            // NOTE(ww): We track rflags in this struct, but iced-x86 doesn't have a Register
            // variant for it (presumably because it's unaddressable).
            _ => Err(anyhow!("untracked register requested: {:?}", reg)),
        }
    }
}

impl From<libc::user_regs_struct> for RegisterFile {
    fn from(user_regs: libc::user_regs_struct) -> Self {
        Self {
            rax: user_regs.rax,
            rbx: user_regs.rbx,
            rcx: user_regs.rcx,
            rdx: user_regs.rdx,
            rsi: user_regs.rsi,
            rdi: user_regs.rdi,
            rsp: user_regs.rsp,
            rbp: user_regs.rbp,
            r8: user_regs.r8,
            r9: user_regs.r9,
            r10: user_regs.r10,
            r11: user_regs.r11,
            r12: user_regs.r12,
            r13: user_regs.r13,
            r14: user_regs.r14,
            r15: user_regs.r15,
            rip: user_regs.rip,
            rflags: user_regs.eflags,
            fs_base: user_regs.fs_base,
            gs_base: user_regs.gs_base,
            orig_rax: user_regs.orig_rax,
            cs: user_regs.cs,
            ds: user_regs.ds,
            es: user_regs.es,
            fs: user_regs.fs,
            gs: user_regs.gs,
            ss: user_regs.ss,
        }
    }
}

impl From<&RegisterFile> for libc::user_regs_struct {
    fn from(regfile: &RegisterFile) -> Self {
        Self {
            rax: regfile.rax,
            rbx: regfile.rbx,
            rcx: regfile.rcx,
            rdx: regfile.rdx,
            rsi: regfile.rsi,
            rdi: regfile.rdi,
            rsp: regfile.rsp,
            rbp: regfile.rbp,
            r8: regfile.r8,
            r9: regfile.r9,
            r10: regfile.r10,
            r11: regfile.r11,
            r12: regfile.r12,
            r13: regfile.r13,
            r14: regfile.r14,
            r15: regfile.r15,
            rip: regfile.rip,
            eflags: regfile.rflags,
            fs_base: regfile.fs_base,
            gs_base: regfile.gs_base,
            orig_rax: regfile.orig_rax,
            cs: regfile.cs,
            ds: regfile.ds,
            es: regfile.es,
            fs: regfile.fs,
            gs: regfile.gs,
            ss: regfile.ss,
        }
    }
}

/// Represents a valid target for a `Tracer`.
///
/// The currently valid targets are `Program`s (which haven't been spawned yet)
/// and already-spawned `Process`es.
#[derive(Debug)]
pub enum Target {
    Program(String, Vec<String>),
    Process(Pid),
}

/// Represents an actively traced program, in some indeterminate state.
///
/// Tracees are associated with their parent `Tracer`.
pub struct Tracee<'a> {
    terminated: bool,
    tracee_pid: Pid,
    tracer: &'a Tracer,
    info_factory: InstructionInfoFactory,
    register_file: RegisterFile,
}

impl<'a> Tracee<'a> {
    /// Create a new `Tracee` from the given PID (presumably either spawned with `PTRACE_TRACEME`
    /// or recently attached to) and `Tracer`.
    fn new(tracee_pid: Pid, tracer: &'a Tracer) -> Self {
        #[allow(clippy::redundant_field_names)]
        Self {
            terminated: false,
            tracee_pid: tracee_pid,
            tracer: tracer,
            info_factory: InstructionInfoFactory::new(),
            register_file: Default::default(),
        }
    }

    /// Count the total number of instructions in the trace by stepping the tracee forwards
    /// one instruction at a time, but _without_ modeling memory. After calling this function,
    /// `self.terminated` will be `true` and this `Tracee` will be an empty `Step` iterator.
    pub fn count_instructions(mut self) -> Result<usize> {
        let mut count: usize = 0;

        if self.tracer.tiny86_only {
            // we need to do a full trace, modeling memory
            while !self.terminated {
                self.step()?;
                count += 1;
            }
        } else {
            // we just need to count the number of ptrace steps until the process terminates
            while !self.terminated {
                ptrace::step(self.tracee_pid, None)?;

                count += 1;

                self.wait()?
            }
        }

        Ok(count)
    }

    fn wait(&mut self) -> Result<()> {
        match wait::waitpid(self.tracee_pid, None)? {
            wait::WaitStatus::Exited(_, status) => {
                log::debug!("exited with {}", status);
                self.terminated = true;
            }
            wait::WaitStatus::Signaled(_, signal, _) => {
                log::debug!("signaled: {:?}", signal);

                // We might be receiving a SIGKILL because our parent has killed
                // us; this can happen in normal operation because of how
                // we currently model DECREE's terminate(2) syscall.
                if signal == signal::Signal::SIGKILL {
                    self.terminated = true;
                }
            }
            wait::WaitStatus::Stopped(_, signal) => {
                log::debug!("stopped with {:?}", signal);
            }
            wait::WaitStatus::StillAlive => {
                log::debug!("still alive");
            }
            s => {
                log::debug!("terminating with {:?}", s);
                self.terminated = true;
            }
        }
        Ok(())
    }

    /// Step the tracee forwards by one instruction, returning the trace `Step` or
    /// an `Err` if an internal tracing step fails.
    fn step(&mut self) -> Result<Step> {
        self.tracee_regs()?;
        let (instr, instr_bytes) = self.tracee_instr()?;

        if self.tracer.tiny86_only {
            self.tiny86_checks(&instr)?;
        }

        let mut hints = vec![];

        if self.tracer.tiny86_only && instr.mnemonic() == Mnemonic::Int {
            log::debug!("tiny86: entering syscall");

            // We only support INT 80h, since that's the standard syscall
            // vector on 32-bit Linux.
            if instr.immediate8() != 0x80 {
                return Err(anyhow!("invalid interrupt: not syscall"));
            }

            let syscall = self.register_file.rax;
            log::debug!("requested syscall {}", syscall);

            self.do_syscall(&instr, syscall as u32)?;
        } else {
            // Hints are generated in two phases: we build a complete list of
            // expected hints (including all Read hints) in stage 1...
            self.tracee_hints_stage1(&instr, &mut hints)?;

            // TODO(ww): Check `instr` here and perform one of two cases:
            // 1. If `instr` is an instruction that benefits from modeling/emulation
            //    (e.g. `MOVS`), then emulate it and generate its memory hints
            //    from the emulation.
            // 2. Otherwise, generate the hints as normal (do phase 1, single-step,
            //    then phase 2).
            ptrace::step(self.tracee_pid, None)?;

            if instr.is_string_instruction() || instr.is_stack_instruction() {
                // NOTE(ww): By default, recent-ish x86 CPUs execute MOVS and STOS
                // in "fast string operation" mode. This can cause stores to not appear
                // when we expect them to, since they can be executed out-of-order.
                // The "correct" fix for this is probably to toggle the
                // fast-string-enable bit (0b) in the IA32_MISC_ENABLE MSR, but we just sleep
                // for a bit to give the CPU a chance to catch up.
                // TODO(ww): Longer term, we should just model REP'd instructions outright.
                std::thread::sleep(std::time::Duration::from_millis(5));
            }

            // ...then, after we've stepped the program, we fill in the data
            // associated with each Write hint in stage 2.
            self.tracee_hints_stage2(&mut hints)?;
        }

        self.wait()?;

        #[allow(clippy::redundant_field_names)]
        Ok(Step {
            instr: instr_bytes,
            regs: self.register_file,
            hints: hints,
        })
    }

    fn do_syscall(&mut self, instr: &Instruction, syscall: u32) -> Result<()> {
        if self.tracer.decree_syscalls {
            let syscall = DecreeSyscall::try_from(syscall)?;
            log::debug!("selected {:?}", syscall);

            match syscall {
                DecreeSyscall::Terminate => ptrace::kill(self.tracee_pid)?,
                _ => return Err(anyhow!("unimplemented DECREE syscall: {:?}", syscall)),
            }
        } else {
            // Linux x86 syscalls.
            return Err(anyhow!("Linux syscalls are completely unimplemented!"));
        }

        // Jump right over the syscall.
        let mut user_regs = libc::user_regs_struct::from(&self.register_file);
        user_regs.rip += instr.len() as u64;
        log::debug!("jumping to: {:x}", user_regs.rip);

        // We might have killed the program immediately above, in which case
        // this will fail with ESRCH because the process has disappeared.
        // This is an expected case, so we swallow the error and expect
        // the calling context to handle the process exit cleanly.
        match ptrace::setregs(self.tracee_pid, user_regs) {
            Ok(_) => ptrace::step(self.tracee_pid, None)
                .with_context(|| "Fault: resuming program after syscall")?,
            Err(Errno::ESRCH) => {
                log::debug!("process disappeared!")
            }
            Err(e) => return Err(e.into()),
        };

        Ok(())
    }

    /// Loads the our register file from the tracee's user register state.
    fn tracee_regs(&mut self) -> Result<()> {
        self.register_file = RegisterFile::from(ptrace::getregs(self.tracee_pid)?);

        if self.tracer.tiny86_only {
            // The IF flag is purely a remnant of our tracer (since we're single-stepping),
            // so clear it for maximum fidelity when we're tracing for Tiny86.
            self.register_file.rflags &= !RFLAGS_IF_MASK;

            // Similarly: `ptrace(PTRACE_GETREGS, ...)` seems to be slightly bugged on
            // x86-64 Linux, and returns `rflags: 0` at process start. This
            // is architecturally impossible (`rflags >= 2` because of the reserved bit),
            // so we just fix it up here.
            self.register_file.rflags |= RFLAGS_RESERVED_MASK;
        }

        Ok(())
    }

    /// Returns the iced-x86 `Instruction` and raw instruction bytes at the tracee's
    /// current instruction pointer.
    fn tracee_instr(&self) -> Result<(Instruction, Vec<u8>)> {
        let mut bytes = vec![0u8; MAX_INSTR_LEN];
        let remote_iov = uio::RemoteIoVec {
            base: self.register_file.rip as usize,
            len: MAX_INSTR_LEN,
        };

        // TODO(ww): Check the length here.
        uio::process_vm_readv(
            self.tracee_pid,
            &mut [IoSliceMut::new(&mut bytes)],
            &[remote_iov],
        )?;

        log::debug!(
            "fetched instruction bytes: {:?} from {:#x}",
            bytes,
            self.register_file.rip
        );

        let mut decoder = Decoder::new(self.tracer.bitness, &bytes, DecoderOptions::NONE);
        decoder.set_ip(self.register_file.rip);

        // TODO(ww): Use decode_out with a `self.instr` here, to avoid a copy.
        let instr = decoder.decode();
        log::debug!("instr: {:?}", instr.code());

        match instr.code() {
            Code::INVALID => Err(anyhow!("invalid instruction")),
            _ => {
                bytes.truncate(instr.len());
                Ok((instr, bytes))
            }
        }
    }

    /// Reads a piece of the tracee's memory, starting at `addr`.
    fn tracee_data(&self, addr: u64, mask: MemoryMask) -> Result<Vec<u8>> {
        log::debug!("attempting to read tracee @ 0x{:x} ({:?})", addr, mask);

        // NOTE(ww): Could probably use ptrace::read() here since we're always <= 64 bits,
        // but I find process_vm_readv a little more readable.
        let mut bytes = vec![0u8; mask.as_size()];
        let remote_iov = uio::RemoteIoVec {
            base: addr as usize,
            len: mask.as_size(),
        };

        // NOTE(ww): A failure here indicates a bug in the tracer, not the tracee.
        // In particular it indicates that we either (1) calculated the effective
        // address incorrectly, or (2) calculated the mask incorrectly.
        if let Err(e) = uio::process_vm_readv(
            self.tracee_pid,
            &mut [IoSliceMut::new(&mut bytes)],
            &[remote_iov],
        ) {
            if self.tracer.debug_on_fault {
                log::error!(
                    "Suspending the tracee ({}), detaching and exiting",
                    self.tracee_pid
                );
                ptrace::detach(self.tracee_pid, Some(signal::Signal::SIGSTOP))?;
            }

            return Err(e).with_context(|| format!("Fault: size: {:?}, address: {:x}", mask, addr));
        } else {
            log::debug!("fetched data bytes: {:?}", bytes);
        }

        Ok(bytes)
    }

    /// Given a string instruction (e.g., `MOVS`, `LODS`) variant, return its
    /// expected memory mask (i.e., the size in bytes that one execution
    /// reads and/or writes).
    fn mask_from_str_instr(&self, instr: &Instruction) -> Result<MemoryMask> {
        Ok(match instr.mnemonic() {
            Mnemonic::Lodsb
            | Mnemonic::Stosb
            | Mnemonic::Movsb
            | Mnemonic::Cmpsb
            | Mnemonic::Scasb => MemoryMask::Byte,
            Mnemonic::Lodsw
            | Mnemonic::Stosw
            | Mnemonic::Movsw
            | Mnemonic::Cmpsw
            | Mnemonic::Scasw => MemoryMask::Word,
            Mnemonic::Lodsd
            | Mnemonic::Stosd
            | Mnemonic::Movsd
            | Mnemonic::Cmpsd
            | Mnemonic::Scasd => MemoryMask::DWord,
            Mnemonic::Lodsq
            | Mnemonic::Stosq
            | Mnemonic::Movsq
            | Mnemonic::Cmpsq
            | Mnemonic::Scasq => MemoryMask::QWord,
            _ => return Err(anyhow!("unknown mask for instruction: {:?}", instr.code())),
        })
    }

    fn tracee_hints_stage1(
        &mut self,
        instr: &Instruction,
        hints: &mut Vec<MemoryHint>,
    ) -> Result<()> {
        log::debug!("memory hints stage 1");
        let info = self
            .info_factory
            .info_options(instr, InstructionInfoOptions::NO_REGISTER_USAGE)
            .clone();

        for used_mem in info.used_memory() {
            log::debug!("{:?}", used_mem);

            // We model writebacks as two separate memory ops, so split them up here.
            // Also: all conditional reads and writes are in fact real reads and writes,
            // since we're single-stepping through REP'd instructions.
            let ops: &[MemoryOp] = match used_mem.access() {
                OpAccess::Read => &[MemoryOp::Read],
                OpAccess::CondRead => &[MemoryOp::Read],
                OpAccess::Write => &[MemoryOp::Write],
                OpAccess::CondWrite => &[MemoryOp::Write],
                OpAccess::ReadWrite => &[MemoryOp::Read, MemoryOp::Write],
                OpAccess::ReadCondWrite => &[MemoryOp::Read, MemoryOp::Write],
                op => return Err(anyhow!("unsupported memop: {:?}", op)),
            };

            let mask = match used_mem.memory_size() {
                MemorySize::UInt8 | MemorySize::Int8 => MemoryMask::Byte,
                MemorySize::UInt16 | MemorySize::Int16 | MemorySize::WordOffset => MemoryMask::Word,
                MemorySize::UInt32 | MemorySize::Int32 | MemorySize::DwordOffset => {
                    MemoryMask::DWord
                }
                MemorySize::UInt64 | MemorySize::Int64 => MemoryMask::QWord,
                MemorySize::Unknown => self.mask_from_str_instr(instr)?,
                size => {
                    if self.tracer.ignore_unsupported_memops {
                        log::warn!(
                            "unsupported memop size: {:?}: not generating a memory hint",
                            size
                        );
                        continue;
                    } else {
                        return Err(anyhow!("unsupported memsize: {:?}", size));
                    }
                }
            };

            let mut addr = used_mem
                .try_virtual_address(0, |reg, _, _| self.register_file.value(reg).ok())
                .ok_or_else(|| anyhow!("effective address calculation failed"))?;

            // NOTE(ww): If we're tracing a 32-bit program, truncate the effective
            // address back down to 32 bits. This is almost never necessary, except
            // for when a particular computed address overflows into the higher bits.
            // The latter has happened with the segments that we *do* support.
            if self.tracer.bitness == 32 {
                addr = (addr as u32).into();
            }

            log::debug!("effective virtual addr: {:#x}", addr);

            for op in ops {
                let data = match op {
                    MemoryOp::Read => self.tracee_data(addr, mask)?,
                    MemoryOp::Write => Vec::new(),
                };

                #[allow(clippy::redundant_field_names)]
                hints.push(MemoryHint {
                    address: addr,
                    operation: *op,
                    mask: mask,
                    data: data,
                });
            }
        }

        Ok(())
    }

    fn tracee_hints_stage2(&self, hints: &mut [MemoryHint]) -> Result<()> {
        log::debug!("memory hints stage 2");

        for hint in hints.iter_mut() {
            if hint.operation != MemoryOp::Write {
                continue;
            }

            let data = self.tracee_data(hint.address, hint.mask)?;
            hint.data = data;
        }

        Ok(())
    }

    fn tiny86_checks(&self, instr: &Instruction) -> Result<()> {
        let info = instr.op_code();

        // Tiny86 instructions must be valid in a 32-bit mode.
        if !info.mode32() {
            return Err(anyhow!(
                "Tiny86 invariant failure: {:?} is not valid in 32-bit mode",
                &instr
            ));
        }

        // We don't support 16-bit addressing in Tiny86.
        // NOTE(ww): Checking != 32 doesn't work here, since address_size() can be
        // 0 for instructions that don't require any addressing.
        if info.address_size() == 16 {
            return Err(anyhow!(
                "Tiny86 invariant failure: non 32-bit addressing is not supported ({:?})",
                &instr
            ));
        }

        Ok(())
    }
}

impl Iterator for Tracee<'_> {
    type Item = Result<Step>;

    fn next(&mut self) -> Option<Self::Item> {
        if self.terminated {
            None
        } else {
            Some(self.step())
        }
    }
}

#[derive(Debug)]
pub struct Tracer {
    pub ignore_unsupported_memops: bool,
    pub tiny86_only: bool,
    pub decree_syscalls: bool,
    pub debug_on_fault: bool,
    pub disable_aslr: bool,
    pub bitness: u32,
    pub target: Target,
}

impl From<&clap::ArgMatches> for Tracer {
    fn from(matches: &clap::ArgMatches) -> Self {
        let target = if let Some(pid) = matches.value_of("tracee-pid") {
            let pid = Pid::from_raw(pid.parse().unwrap());

            // If we're starting from a PID, then we need to create
            // a dump of the current memory state. Do that now.
            let dump_name = matches
                .value_of("memory-file")
                .map(Into::into)
                .unwrap_or_else(|| format!("{}.memory", pid));

            // There's no sense in proceeding if the dump fails.
            dump::dump(pid, &dump_name).unwrap();

            Target::Process(pid)
        } else {
            Target::Program(
                matches.value_of("tracee-name").map(Into::into).unwrap(),
                matches
                    .values_of("tracee-args")
                    .map(|v| v.map(|a| a.to_string()).collect())
                    .unwrap_or_else(Vec::new),
            )
        };

        #[allow(clippy::redundant_field_names)]
        Self {
            ignore_unsupported_memops: matches.is_present("ignore-unsupported-memops"),
            tiny86_only: matches.is_present("tiny86-only"),
            decree_syscalls: matches.value_of("syscall-model").unwrap() == "decree",
            debug_on_fault: matches.is_present("debug-on-fault"),
            disable_aslr: matches.is_present("disable-aslr"),
            bitness: matches.value_of("mode").unwrap().parse().unwrap(),
            target: target,
        }
    }
}

impl Tracer {
    pub fn trace(&self) -> Result<Tracee> {
        let tracee_pid = match &self.target {
            Target::Program(name, args) => {
                let child = {
                    let mut cmd = Command::new(name);
                    cmd.args(args);

                    if self.disable_aslr {
                        cmd.personality(Persona::ADDR_NO_RANDOMIZE);
                    }

                    cmd.spawn_ptrace()?
                };

                log::debug!("spawned {} for tracing as child {}", name, child.id());

                Pid::from_raw(child.id() as i32)
            }
            Target::Process(pid) => {
                ptrace::attach(*pid).with_context(|| format!("couldn't attach to {}", pid))?;
                *pid
            }
        };

        // Our tracee is now live and ready to be traced, but in a stopped state.
        // We set PTRACE_O_TRACEEXIT on it to make sure it stops right before
        // finally exiting, giving us one last chance to do some inspection.
        ptrace::setoptions(tracee_pid, ptrace::Options::PTRACE_O_TRACEEXIT)?;

        Ok(Tracee::new(tracee_pid, self))
    }
}

#[cfg(test)]
mod tests {
    use std::path::PathBuf;

    use super::*;

    fn dummy_regs() -> RegisterFile {
        RegisterFile {
            rax: 0x9900aabbccddeeff,
            rdi: 0x00000000feedface,
            ..Default::default()
        }
    }

    fn build_test_program(program: &str) -> String {
        let mut buf = {
            let mut buf = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
            buf.push("test");

            buf
        };

        let status = Command::new("make")
            .arg("-C")
            .arg(&buf)
            .arg(program)
            .status()
            .expect(&format!("build failed: {}", program));

        if !status.success() {
            panic!("build failed: {}", program);
        }

        buf.push(program);
        buf.into_os_string().into_string().unwrap()
    }

    fn test_program_tracer(program: &str) -> Tracer {
        let target = Target::Program(program.into(), vec![]);

        Tracer {
            ignore_unsupported_memops: false,
            tiny86_only: true,
            decree_syscalls: true,
            debug_on_fault: false,
            disable_aslr: true,
            bitness: 32,
            target: target,
        }
    }

    #[test]
    fn test_register_file_value() {
        let regs = dummy_regs();

        // Addressable registers always return their correctly masked values.
        assert_eq!(regs.value(Register::AL).unwrap(), 0xff);
        assert_eq!(regs.value(Register::AH).unwrap(), 0xee);
        assert_eq!(regs.value(Register::AX).unwrap(), 0xeeff);
        assert_eq!(regs.value(Register::EAX).unwrap(), 0xccddeeff);
        assert_eq!(regs.value(Register::RAX).unwrap(), 0x9900aabbccddeeff);

        // Segment registers always return a base address of 0.
        assert_eq!(regs.value(Register::AL).unwrap(), 0xff);
        assert_eq!(regs.value(Register::AH).unwrap(), 0xee);
        assert_eq!(regs.value(Register::AX).unwrap(), 0xeeff);
        assert_eq!(regs.value(Register::EAX).unwrap(), 0xccddeeff);
        assert_eq!(regs.value(Register::RAX).unwrap(), 0x9900aabbccddeeff);

        assert_eq!(regs.value(Register::SS).unwrap(), 0);
        assert_eq!(regs.value(Register::CS).unwrap(), 0);
        assert_eq!(regs.value(Register::DS).unwrap(), 0);
        assert_eq!(regs.value(Register::ES).unwrap(), 0);
        assert_eq!(regs.value(Register::FS).unwrap(), 0);
        assert_eq!(regs.value(Register::GS).unwrap(), 0);

        // Unaddressable and unsupported registers return an Err.
        assert!(regs.value(Register::ST0).is_err());
    }

    macro_rules! trace_consistency_tests {
        ($($name:ident,)*) => {
            $(
                #[test]
                fn $name() {
                    let program = build_test_program(concat!(stringify!($name), ".elf"));
                    let tracer = test_program_tracer(&program);

                    // TODO(ww): Don't collect these.
                    let trace1 = tracer
                        .trace()
                        .expect("spawn failed")
                        .collect::<Result<Vec<Step>>>()
                        .expect("trace failed");

                    let trace2 = tracer
                        .trace()
                        .expect("spawn failed")
                        .collect::<Result<Vec<Step>>>()
                        .expect("trace failed");

                    assert_eq!(trace1.len(), trace2.len());
                    for (step1, step2) in trace1.iter().zip(trace2.iter()) {
                        assert_eq!(step1, step2);
                    }

                    let trace3count = tracer
                        .trace()
                        .expect("spawn failed")
                        .count_instructions()
                        .expect("count failed");

                    assert_eq!(trace1.len(), trace3count);
                }
            )*
        }
    }

    // find test/ -name '*.s' | sort | xargs -n1 basename -s .s
    trace_consistency_tests! {
        alu_adc,
        alu_add,
        alu_add_neg,
        cdq,
        jmp,
        lea,
        loop_,
        memops,
        mov_r_r,
        push_pop,
        push_pop2,
        rcl,
        rol,
        stosb,
        stosd,
        stosw,
        xchg_r_r,
    }
}
