
// this file was generated by codegen.py on 2021-08-03 12:09:49.155429
// do NOT edit it by hand

`define CMD_ADD 6'd0
`define CMD_ADC 6'd1
`define CMD_AND 6'd2
`define CMD_BSF 6'd3
`define CMD_BSR 6'd4
`define CMD_BT 6'd5
`define CMD_BTC 6'd6
`define CMD_BTR 6'd7
`define CMD_BTS 6'd8
`define CMD_CBW 6'd9
`define CMD_CLC 6'd10
`define CMD_CLD 6'd11
`define CMD_CMC 6'd12
`define CMD_CMP 6'd13
`define CMD_CMPS 6'd14
`define CMD_CWD 6'd15
`define CMD_DEC 6'd16
`define CMD_DIV 6'd17
`define CMD_IDIV 6'd18
`define CMD_IMUL 6'd19
`define CMD_INC 6'd20
`define CMD_Jcc 6'd21
`define CMD_SETcc 6'd22
`define CMD_JCXZ 6'd23
`define CMD_JMP 6'd24
`define CMD_LEA 6'd25
`define CMD_LODS 6'd26
`define CMD_LOOP 6'd27
`define CMD_MOV 6'd28
`define CMD_MOVS 6'd29
`define CMD_MOVSX 6'd30
`define CMD_MOVZX 6'd31
`define CMD_MUL 6'd32
`define CMD_NEG 6'd33
`define CMD_NOP 6'd34
`define CMD_NOT 6'd35
`define CMD_OR 6'd36
`define CMD_POP 6'd37
`define CMD_POPA 6'd38
`define CMD_POPF 6'd39
`define CMD_PUSH 6'd40
`define CMD_PUSHA 6'd41
`define CMD_PUSHF 6'd42
`define CMD_RET 6'd43
`define CMD_SAHF 6'd44
`define CMD_LAHF 6'd45
`define CMD_SBB 6'd46
`define CMD_SCAS 6'd47
`define CMD_SHLD 6'd48
`define CMD_SHRD 6'd49
`define CMD_STC 6'd50
`define CMD_STD 6'd51
`define CMD_STOS 6'd52
`define CMD_SUB 6'd53
`define CMD_TEST 6'd54
`define CMD_XCHG 6'd55
`define CMD_XOR 6'd56
`define CMD_UNKNOWN 6'd57



