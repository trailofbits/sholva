{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE ViewPatterns #-}

module Project
  ( topEntity
  ) where

import Clash.Annotations.TH
import Clash.Prelude

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

-- NOTE: vector indexing is MSB -> LSB.
-- accessor for normal LSB -> MSB bit ordering.
(!!>) ::
     Enum e
  => KnownNat n =>
       Vec n Bit -> e -> Bit
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

type Operand = BitVector 32

type ControlWord = Vec 18 Bit

alu :: Operand -> Operand -> Bit -> ControlWord -> BitVector 33
alu x y carry cntl
  -- FIXME(jl) how does verilog behave with truncations?
  -- ex for multiply, clash provides
  --    times :: Vec n -> Vec m -> Vec (n + m)
  --    (*)   :: Vec n -> Vec n -> Vec n
  -- FIXME(jl) carry bit
  | op ALU_OP_ADD = x `add` y
  | op ALU_OP_SUB = x `sub` y
  | op ALU_OP_AND = zeroExtend $ x .&. y
  | op ALU_OP_OR = zeroExtend $ x .|. y
  | op ALU_OP_XOR = zeroExtend $ x `xor` y
  | op ALU_OP_MUL = zeroExtend $ x * y
  | op ALU_OP_SHL = zeroExtend $ x `shiftL` 2
  | op ALU_OP_SHR = zeroExtend $ x `shiftR` 2
  | op ALU_OP_ROL = zeroExtend $ x `rotateL` 2
  | op ALU_OP_ROR = zeroExtend $ x `rotateR` 2
  | op ALU_OP_DIV = zeroExtend $ x `div` y
  where
    op n = cntl !!> n == 1

status :: Vec 7 Bit -> Vec 33 Bit -> ControlWord -> Vec 7 Bit
status status_in stat_result cntl =
  map boolToBit $
  stat_df :> stat_af :> stat_cf :> stat_pf :> stat_zf :> stat_sf :> stat_of :>
  Nil
  where
    result = pack stat_result
    stat_of = False
    stat_sf =
      if sf_no_wr
        then False
        else bitToBool $ head stat_result
    stat_zf =
      if zf_no_wr
        then False
        else result == 0
    stat_pf =
      if pf_no_wr
        then False
        else popCount result `mod` 2 == 0
    stat_cf = False
    stat_af = False
    stat_df = False
    -- flags
    alu_no_flags = bitToBool $ cntl !!> ALU_NO_FLAGS
    cf_no_wr = alu_no_flags
    pf_no_wr = alu_no_flags
    zf_no_wr = alu_no_flags
    sf_no_wr = alu_no_flags
    of_no_wr = alu_no_flags
    af_no_wr = alu_no_flags

topEntity ::
     ( "cntl" ::: Signal System ControlWord
     , "status_in" ::: Signal System (Vec 7 Bit)
     , "opnd0_r" ::: Signal System (Vec 32 Bit)
     , "opnd1_r" ::: Signal System (Vec 32 Bit))
  -> ( "status_out" ::: Signal System (Vec 7 Bit)
     , "result" ::: Signal System (Vec 32 Bit))
topEntity (cntl, status_in, opnd0_r, opnd1_r) = (status_out, result)
  where
    op0, op1 :: Signal System Operand
    op0 = bitCoerce <$> opnd0_r
    op1 = bitCoerce <$> opnd1_r
    carry_in :: Signal System Bit
    carry_in = ((!!> ALU_USE_CARRY) <$> cntl) * ((!!> STAT_CF) <$> status_in)
    stat_result :: Signal System (Vec 33 Bit)
    stat_result = unpack <$> (alu <$> op0 <*> op1 <*> carry_in <*> cntl)
    result :: Signal System (Vec 32 Bit)
    result = mux alu_no_wr (pure $ unpack 0) (tail <$> stat_result)
      where
        alu_no_wr = bitToBool <$> (!!> ALU_NO_WR) <$> cntl
    status_out :: Signal System (Vec 7 Bit)
    status_out = status <$> status_in <*> stat_result <*> cntl

makeTopEntityWithName 'topEntity "alu"
