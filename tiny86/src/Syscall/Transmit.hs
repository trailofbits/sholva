module Syscall.Transmit
    ( syscallTransmitDFA
    ) where

import Clash.Prelude
import Syscall.Internal

zero :: Vec 32 Bit
zero = bv2v 0

-- NOTE(jl): inline translation of MSP430 DFA, see: sieve:circuit/msp430/regfile.v:204-207.
syscallTransmitDFA :: SyscallDFA
syscallTransmitDFA s@(MkDFAState {state = SYSCALL_STATE_DONE}) = s
syscallTransmitDFA s@(MkDFAState {state = SYSCALL_STATE_DONE}) = s
