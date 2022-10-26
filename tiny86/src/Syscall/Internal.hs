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
    ) where

import Clash.Prelude

-- see: https://cgc-docs.legitbs.net/libcgc/cgcabi/
data Syscall
    = SYSCALL_TERMINATE
    | SYSCALL_TRANSMIT
    | SYSCALL_RECIEVE
    | SYSCALL_FDWAIT
    | SYSCALL_ALLOCATE
    | SYSCALL_DEALLOCATE
    | SYSCALL_RANDOM
    deriving (Bounded, Show)

type SyscallReg = BitVector 32

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
    toEnum 1 = SYSCALL_TERMINATE
    toEnum 2 = SYSCALL_TRANSMIT
    toEnum 3 = SYSCALL_RECIEVE
    toEnum 4 = SYSCALL_FDWAIT
    toEnum 5 = SYSCALL_ALLOCATE
    toEnum 6 = SYSCALL_DEALLOCATE
    toEnum 7 = SYSCALL_RANDOM
    toEnum _ = undefined

data SyscallState
    = SYSCALL_STATE_DONE -- 0
    | SYSCALL_STATE_READ -- 1
    deriving (Bounded, Enum, Eq, Show)

type SyscallStateReg = BitVector 4

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
