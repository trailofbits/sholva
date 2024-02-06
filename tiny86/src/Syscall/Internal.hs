{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}

module Syscall.Internal
    ( SyscallState(..)
    , SyscallStateReg
    , LinuxSyscall(..)
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
data DecreeSyscall
    = DSYSCALL_NONE
    | DSYSCALL_TERMINATE
    | DSYSCALL_TRANSMIT
    | DSYSCALL_RECEIVE
    | DSYSCALL_FDWAIT
    | DSYSCALL_ALLOCATE
    | DSYSCALL_DEALLOCATE
    | DSYSCALL_RANDOM
    deriving (Bounded, Show)

data LinuxSyscall
    = SYSCALL_NONE
    | SYSCALL_EXIT
    | SYSCALL_READ
    | SYSCALL_WRITE
    | SYSCALL_OPEN
    | SYSCALL_CLOSE
    | SYSCALL_BRK
    | SYSCALL_MMAP
    deriving (Bounded, Show)

type SyscallReg = BitVector 32

instance Enum LinuxSyscall where
    fromEnum SYSCALL_NONE = 0
    fromEnum SYSCALL_EXIT = 1
    fromEnum SYSCALL_READ = 3
    fromEnum SYSCALL_WRITE = 4
    fromEnum SYSCALL_OPEN = 5
    fromEnum SYSCALL_CLOSE = 6
    fromEnum SYSCALL_BRK = 45
    fromEnum SYSCALL_MMAP = 90
    toEnum 0 = SYSCALL_NONE
    toEnum 1 = SYSCALL_EXIT
    toEnum 3 = SYSCALL_READ
    toEnum 4 = SYSCALL_WRITE
    toEnum 5 = SYSCALL_OPEN
    toEnum 6 = SYSCALL_CLOSE
    toEnum 45 = SYSCALL_BRK 
    toEnum 90 = SYSCALL_MMAP
    toEnum _ = undefined

-- NOTE(jl): as a convention, assume sholva's perspective.
-- e.g., the `write` syscall, from sholva's view, is _reading_ bytes from memory.
--       the `read` syscall, from sholva's view, is _writing_ bytes to memory.
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
