
// this file was generated by codegen.py on 2022-02-08 17:26:46.410971
// do NOT edit it by hand

`define CMD_ADD 7'd0
`define CMD_ADC 7'd1
`define CMD_AND 7'd2
`define CMD_BSF 7'd3
`define CMD_BSR 7'd4
`define CMD_BT 7'd5
`define CMD_BTC 7'd6
`define CMD_BTR 7'd7
`define CMD_BTS 7'd8
`define CMD_CBW 7'd9
`define CMD_CLC 7'd10
`define CMD_CLD 7'd11
`define CMD_CMC 7'd12
`define CMD_CMP 7'd13
`define CMD_CMPS 7'd14
`define CMD_CWD 7'd15
`define CMD_DEC 7'd16
`define CMD_DIV 7'd17
`define CMD_IDIV 7'd18
`define CMD_IMUL 7'd19
`define CMD_INC 7'd20
`define CMD_JO 7'd21
`define CMD_SETcc 7'd22
`define CMD_JCXZ 7'd23
`define CMD_JMPr 7'd24
`define CMD_LEA 7'd25
`define CMD_LODS 7'd26
`define CMD_LOOP 7'd27
`define CMD_MOV 7'd28
`define CMD_MOVS 7'd29
`define CMD_MOVSX 7'd30
`define CMD_MOVZX 7'd31
`define CMD_MUL 7'd32
`define CMD_NEG 7'd33
`define CMD_NOP 7'd34
`define CMD_NOT 7'd35
`define CMD_OR 7'd36
`define CMD_POP 7'd37
`define CMD_POPA 7'd38
`define CMD_POPF 7'd39
`define CMD_PUSH 7'd40
`define CMD_PUSHA 7'd41
`define CMD_PUSHF 7'd42
`define CMD_RET 7'd43
`define CMD_SAHF 7'd44
`define CMD_LAHF 7'd45
`define CMD_SBB 7'd46
`define CMD_SCAS 7'd47
`define CMD_SHLD 7'd48
`define CMD_SHRD 7'd49
`define CMD_STC 7'd50
`define CMD_STD 7'd51
`define CMD_STOS 7'd52
`define CMD_SUB 7'd53
`define CMD_TEST 7'd54
`define CMD_XCHG 7'd55
`define CMD_XOR 7'd56
`define CMD_SHL 7'd57
`define CMD_SAR 7'd58
`define CMD_SHR 7'd59
`define CMD_ROL 7'd60
`define CMD_RCL 7'd61
`define CMD_ROR 7'd62
`define CMD_RCR 7'd63
`define CMD_CALLr 7'd64
`define CMD_CALLi 7'd65
`define CMD_JMPi 7'd66
`define CMD_JNO 7'd67
`define CMD_JB 7'd68
`define CMD_JAE 7'd69
`define CMD_JE 7'd70
`define CMD_JNE 7'd71
`define CMD_JBE 7'd72
`define CMD_JA 7'd73
`define CMD_JS 7'd74
`define CMD_JNS 7'd75
`define CMD_JP 7'd76
`define CMD_JNP 7'd77
`define CMD_JL 7'd78
`define CMD_JNL 7'd79
`define CMD_JLE 7'd80
`define CMD_JG 7'd81
`define CMD_LOOPE 7'd82
`define CMD_LOOPNE 7'd83
`define CMD_LEAVE 7'd84
`define CMD_UNKNOWN 7'd85



`define CMD_ADD_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001
`define CMD_ADC_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010
`define CMD_AND_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100
`define CMD_BSF_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000
`define CMD_BSR_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000
`define CMD_BT_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000
`define CMD_BTC_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000
`define CMD_BTR_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000
`define CMD_BTS_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000
`define CMD_CBW_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000
`define CMD_CLC_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000
`define CMD_CLD_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000
`define CMD_CMC_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000
`define CMD_CMP_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000
`define CMD_CMPS_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000
`define CMD_CWD_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000
`define CMD_DEC_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000
`define CMD_DIV_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000
`define CMD_IDIV_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000
`define CMD_IMUL_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000
`define CMD_INC_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000
`define CMD_JO_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000
`define CMD_SETcc_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000
`define CMD_JCXZ_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000
`define CMD_JMPr_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000
`define CMD_LEA_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000
`define CMD_LODS_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000
`define CMD_LOOP_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000
`define CMD_MOV_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000
`define CMD_MOVS_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000
`define CMD_MOVSX_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000
`define CMD_MOVZX_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000
`define CMD_MUL_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000
`define CMD_NEG_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000
`define CMD_NOP_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000
`define CMD_NOT_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000
`define CMD_OR_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000
`define CMD_POP_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000
`define CMD_POPA_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000
`define CMD_POPF_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000
`define CMD_PUSH_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000
`define CMD_PUSHA_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000
`define CMD_PUSHF_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000
`define CMD_RET_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000
`define CMD_SAHF_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000
`define CMD_LAHF_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000
`define CMD_SBB_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000
`define CMD_SCAS_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000
`define CMD_SHLD_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000
`define CMD_SHRD_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000
`define CMD_STC_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000
`define CMD_STD_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000
`define CMD_STOS_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000
`define CMD_SUB_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000
`define CMD_TEST_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000
`define CMD_XCHG_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000
`define CMD_XOR_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000
`define CMD_SHL_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000
`define CMD_SAR_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000
`define CMD_SHR_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000
`define CMD_ROL_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000
`define CMD_RCL_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000
`define CMD_ROR_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000
`define CMD_RCR_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000
`define CMD_CALLr_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000
`define CMD_CALLi_1HOT 128'b00000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000
`define CMD_JMPi_1HOT 128'b00000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JNO_1HOT 128'b00000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JB_1HOT 128'b00000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JAE_1HOT 128'b00000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JE_1HOT 128'b00000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JNE_1HOT 128'b00000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JBE_1HOT 128'b00000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JA_1HOT 128'b00000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JS_1HOT 128'b00000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JNS_1HOT 128'b00000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JP_1HOT 128'b00000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JNP_1HOT 128'b00000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JL_1HOT 128'b00000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JNL_1HOT 128'b00000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JLE_1HOT 128'b00000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_JG_1HOT 128'b00000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_LOOPE_1HOT 128'b00000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_LOOPNE_1HOT 128'b00000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_LEAVE_1HOT 128'b00000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000
`define CMD_UNKNOWN_1HOT 128'b00000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000
