module Main where

import Test.QuickCheck

import PropAlu as PropAlu (check)
import PropSyscall as PropSyscall (check)
import System.Exit
import Prelude

main :: IO ()
main = do
  results <- sequenceA [PropAlu.check, PropSyscall.check]
  if and results
    then exitSuccess
    else exitFailure
