//! Syscall models for mttn.
//!
//! These are only used in "Tiny86" tracing mode.

use crate::trace::DecreeSyscall;

trait DFA {
    fn transition(rbx: u32, rcx: u32, rdx: u32) -> Vec<MemoryHint>;
}

impl DFA for DecreeSyscall {}
