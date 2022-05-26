module Alu
  ( alu
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
status status_in op0 op1 stat_result cntl =
  stat_df :> stat_af :> stat_cf :> stat_pf :> stat_zf :> stat_sf :> stat_of :>
  Nil
  where
    result = pack stat_result
    stat_of
      | of_no_wr = status_in !!> STAT_CF
      | alu_clear_of = low
      | aluOp_sub =
        (complement (head op0) .&. head op1 .&. head stat_result) .|.
        (head op0 .&. complement (head op1) .&. complement (head stat_result))
      | otherwise =
        (head op0 .&. head op1 .&. complement (head stat_result)) .|.
        (complement (head op0) .&. complement (head op1) .&. head stat_result)
      where
        alu_clear_of = bitToBool $ cntl !!> ALU_CLEAR_OF
        aluOp_sub = bitToBool $ cntl !!> ALU_OP_SUB
    stat_sf =
      if sf_no_wr
        then status_in !!> STAT_SF
        else stat_result !! (1 :: Int)
    stat_zf =
      if zf_no_wr
        then status_in !!> STAT_ZF
        else boolToBit (result == 0)
    stat_pf =
      if pf_no_wr
        then status_in !!> STAT_PF
        else (complement . reduceXor) (slice d7 d0 result)
    stat_cf
      | cf_no_wr = status_in !!> STAT_CF
      | alu_clear_cf = low
      | otherwise = head stat_result
      where
        alu_clear_cf = bitToBool $ cntl !!> ALU_CLEAR_CF
    stat_af
      | af_no_wr = status_in !!> STAT_AF
      | otherwise =
        (op0 !!> (4 :: Int)) `xor` (op1 !!> (4 :: Int)) `xor`
        (stat_result !!> (4 :: Int))
    stat_df = status_in !!> STAT_DF
    -- flags
    -- FIXME(jl): learn where to use `where ...` vs `let ... in ...` for these misc bindings
    alu_no_flags = bitToBool $ cntl !!> ALU_NO_FLAGS
    cf_no_wr = alu_no_flags
    pf_no_wr = alu_no_flags
    zf_no_wr = alu_no_flags
    sf_no_wr = alu_no_flags
    of_no_wr = alu_no_flags
    af_no_wr = alu_no_flags

alu ::
     ( "cntl" ::: Signal System ControlWord
     , "status_in" ::: Signal System (Vec 7 Bit)
     , "opnd0_r" ::: Signal System (Vec 32 Bit)
     , "opnd1_r" ::: Signal System (Vec 32 Bit))
  -> ( "status_out" ::: Signal System (Vec 7 Bit)
     , "result" ::: Signal System (Vec 32 Bit))
alu (cntl, status_in, opnd0_r, opnd1_r) = (status_out, result)
  where
    op0, op1 :: Signal System Register
    op0 = bitCoerce <$> opnd0_r
    op1 = bitCoerce <$> opnd1_r
    carry_in :: Signal System Bit
    carry_in = ((!!> ALU_USE_CARRY) <$> cntl) * ((!!> STAT_CF) <$> status_in)
    stat_result :: Signal System (Vec 33 Bit)
    stat_result = unpack <$> (aluOp <$> op0 <*> op1 <*> carry_in <*> cntl)
    result :: Signal System (Vec 32 Bit)
    result = mux alu_no_wr (pure $ unpack 0) (tail <$> stat_result)
      where
        alu_no_wr = bitToBool . (!!> ALU_NO_WR) <$> cntl
    status_out :: Signal System (Vec 7 Bit)
    status_out =
      status <$> status_in <*> opnd0_r <*> opnd1_r <*> stat_result <*> cntl

makeTopEntityWithName 'alu "alu"
