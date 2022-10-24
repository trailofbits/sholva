{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE NamedFieldPuns #-}

module Syscall where


import Syscall.Internal
import Syscall.Recieve (syscallRecieveDFA)

import Clash.Annotations.TH
import Clash.Prelude

todo = undefined

top :: ( "i_eax" ::: Signal System SyscallReg
       , "i_ebx" ::: Signal System SyscallReg
       , "i_ecx" ::: Signal System SyscallReg
       , "i_syscall_state" ::: Signal System (Vec 4 Bit))
    -> ( "o_eax" ::: Signal System SyscallReg
       , "o_ebx" ::: Signal System SyscallReg
       , "o_ecx" ::: Signal System SyscallReg
       , "o_syscall_state" ::: Signal System (Vec 4 Bit))
top (i_eax, i_ebx, i_ecx, i_state) = (o_eax, o_ebx, o_ecx, o_state)
  where
    syscall :: Signal System Syscall
    syscall = numSyscall . v2bv <$> i_eax
    syscallState :: Signal System SyscallState
    syscallState = numSyscallState <$> i_state
    -- the extant state of the DFA.
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
    syscall' :: Signal System SyscallDFAState
    syscall' =
        (\dfaState ->
             \case
                 SYSCALL_TERMINATE -> todo
                 SYSCALL_TRANSMIT -> todo
                 SYSCALL_RECIEVE -> syscallRecieveDFA dfaState
                 SYSCALL_FDWAIT -> todo
                 SYSCALL_ALLOCATE -> todo
                 SYSCALL_DEALLOCATE -> todo
                 SYSCALL_RANDOM -> todo) <$>
        syscallDFAState <*>
        syscall
    -- pull out fields from DFA transition.
    o_eax, o_ebx, o_ecx :: Signal System SyscallReg
    o_eax = eax <$> syscall'
    o_ebx = ebx <$> syscall'
    o_ecx = ecx <$> syscall'
    o_state :: Signal System (Vec 4 Bit)
    o_state = syscallStateNum . state <$> syscall'

-- https://github.com/commercialhaskell/stackage/issues/5926#issuecomment-804695718
makeTopEntityWithName 'top "syscall"
