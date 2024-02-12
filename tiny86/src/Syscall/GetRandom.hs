module Syscall.GetRandom
    ( syscallGetRandomDFA
    ) where

import Clash.Prelude
import Prelude ()

import Syscall.Internal

-- FIXME(jl): compiler unconvinced these guards are total.
-- annoyingly this hides useful errors if new states are added.
syscallGetRandomDFA :: SyscallDFA
syscallGetRandomDFA s@(MkDFAState { eax = eax'
                                  , ebx = ebx'
                                  , ecx = ecx'
                                  , state = state'
                                  })
    | state' == SYSCALL_STATE_DONE = s
    | state' == SYSCALL_STATE_READ = s
    -- less than a full step's worth of data left to receive and write into RAM.
    -- finished.
    | state' == SYSCALL_STATE_WRITE && ecx' <= toEnum stepDataBytes =
        MkDFAState
            { eax = 0 -- return success.
            , ebx = ebx' + ecx' -- increment the pointer into RAM by the remaining number bytes left to consume.
            , ecx = ecx' - ecx' -- consume the last of the data.
            , state = SYSCALL_STATE_DONE
            }
    -- more steps left to consume.
    -- continue.
    | state' == SYSCALL_STATE_WRITE && ecx' > toEnum stepDataBytes =
        MkDFAState
            { eax = eax'
            , ebx = ebx' + toEnum stepPtrBytes -- increment the pointer into RAM.
            , ecx = ecx' - toEnum stepDataBytes -- decrement the number of bytes left to consume.
            , state = SYSCALL_STATE_WRITE
            }
