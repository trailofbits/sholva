{-# LANGUAGE BinaryLiterals, TemplateHaskell #-}

import Control.Monad (void)

import PropAlu
import PropSyscall

return []

main :: IO ()
main = do
    void PropAlu.check
    void PropSyscall.check
    return ()
