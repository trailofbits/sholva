{-# LANGUAGE BinaryLiterals, TemplateHaskell, TypeFamilies, DataKinds #-}

module PropSyscall where

import Syscall.Internal
import Syscall.Recieve
import Test.QuickCheck

prop_decr :: Int -> Bool
prop_decr v = True

-- QUICKCHECK
return []
check :: IO Bool
check = $quickCheckAll
