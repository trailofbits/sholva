module Alu where

import Alu.Internal
import Clash.Annotations.TH
import Clash.Prelude

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
