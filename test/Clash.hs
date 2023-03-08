module Clash where

import Test.QuickCheck

import Clash.PropAlu as PropAlu (check)
import Clash.PropSyscall as PropSyscall (check)
import System.Exit

main :: IO ()
main = do
  results <- sequenceA [PropAlu.check, PropSyscall.check]
  if and results
    then exitSuccess
    else exitFailure
