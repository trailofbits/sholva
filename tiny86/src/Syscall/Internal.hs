module Syscall.Internal
    ( SyscallState
    , Syscall
    , SyscallReg
    , SyscallDFA
    ) where

import Clash.Prelude

type SyscallDFA = SyscallReg -> Syscall -> SyscallState -> SyscallState

-- see: https://cgc-docs.legitbs.net/libcgc/cgcabi/
data Syscall
    = SYSCALL_TERMINATE
    | SYSCALL_TRANSMIT
    | SYSCALL_RECIEVE
    | SYSCALL_FDWAIT
    | SYSCALL_ALLOCATE
    | SYSCALL_DEALLOCATE
    | SYSCALL_RANDOM
    deriving (Bounded)

-- auto-derived Enum on Syscall (reasonably) enumerates from 0;
-- so, implement Enum instance manually.
instance Enum Syscall where
    fromEnum SYSCALL_TERMINATE = 1
    fromEnum SYSCALL_TRANSMIT = 2
    fromEnum SYSCALL_RECIEVE = 3
    fromEnum SYSCALL_FDWAIT = 4
    fromEnum SYSCALL_ALLOCATE = 5
    fromEnum SYSCALL_DEALLOCATE = 6
    fromEnum SYSCALL_RANDOM = 7
    toEnum _ = undefined -- NOTE(jl): for now unused.

-- FIXME(jl): for now just straight porting DFA states and transitions from MSP430 impelmentation.
data SyscallState
    = SYSCALL_STATE_NONE
    | SYSCALL_STATE_RESERVED
    | SYSCALL_STATE_LOAD_INPUT
    | SYSCALL_STATE_LOAD_ARG
    deriving (Enum, Bounded)

type SyscallReg = Vec 32 Bit
