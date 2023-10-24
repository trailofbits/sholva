{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}

module Syscall.Internal
    ( SyscallState(..)
    , SyscallStateReg
    , Syscall(..)
    , SyscallReg
    , SyscallDFA
    , SyscallDFAState(..)
    , stepDataBytes
    , stepPtrBytes
    ) where

import Clash.Prelude

stepDataBytes :: Int
stepDataBytes = 2 * 4 -- the number of data bytes present per step.

stepPtrBytes :: Int
stepPtrBytes = 2 * 4 -- the number of address bytes present per step.

-- see: https://cgc-docs.legitbs.net/libcgc/cgcabi/
data Syscall
    = SYSCALL_NONE
    | SYSCALL_TERMINATE
    | SYSCALL_TRANSMIT
    | SYSCALL_RECEIVE
    | SYSCALL_FDWAIT
    | SYSCALL_ALLOCATE
    | SYSCALL_DEALLOCATE
    | SYSCALL_RANDOM
    deriving (Bounded, Show)

type SyscallReg = BitVector 32

-- auto-derived Enum on Syscall (reasonably) enumerates from 0;
-- so, implement Enum instance manually.
instance Enum Syscall where
    fromEnum SYSCALL_NONE = 0
    fromEnum SYSCALL_TERMINATE = 1
    fromEnum SYSCALL_TRANSMIT = 2
    fromEnum SYSCALL_RECEIVE = 3
    fromEnum SYSCALL_FDWAIT = 4
    fromEnum SYSCALL_ALLOCATE = 5
    fromEnum SYSCALL_DEALLOCATE = 6
    fromEnum SYSCALL_RANDOM = 7
    toEnum 0 = SYSCALL_NONE
    toEnum 1 = SYSCALL_TERMINATE
    toEnum 2 = SYSCALL_TRANSMIT
    toEnum 3 = SYSCALL_RECEIVE
    toEnum 4 = SYSCALL_FDWAIT
    toEnum 5 = SYSCALL_ALLOCATE
    toEnum 6 = SYSCALL_DEALLOCATE
    toEnum 7 = SYSCALL_RANDOM
    toEnum _ = undefined

-- NOTE(jl): as a convention, assume sholva's perspective.
-- e.g., the `transmit` syscall, from sholva's view, is _reading_ bytes from memory.
--       the `receive`  syscall, from sholva's view, is _writing_ bytes to memory.
data SyscallState
    = SYSCALL_STATE_DONE -- 0
    | SYSCALL_STATE_READ -- 1
    | SYSCALL_STATE_WRITE -- 2
    deriving (Bounded, Enum, Eq, Show)

type SyscallStateReg = BitVector 8

data SyscallDFAState =
    MkDFAState
        { eax :: SyscallReg
        , ebx :: SyscallReg
        , ecx :: SyscallReg
        , state :: SyscallState
        }
    deriving (Eq, Show)

-- for the two current register states, apply DFA transition from syscall state to new state.
type SyscallDFA = SyscallDFAState -> SyscallDFAState
