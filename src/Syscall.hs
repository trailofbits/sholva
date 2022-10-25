{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}

module Syscall where

import Syscall.Internal
import Syscall.Recieve (syscallRecieveDFA)

import Clash.Annotations.TH
import Clash.Prelude

todo = undefined

syscall' :: SyscallDFAState -> Syscall -> SyscallDFAState
syscall' dfaState =
    \case
        SYSCALL_TERMINATE -> todo
        SYSCALL_TRANSMIT -> todo
        SYSCALL_RECIEVE -> syscallRecieveDFA dfaState
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
    -- coerce input into a Syscall.
  where
    syscall :: Signal System Syscall
    syscall = toEnum . fromEnum <$> i_eax
    -- coerce input into a SyscallState.
    syscallState :: Signal System SyscallState
    syscallState = toEnum . fromEnum <$> i_state
    -- restructure the inputs into a SyscallDFAState.
    syscallDFAState :: Signal System SyscallDFAState
    syscallDFAState =
        (\i_eax' i_ebx' i_ecx' state' ->
             MkDFAState
                 {eax = i_eax', ebx = i_ebx', ecx = i_ecx', state = state'}) <$>
        i_eax <*>
        i_ebx <*>
        i_ecx <*>
        syscallState
    -- compute DFA transition.
    syscallDFAState' :: Signal System SyscallDFAState
    syscallDFAState' = syscall' <$> syscallDFAState <*> syscall
    -- destructure fields from computed DFA transition.
    o_eax, o_ebx, o_ecx :: Signal System SyscallReg
    o_eax = eax <$> syscallDFAState'
    o_ebx = ebx <$> syscallDFAState'
    o_ecx = ecx <$> syscallDFAState'
    o_state :: Signal System SyscallStateReg
    o_state = toEnum . fromEnum . state <$> syscallDFAState'

-- https://github.com/commercialhaskell/stackage/issues/5926#issuecomment-804695718
makeTopEntityWithName 'top "syscall"
