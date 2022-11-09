{-# LANGUAGE DataKinds, TypeFamilies #-}

module Alu.Internal
  ( aluOp
  , ControlWord
  , AluControl(..)
  , StatFlags(..)
  , (!!>)
  , Register
  , status
  ) where

import Clash.Prelude
import qualified Prelude as P

data AluControl
  = ALU_SRC_INV
  | ALU_OP_ADD
  | ALU_OP_AND
  | ALU_OP_OR
  | ALU_OP_XOR
  | ALU_OP_MUL
  | ALU_OP_DIV
  | ALU_USE_CARRY
  | ALU_SRC_INC
  | ALU_NO_WR
  | ALU_OP_SUB
  | ALU_NO_FLAGS
  | ALU_CLEAR_CF
  | ALU_CLEAR_OF
  | ALU_OP_SHL
  | ALU_OP_SHR
  | ALU_OP_ROL
  | ALU_OP_ROR
  deriving (Bounded, Enum, Show)

-- clash vector indexing is MSB -> LSB, provide accessor for 'conventional' LSB -> MSB bit ordering.
-- FIXME(jl): need to annotate `:: Int` on constant args, -Wtype-defaults?
-- FIXME(jl): `reverse` induces lots of (probably unnecessary) overhead in compiled verilog.
(!!>) :: (KnownNat n, Enum i) => Vec n Bit -> i -> Bit
(!!>) cntl op = reverse cntl !! fromEnum op

data StatFlags
  = STAT_OF
  | STAT_SF
  | STAT_ZF
  | STAT_PF
  | STAT_CF
  | STAT_AF
  | STAT_DF
  deriving (Bounded, Enum, Show)

type Register = BitVector 32

type AluResult = BitVector 33

type ControlWord = Vec 18 Bit

type StatusWord = Vec 7 Bit

aluOp :: Register -> Register -> Bit -> ControlWord -> AluResult
aluOp x y carry cntl
  -- FIXME(jl) reference 80386 semantics for arithmetic ops' truncation behavior.
  -- ex for multiply, clash provides
  --    times :: Vec n -> Vec m -> Vec (n + m)
  --    (*)   :: Vec n -> Vec n -> Vec n
  -- so, should this `zeroExend *`, or `truncate times`?
  | op ALU_OP_ADD = x `add` (y + carryVal carry)
  | op ALU_OP_SUB = x `sub` (y + carryVal carry)
  | op ALU_OP_AND = zeroExtend $ x .&. y
  | op ALU_OP_OR = zeroExtend $ x .|. y
  | op ALU_OP_XOR = zeroExtend $ x `xor` y
  | op ALU_OP_MUL = zeroExtend $ x * y
  | op ALU_OP_SHL = zeroExtend $ x `shiftL` shiftVal y
  | op ALU_OP_SHR = zeroExtend $ x `shiftR` shiftVal y
  | op ALU_OP_ROL = zeroExtend $ x `rotateL` shiftVal y
  | op ALU_OP_ROR = zeroExtend $ x `rotateR` shiftVal y
  | op ALU_OP_DIV = zeroExtend $ x `div` y
  | otherwise = undefined -- all invocations of ALU must set _at least one_ of the operation bits.
  where
    carryVal = zeroExtend . pack
    shiftVal = unpack . resize
    op = (1 ==) . (cntl !!>)

status ::
     StatusWord
  -> Vec 32 Bit
  -> Vec 32 Bit
  -> Vec 33 Bit
  -> ControlWord
  -> StatusWord
status status_in@(stat_df :> stat_af :> stat_cf :> stat_pf :> stat_zf :> stat_sf :> stat_of :> Nil) op0 op1 stat_result cntl@(alu_op_ror :> alu_op_rol :> alu_op_shr :> alu_op_shl :> alu_clear_of :> alu_clear_cf :> alu_no_flags :> alu_op_sub :> alu_no_wr :> alu_src_inc :> alu_use_carry :> alu_op_div :> alu_op_mul :> alu_op_xor :> alu_op_or :> alu_op_and :> alu_op_add :> alu_src_inv :> Nil) =
  flag_df :> flag_af :> flag_cf :> flag_pf :> flag_zf :> flag_sf :> flag_of :>
  Nil
  where
    result = pack stat_result
    flag_of = low
    flag_sf
      | bitToBool sf_no_wr = stat_sf
      | otherwise = stat_result !! (1 :: Int)
    flag_zf
      | bitToBool zf_no_wr = stat_zf
      | otherwise = boolToBit (result == 0)
    flag_pf
      | bitToBool pf_no_wr = stat_pf
      | otherwise = (complement . reduceXor) (slice d7 d0 result)
    flag_cf
      | bitToBool cf_no_wr = stat_cf
      | bitToBool alu_clear_cf = low
      | otherwise = head stat_result
    flag_af
      | bitToBool af_no_wr = stat_af
      | otherwise =
        (op0 !!> (4 :: Int)) `xor` (op1 !!> (4 :: Int)) `xor`
        (stat_result !!> (4 :: Int))
    flag_df = stat_df
    -- flags
    -- FIXME(jl): learn where to use `where ...` vs `let ... in ...` for these misc bindings
    cf_no_wr = alu_no_flags
    pf_no_wr = alu_no_flags
    zf_no_wr = alu_no_flags
    sf_no_wr = alu_no_flags
    of_no_wr = alu_no_flags
    af_no_wr = alu_no_flags
