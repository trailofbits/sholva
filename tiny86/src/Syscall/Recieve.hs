{-# LANGUAGE DataKinds #-}

module Syscall.Recieve
    ( syscallRecieveDFA
    ) where

import Clash.Prelude
import Syscall.Internal

syscallRecieveDFA :: SyscallDFA
syscallRecieveDFA s@(MkDFAState {state = SYSCALL_STATE_DONE}) = s
syscallRecieveDFA (MkDFAState { eax = eax'
                              , ebx = ebx'
                              , ecx = ecx'
                              , state = SYSCALL_STATE_READ
                              })
    -- recieve length zero; done.
    | ecx' == 0 =
        MkDFAState {eax = eax', ebx = ebx', ecx = 0, state = SYSCALL_STATE_DONE}
    -- recieve length nonzero, incrememnt buffer pointer, decrement count.
    | otherwise =
        MkDFAState
            { eax = eax'
            , ebx = ebx' + 1
            , ecx = ecx' - 1
            , state = SYSCALL_STATE_READ
            }
