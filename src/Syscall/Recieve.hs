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
    -- step contains the last data to consume.
    | ecx' < toEnum stepDataBytes =
        MkDFAState
            { eax = eax'
            -- increment the pointer into memory by the remaining number bytes left to consume.
            , ebx = ebx' + ecx'
            -- zero the number of bytes left to consume.
            , ecx = 0
            , state = SYSCALL_STATE_DONE
            }
    -- more steps to consume.
    | otherwise =
        MkDFAState
            { eax = eax'
            -- increment the pointer into memory.
            , ebx = ebx' + toEnum stepPtrBytes
            -- decrement the number of bytes left to consume.
            , ecx = ecx' - toEnum stepDataBytes
            , state = SYSCALL_STATE_READ
            }
