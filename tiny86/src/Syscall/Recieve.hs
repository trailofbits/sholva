{-# LANGUAGE NamedFieldPuns #-}

module Syscall.Recieve
    ( syscallRecieveDFA
    ) where

import Clash.Prelude
import Syscall.Internal

zero :: Vec 32 Bit
zero = bv2v 0

-- NOTE(jl): inline translation of MSP430 DFA, see: sieve:circuit/msp430/regfile.v:204-207.
syscallRecieveDFA :: SyscallDFA
syscallRecieveDFA s@(MkDFAState {state = SYSCALL_STATE_DONE}) = s
syscallRecieveDFA (MkDFAState { eax = eax'
                              , ebx = ebx'
                              , ecx = ecx'
                              , state = SYSCALL_STATE_READ
                              })
    -- recieve length zero; done.
    | ecx' == zero =
        MkDFAState
            {eax = eax', ebx = ebx', ecx = ecx', state = SYSCALL_STATE_DONE}
    -- recieve length nonzero, continue.
    | otherwise =
        MkDFAState
            { eax = eax'
            , ebx = incr ebx'
            , ecx = decr ecx'
            , state = SYSCALL_STATE_READ
            }
