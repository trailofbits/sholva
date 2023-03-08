{-# LANGUAGE BinaryLiterals, TemplateHaskell #-}

module Clash.PropAlu
    ( check
    ) where

import Alu.Internal
import Clash.Prelude
import Test.QuickCheck

{-
    ARITHMETIC TESTS
-}
-- forall r : r - r == 0
prop_alu_sub :: Register -> Bool
prop_alu_sub r = aluOp r r low (unpack 0b000000010000000000) == 0

-- forall r : r + 0 == 0 + r
prop_alu_add_idempotent :: Register -> Bool
prop_alu_add_idempotent r =
    aluOp r 0 low (unpack 0b000000000000000010) ==
    aluOp 0 r low (unpack 0b000000000000000010)

-- forall r : r & 0 == 0
prop_alu_and_idempotent :: Register -> Bool
prop_alu_and_idempotent r = aluOp r 0 low (unpack 0b000000000000000100) == 0

-- QUICKCHECK
return []

check :: IO Bool
check = $quickCheckAll