`define CMD_ADD_1HOT 64'b0000000000000000000000000000000000000000000000000000000000000001
`define CMD_ADC_1HOT 64'b0000000000000000000000000000000000000000000000000000000000000010
`define CMD_AND_1HOT 64'b0000000000000000000000000000000000000000000000000000000000000100
`define CMD_BSF_1HOT 64'b0000000000000000000000000000000000000000000000000000000000001000
`define CMD_BSR_1HOT 64'b0000000000000000000000000000000000000000000000000000000000010000
`define CMD_BT_1HOT 64'b0000000000000000000000000000000000000000000000000000000000100000
`define CMD_BTC_1HOT 64'b0000000000000000000000000000000000000000000000000000000001000000
`define CMD_BTR_1HOT 64'b0000000000000000000000000000000000000000000000000000000010000000
`define CMD_BTS_1HOT 64'b0000000000000000000000000000000000000000000000000000000100000000
`define CMD_CBW_1HOT 64'b0000000000000000000000000000000000000000000000000000001000000000
`define CMD_CLC_1HOT 64'b0000000000000000000000000000000000000000000000000000010000000000
`define CMD_CLD_1HOT 64'b0000000000000000000000000000000000000000000000000000100000000000
`define CMD_CMC_1HOT 64'b0000000000000000000000000000000000000000000000000001000000000000
`define CMD_CMP_1HOT 64'b0000000000000000000000000000000000000000000000000010000000000000
`define CMD_CMPS_1HOT 64'b0000000000000000000000000000000000000000000000000100000000000000
`define CMD_CWD_1HOT 64'b0000000000000000000000000000000000000000000000001000000000000000
`define CMD_DEC_1HOT 64'b0000000000000000000000000000000000000000000000010000000000000000
`define CMD_DIV_1HOT 64'b0000000000000000000000000000000000000000000000100000000000000000
`define CMD_IDIV_1HOT 64'b0000000000000000000000000000000000000000000001000000000000000000
`define CMD_IMUL_1HOT 64'b0000000000000000000000000000000000000000000010000000000000000000
`define CMD_INC_1HOT 64'b0000000000000000000000000000000000000000000100000000000000000000
`define CMD_Jcc_1HOT 64'b0000000000000000000000000000000000000000001000000000000000000000
`define CMD_SETcc_1HOT 64'b0000000000000000000000000000000000000000010000000000000000000000
`define CMD_JCXZ_1HOT 64'b0000000000000000000000000000000000000000100000000000000000000000
`define CMD_JMP_1HOT 64'b0000000000000000000000000000000000000001000000000000000000000000
`define CMD_LEA_1HOT 64'b0000000000000000000000000000000000000010000000000000000000000000
`define CMD_LODS_1HOT 64'b0000000000000000000000000000000000000100000000000000000000000000
`define CMD_LOOP_1HOT 64'b0000000000000000000000000000000000001000000000000000000000000000
`define CMD_MOV_1HOT 64'b0000000000000000000000000000000000010000000000000000000000000000
`define CMD_MOVS_1HOT 64'b0000000000000000000000000000000000100000000000000000000000000000
`define CMD_MOVSX_1HOT 64'b0000000000000000000000000000000001000000000000000000000000000000
`define CMD_MOVZX_1HOT 64'b0000000000000000000000000000000010000000000000000000000000000000
`define CMD_MUL_1HOT 64'b0000000000000000000000000000000100000000000000000000000000000000
`define CMD_NEG_1HOT 64'b0000000000000000000000000000001000000000000000000000000000000000
`define CMD_NOP_1HOT 64'b0000000000000000000000000000010000000000000000000000000000000000
`define CMD_NOT_1HOT 64'b0000000000000000000000000000100000000000000000000000000000000000
`define CMD_OR_1HOT 64'b0000000000000000000000000001000000000000000000000000000000000000
`define CMD_POP_1HOT 64'b0000000000000000000000000010000000000000000000000000000000000000
`define CMD_POPA_1HOT 64'b0000000000000000000000000100000000000000000000000000000000000000
`define CMD_POPF_1HOT 64'b0000000000000000000000001000000000000000000000000000000000000000
`define CMD_PUSH_1HOT 64'b0000000000000000000000010000000000000000000000000000000000000000
`define CMD_PUSHA_1HOT 64'b0000000000000000000000100000000000000000000000000000000000000000
`define CMD_PUSHF_1HOT 64'b0000000000000000000001000000000000000000000000000000000000000000
`define CMD_RET_1HOT 64'b0000000000000000000010000000000000000000000000000000000000000000
`define CMD_SAHF_1HOT 64'b0000000000000000000100000000000000000000000000000000000000000000
`define CMD_LAHF_1HOT 64'b0000000000000000001000000000000000000000000000000000000000000000
`define CMD_SBB_1HOT 64'b0000000000000000010000000000000000000000000000000000000000000000
`define CMD_SCAS_1HOT 64'b0000000000000000100000000000000000000000000000000000000000000000
`define CMD_SHLD_1HOT 64'b0000000000000001000000000000000000000000000000000000000000000000
`define CMD_SHRD_1HOT 64'b0000000000000010000000000000000000000000000000000000000000000000
`define CMD_STC_1HOT 64'b0000000000000100000000000000000000000000000000000000000000000000
`define CMD_STD_1HOT 64'b0000000000001000000000000000000000000000000000000000000000000000
`define CMD_STOS_1HOT 64'b0000000000010000000000000000000000000000000000000000000000000000
`define CMD_SUB_1HOT 64'b0000000000100000000000000000000000000000000000000000000000000000
`define CMD_TEST_1HOT 64'b0000000001000000000000000000000000000000000000000000000000000000
`define CMD_XCHG_1HOT 64'b0000000010000000000000000000000000000000000000000000000000000000
`define CMD_XOR_1HOT 64'b0000000100000000000000000000000000000000000000000000000000000000
`define CMD_UNKNOWN_1HOT 64'b0000001000000000000000000000000000000000000000000000000000000000
