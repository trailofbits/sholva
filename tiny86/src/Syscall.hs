module Syscall where

import Syscall.Internal

import Clash.Annotations.TH
import Clash.Prelude
import qualified Prelude as P

syscall :: ("eax" ::: Signal System SyscallReg) -> ("out" ::: Signal System Bit)
syscall ops = undefined

makeTopEntityWithName 'syscall "syscall"
