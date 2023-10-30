{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}

module Syscall where

import Syscall.Internal
import Syscall.Receive (syscallReceiveDFA)
import Syscall.Transmit (syscallTransmitDFA)

import Clash.Annotations.TH
import Clash.Prelude

todo :: a
todo = undefined

syscall' :: SyscallDFAState -> Syscall -> SyscallDFAState
syscall' dfaState =
    \case
        SYSCALL_NONE -> MkDFAState {eax = 0, ebx = 0, ecx = 0, state = SYSCALL_STATE_DONE}
        SYSCALL_TERMINATE -> todo
        SYSCALL_TRANSMIT -> syscallTransmitDFA dfaState
        SYSCALL_RECEIVE -> syscallReceiveDFA dfaState
        SYSCALL_FDWAIT -> todo
        SYSCALL_ALLOCATE -> todo
        SYSCALL_DEALLOCATE -> todo
        SYSCALL_RANDOM -> todo

top :: ( "i_eax" ::: Signal System SyscallReg
       , "i_ebx" ::: Signal System SyscallReg
       , "i_ecx" ::: Signal System SyscallReg
       , "i_syscall_state" ::: Signal System SyscallStateReg)
    -> ( "o_eax" ::: Signal System SyscallReg
       , "o_ebx" ::: Signal System SyscallReg
       , "o_ecx" ::: Signal System SyscallReg
       , "o_syscall_state" ::: Signal System SyscallStateReg)
top (i_eax, i_ebx, i_ecx, i_state) = (o_eax, o_ebx, o_ecx, o_state)
  where
    syscall :: Signal System Syscall
    -- coerce input into a Syscall.
    syscall = toEnum . fromEnum <$> i_eax
    syscallState :: Signal System SyscallState
    -- coerce input into a SyscallState.
    syscallState = toEnum . fromEnum <$> i_state
    syscallDFAState :: Signal System SyscallDFAState
    -- restructure the inputs into a SyscallDFAState.
    syscallDFAState =
        (\i_eax' i_ebx' i_ecx' state' ->
             MkDFAState
                 {eax = i_eax', ebx = i_ebx', ecx = i_ecx', state = state'}) <$>
        i_eax <*>
        i_ebx <*>
        i_ecx <*>
        syscallState
    syscallDFAState' :: Signal System SyscallDFAState
    -- compute DFA transition.
    syscallDFAState' = syscall' <$> syscallDFAState <*> syscall
    o_eax, o_ebx, o_ecx :: Signal System SyscallReg
    -- destructure fields from computed DFA transition.
    o_eax = eax <$> syscallDFAState'
    o_ebx = ebx <$> syscallDFAState'
    o_ecx = ecx <$> syscallDFAState'
    o_state :: Signal System SyscallStateReg
    o_state = toEnum . fromEnum . state <$> syscallDFAState'

-- NOTE(jl): unavoidable warning.
-- https://github.com/commercialhaskell/stackage/issues/5926#issuecomment-804695718
makeTopEntityWithName 'top "syscall"
