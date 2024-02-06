module Syscall.Mmap
    ( syscallMmapDFA
    ) where

import Clash.Prelude
import Prelude ()

import Syscall.Internal

-- FIXME(jl): compiler unconvinced these guards are total.
-- annoyingly this hides useful errors if new states are added.
syscallMmapDFA :: SyscallDFA
syscallMmapDFA s@(MkDFAState { eax = eax'
                             , ebx = ebx'
                             , ecx = ecx'
                             , state = state'
                             })
    | state' == SYSCALL_STATE_DONE = s
    | state' == SYSCALL_STATE_READ = s
    | state' == SYSCALL_STATE_WRITE =
        MkDFAState
            { eax = 0 -- return success.
            , ebx = def
            , ecx = def
            , state = SYSCALL_STATE_DONE
            }
