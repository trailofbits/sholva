import Test.QuickCheck

import PropAlu
import PropSyscall
import System.Exit

main :: IO ()
main = do
  results <- sequenceA [PropAlu.check, PropSyscall.check]
  if and results
    then exitSuccess
    else exitFailure
