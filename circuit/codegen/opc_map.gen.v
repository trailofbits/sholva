
// this file was generated by codegen.py on 2021-03-12 13:37:35.988700
// do NOT edit it by hand

assign opc = ((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h0))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h1)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h2)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h3)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h4)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h5)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h0)))) ?
    (`CMD_ADD) :
    ((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h10))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h11)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h12)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h13)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h14)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h15)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h2)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h2)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h2)))) ?
    (`CMD_ADC) :
    ((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h20))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h21)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h22)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h23)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h24)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h25)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h4)))) ?
    (`CMD_AND) :
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hbc))) ?
    (`CMD_BSF) :
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hbd))) ?
    (`CMD_BSR) :
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'ha3))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hba))) && ((unescaped_instr[12:10]) == (3'h4)))) ?
    (`CMD_BT) :
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hbb))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hba))) && ((unescaped_instr[12:10]) == (3'h7)))) ?
    (`CMD_BTC) :
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hb3))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hba))) && ((unescaped_instr[12:10]) == (3'h6)))) ?
    (`CMD_BTR) :
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hab))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hba))) && ((unescaped_instr[12:10]) == (3'h5)))) ?
    (`CMD_BTS) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h98))) ?
    (`CMD_CBW) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf8))) ?
    (`CMD_CLC) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hfc))) ?
    (`CMD_CLD) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf5))) ?
    (`CMD_CMC) :
    ((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h38))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h39)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h3a)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h3b)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h3c)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h3d)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h7)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h7)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h7)))) ?
    (`CMD_CMP) :
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha6))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha7)))) ?
    (`CMD_CMPS) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h99))) ?
    (`CMD_CWD) :
    ((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h48))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hfe))) && ((unescaped_instr[12:10]) == (3'h1)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hff))) && ((unescaped_instr[12:10]) == (3'h1)))) ?
    (`CMD_DEC) :
    ((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h6))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h6)))) ?
    (`CMD_DIV) :
    ((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h7))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h7)))) ?
    (`CMD_IDIV) :
    ((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h69))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h6b)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'haf)))) ?
    (`CMD_IMUL) :
    ((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h40))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hfe))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hff))) && ((unescaped_instr[12:10]) == (3'h0)))) ?
    (`CMD_INC) :
    (((((((((((((((((((((((((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h70))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h71)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h72)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h73)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h74)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h75)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h76)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h77)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h78)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h79)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h7a)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h7b)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h7c)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h7d)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h7e)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h7f)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h80)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h81)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h82)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h83)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h84)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h85)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h86)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h87)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h88)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h89)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h8a)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h8b)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h8c)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h8d)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h8e)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h8f)))) ?
    (`CMD_Jcc) :
    (((((((((((((((((is_2byte) && ((unescaped_instr[7:0]) == (8'h90))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h91)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h92)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h93)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h94)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h95)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h96)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h97)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h98)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h99)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h9a)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h9b)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h9c)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h9d)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h9e)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h9f)))) ?
    (`CMD_SETcc) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'he3))) ?
    (`CMD_JCXZ) :
    ((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hea))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'heb)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'he9)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hff))) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hff))) && ((unescaped_instr[12:10]) == (3'h5)))) ?
    (`CMD_JMP) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8d))) ?
    (`CMD_LEA) :
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hac))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'had)))) ?
    (`CMD_LODS) :
    ((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'he0))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'he1)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'he2)))) ?
    (`CMD_LOOP) :
    (((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h88))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h89)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8a)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8b)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8c)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8e)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hb0)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hb8)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hc6))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hc7))) && ((unescaped_instr[12:10]) == (3'h0)))) ?
    (`CMD_MOV) :
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha4))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha5)))) ?
    (`CMD_MOVS) :
    ((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h63))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hbe)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hbf)))) ?
    (`CMD_MOVSX) :
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hb6))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hb7)))) ?
    (`CMD_MOVZX) :
    ((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h4))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h4)))) ?
    (`CMD_MUL) :
    ((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h3))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h3)))) ?
    (`CMD_NEG) :
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'h1f))) && ((unescaped_instr[12:10]) == (3'h0))) ?
    (`CMD_NOP) :
    ((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h2))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h2)))) ?
    (`CMD_NOT) :
    ((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h9)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hb)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hc)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hd)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h1)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h1)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h1)))) ?
    (`CMD_OR) :
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h58))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8f))) && ((unescaped_instr[12:10]) == (3'h0)))) ?
    (`CMD_POP) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h61))) ?
    (`CMD_POPA) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h9d))) ?
    (`CMD_POPF) :
    (((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h50))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h6a)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h68)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hff))) && ((unescaped_instr[12:10]) == (3'h6)))) ?
    (`CMD_PUSH) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h60))) ?
    (`CMD_PUSHA) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h9c))) ?
    (`CMD_PUSHF) :
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hc3))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hcb)))) ?
    (`CMD_RET) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h9e))) ?
    (`CMD_SAHF) :
    ((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h18))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h19)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h1a)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h1b)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h1c)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h1d)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h3)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h3)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h3)))) ?
    (`CMD_SBB) :
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hae))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'haf)))) ?
    (`CMD_SCAS) :
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'ha4))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'ha5)))) ?
    (`CMD_SHLD) :
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hac))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'had)))) ?
    (`CMD_SHRD) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf9))) ?
    (`CMD_STC) :
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hfd))) ?
    (`CMD_STD) :
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'haa))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hab)))) ?
    (`CMD_STOS) :
    ((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h28))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h29)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h2a)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h2b)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h2c)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h2d)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h5)))) ?
    (`CMD_SUB) :
    (((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h84))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h85)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha8)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha9)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h0)))) ?
    (`CMD_TEST) :
    ((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h86))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h86)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h87)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h87)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h90)))) ?
    (`CMD_XCHG) :
    ((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h30))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h31)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h32)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h33)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h34)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h35)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h6)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h6)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h6)))) ?
    (`CMD_XOR) :
    (`CMD_UNKNOWN);



assign opnd_form = ((((((((((((((((((((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h0))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h1)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h10)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h11)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h20)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h21)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'ha3)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hbb)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hb3)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hab)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h38)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h39)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h88)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h89)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8c)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h9)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h18)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h19)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h28)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h29)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h84)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h85)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h86)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h87)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h30)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h31)))) ?
    (`OPND_ENC_MODREGRM_RM_REG) :
    (((((((((((((((((((((((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h2))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h3)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h12)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h13)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h22)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h23)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hbc)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hbd)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h3a)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h3b)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'haf)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8d)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8a)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8b)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8e)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h63)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hbe)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hbf)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hb6)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hb7)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hb)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h1a)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h1b)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h2a)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h2b)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h86)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h87)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h32)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h33)))) ?
    (`OPND_ENC_MODREGRM_REG_RM) :
    (((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h4))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h5)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h14)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h15)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h24)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h25)))) ?
    (`OPND_ENC_EAX_IMM) :
    (((((((((((((((((((((((((((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h0))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h2)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h2)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h2)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hba))) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hba))) && ((unescaped_instr[12:10]) == (3'h7)))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hba))) && ((unescaped_instr[12:10]) == (3'h6)))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hba))) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h7)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h7)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h7)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hc6))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hc7))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h1)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h1)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h1)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h1d)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h3)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h3)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h3)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h80))) && ((unescaped_instr[12:10]) == (3'h6)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h81))) && ((unescaped_instr[12:10]) == (3'h6)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h83))) && ((unescaped_instr[12:10]) == (3'h6)))) ?
    (`OPND_ENC_MODREGRM_RM_IMM) :
    (((((((((((((((((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h98))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf8)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hfc)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf5)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha6)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha7)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h99)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hac)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'had)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha4)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha5)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h61)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h9d)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h60)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h9c)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hc3)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hcb)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h9e)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hae)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'haf)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf9)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hfd)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'haa)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hab)))) ?
    (`OPND_ENC_NONE) :
    ((((((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h3c))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h3d)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hc)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hd)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h6a)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h68)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h1c)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h2c)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h2d)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha8)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'ha9)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h34)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h35)))) ?
    (`OPND_ENC_IMM) :
    ((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h48))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h40)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h58)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h50)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h90)))) ?
    (`OPND_ENC_REG) :
    ((((((((((((((((((((((((((((((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hfe))) && ((unescaped_instr[12:10]) == (3'h1))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hff))) && ((unescaped_instr[12:10]) == (3'h1)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h6)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h6)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h7)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h7)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hfe))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hff))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h90)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h91)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h92)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h93)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h94)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h95)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h96)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h97)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h98)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h99)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h9a)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h9b)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h9c)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h9d)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h9e)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h9f)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hff))) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h3)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h3)))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'h1f))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf6))) && ((unescaped_instr[12:10]) == (3'h2)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hf7))) && ((unescaped_instr[12:10]) == (3'h2)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h8f))) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hff))) && ((unescaped_instr[12:10]) == (3'h6)))) ?
    (`OPND_ENC_MODREGRM_RM) :
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h69))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h6b)))) ?
    (`OPND_ENC_MODREGRM_REG_RM_IMM) :
    (((((((((((((((((((((((((((((((((((((((((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h70))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h71)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h72)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h73)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h74)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h75)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h76)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h77)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h78)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h79)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h7a)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h7b)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h7c)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h7d)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h7e)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'h7f)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h80)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h81)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h82)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h83)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h84)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h85)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h86)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h87)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h88)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h89)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h8a)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h8b)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h8c)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h8d)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h8e)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'h8f)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'he3)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hea)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'heb)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'he9)))) ||
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hff))) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'he0)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'he1)))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'he2)))) ?
    (`OPND_ENC_DISP) :
    (((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hb0))) ||
    ((~(is_2byte)) && ((unescaped_instr[7:0]) == (8'hb8)))) ?
    (`OPND_ENC_REG_IMM) :
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'ha4))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hac)))) ?
    (`OPND_ENC_MODREGRM_RM_REG_IMM) :
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'ha5))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'had)))) ?
    (`OPND_ENC_MODREGRM_REG_RM_CL) :
    (`OPND_ENC_UNKNOWN);



assign reg_1byte = ((unescaped_instr[7:0]) == (8'hb0));



assign imm_1byte = (((((((((((((((((((((((((((((((((((((unescaped_instr[7:0]) == (8'h4)) ||
    (((unescaped_instr[7:0]) == (8'h80)) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    (((unescaped_instr[7:0]) == (8'h83)) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    ((unescaped_instr[7:0]) == (8'h14))) ||
    (((unescaped_instr[7:0]) == (8'h80)) && ((unescaped_instr[12:10]) == (3'h2)))) ||
    (((unescaped_instr[7:0]) == (8'h83)) && ((unescaped_instr[12:10]) == (3'h2)))) ||
    ((unescaped_instr[7:0]) == (8'h24))) ||
    (((unescaped_instr[7:0]) == (8'h80)) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((unescaped_instr[7:0]) == (8'h83)) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hba))) && ((unescaped_instr[12:10]) == (3'h4)))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hba))) && ((unescaped_instr[12:10]) == (3'h7)))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hba))) && ((unescaped_instr[12:10]) == (3'h6)))) ||
    (((is_2byte) && ((unescaped_instr[7:0]) == (8'hba))) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    ((unescaped_instr[7:0]) == (8'h3c))) ||
    (((unescaped_instr[7:0]) == (8'h80)) && ((unescaped_instr[12:10]) == (3'h7)))) ||
    (((unescaped_instr[7:0]) == (8'h83)) && ((unescaped_instr[12:10]) == (3'h7)))) ||
    ((unescaped_instr[7:0]) == (8'h6b))) ||
    ((unescaped_instr[7:0]) == (8'hb0))) ||
    (((unescaped_instr[7:0]) == (8'hc6)) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    ((unescaped_instr[7:0]) == (8'hc))) ||
    (((unescaped_instr[7:0]) == (8'h80)) && ((unescaped_instr[12:10]) == (3'h1)))) ||
    (((unescaped_instr[7:0]) == (8'h83)) && ((unescaped_instr[12:10]) == (3'h1)))) ||
    ((unescaped_instr[7:0]) == (8'h6a))) ||
    ((unescaped_instr[7:0]) == (8'h1c))) ||
    (((unescaped_instr[7:0]) == (8'h80)) && ((unescaped_instr[12:10]) == (3'h3)))) ||
    (((unescaped_instr[7:0]) == (8'h83)) && ((unescaped_instr[12:10]) == (3'h3)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'ha4)))) ||
    ((is_2byte) && ((unescaped_instr[7:0]) == (8'hac)))) ||
    ((unescaped_instr[7:0]) == (8'h2c))) ||
    (((unescaped_instr[7:0]) == (8'h80)) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    (((unescaped_instr[7:0]) == (8'h83)) && ((unescaped_instr[12:10]) == (3'h5)))) ||
    ((unescaped_instr[7:0]) == (8'ha8))) ||
    (((unescaped_instr[7:0]) == (8'hf6)) && ((unescaped_instr[12:10]) == (3'h0)))) ||
    ((unescaped_instr[7:0]) == (8'h34))) ||
    (((unescaped_instr[7:0]) == (8'h80)) && ((unescaped_instr[12:10]) == (3'h6)))) ||
    (((unescaped_instr[7:0]) == (8'h83)) && ((unescaped_instr[12:10]) == (3'h6))));
