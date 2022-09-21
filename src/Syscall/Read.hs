module Syscall.Read where

import Syscall.Internal
import Clash.Prelude

-- NOTE(jl): inline translation of MSP430 DFA, see: sieve:circuit/msp430/regfile.v:204-207.
syscallReadDFA :: SyscallDFA
syscallReadDFA    _             SYSCALL_RECIEVE SYSCALL_STATE_NONE       = SYSCALL_LOAD_ARG
syscallReadDFA    _             _               SYSCALL_STATE_RESERVED   = undefined
syscallReadDFA    _             _               SYSCALL_STATE_LOAD_INPUT = SYSCALL_STATE_NONE
syscallReadDFA    _             _               SYSCALL_STATE_LOAD_ARG   = SYSCALL_STATE_LOAD_INPUT
syscallReadDFA    eax           _               _                        = syscall eax
