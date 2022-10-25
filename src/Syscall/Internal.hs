{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeFamilies #-}

module Syscall.Internal
    ( SyscallState(..)
    , Syscall(..)
    , SyscallReg
    , SyscallDFA
    , SyscallDFAState(..)
    , syscallNum
    , syscallStateNum
    , numSyscall
    , numSyscallState
    , incr
    , decr
    ) where

import Clash.Prelude

-- FIXME(jl) gross hack.
incr :: Vec 32 Bit -> Vec 32 Bit
incr = bv2v . (+ 1) . bitCoerce

decr :: Vec 32 Bit -> Vec 32 Bit
decr = bv2v . (+ (-1)) . bitCoerce

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
-- doubly weird in that `Clash.Prelude.{to,from}Enum` `-> Int`, which makes use with BitVector... clunky.
-- so this is hacky.
syscallNum :: KnownNat n => Syscall -> BitVector n
syscallNum SYSCALL_TERMINATE = 1
syscallNum SYSCALL_TRANSMIT = 2
syscallNum SYSCALL_RECIEVE = 3
syscallNum SYSCALL_FDWAIT = 4
syscallNum SYSCALL_ALLOCATE = 5
syscallNum SYSCALL_DEALLOCATE = 6
syscallNum SYSCALL_RANDOM = 7

numSyscall :: KnownNat n => BitVector n -> Syscall
numSyscall 1 = SYSCALL_TERMINATE
numSyscall 2 = SYSCALL_TRANSMIT
numSyscall 3 = SYSCALL_RECIEVE
numSyscall 4 = SYSCALL_FDWAIT
numSyscall 5 = SYSCALL_ALLOCATE
numSyscall 6 = SYSCALL_DEALLOCATE
numSyscall 7 = SYSCALL_RANDOM
numSyscall _ = undefined

data SyscallState
    = SYSCALL_STATE_DONE
    | SYSCALL_STATE_READ

numSyscallState :: Vec 4 Bit -> SyscallState
numSyscallState (0 :> 0 :> 0 :> 0 :> Nil) = SYSCALL_STATE_DONE
numSyscallState (0 :> 0 :> 0 :> 1 :> Nil) = SYSCALL_STATE_READ
numSyscallState _ = undefined

syscallStateNum :: SyscallState -> Vec 4 Bit
syscallStateNum SYSCALL_STATE_DONE = 0 :> 0 :> 0 :> 0 :> Nil
syscallStateNum SYSCALL_STATE_READ = 0 :> 0 :> 0 :> 1 :> Nil

type SyscallReg = Vec 32 Bit

data SyscallDFAState =
    MkDFAState
        { eax :: SyscallReg
        , ebx :: SyscallReg
        , ecx :: SyscallReg
        , state :: SyscallState
        }

-- for the two current register states, apply DFA transition from syscall state to new state.
type SyscallDFA = SyscallDFAState -> SyscallDFAState
