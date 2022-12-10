module Syscall.Transmit
    ( syscallTransmitDFA
    ) where

import Clash.Prelude
import Prelude ()

import Syscall.Internal

-- FIXME(jl): compiler unconvinced these guards are total.
-- annoyingly this hides useful errors if new states are added.
syscallTransmitDFA :: SyscallDFA
syscallTransmitDFA s@(MkDFAState { eax = eax'
                                 , ebx = ebx'
                                 , ecx = ecx'
                                 , state = state'
                                 })
    -- no syscalls, just vibe.
    | state' == SYSCALL_STATE_DONE = s
    -- syscall, but not us.
    | state' == SYSCALL_STATE_WRITE = s
    -- less than a full step's worth of data left to read and transmit from RAM.
    -- finished.
    | state' == SYSCALL_STATE_READ && ecx' <= toEnum stepDataBytes =
        MkDFAState
            { eax = 0 -- return success.
            , ebx = ebx' + ecx' -- increment the pointer into RAM by the remaining number bytes left to consume.
            , ecx = ecx' - ecx' -- consume the last of the data.
            , state = SYSCALL_STATE_DONE
            }
    -- more steps left to consume.
    -- continue.
    | state' == SYSCALL_STATE_READ && ecx' > toEnum stepDataBytes =
        MkDFAState
            { eax = eax'
            , ebx = ebx' + toEnum stepPtrBytes -- increment the pointer into RAM.
            , ecx = ecx' - toEnum stepDataBytes -- decrement the number of bytes left to consume.
            , state = SYSCALL_STATE_WRITE
            }
