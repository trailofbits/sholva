{-# LANGUAGE BinaryLiterals #-}
import Alu.Internal
import Clash.Prelude
import Test.QuickCheck

-- forall r : r - r == 0
alu_test :: Register -> Bool
alu_test r = aluOp r r low (unpack 0b000000010000000000) == 0

main :: IO ()
main = quickCheck alu_test
