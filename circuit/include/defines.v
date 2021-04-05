`define OPND_IMM 2'd1
`define OPND_MEM 2'd2
`define OPND_REG 2'd3

// Valid destination (i.e., write) operand locations.
// Only registers and memory can be written to.
`define OPND_DEST_REG 2'd0
`define OPND_DEST_MEM 2'd1
`define OPND_DEST_NONE 2'd2

// No operands.
`define OPND_ENC_NONE 4'd0

// Unary, immediate operand.
`define OPND_ENC_IMM 4'd1

// Unary, displacement operand.
`define OPND_ENC_DISP 4'd2

// Unary, r/m of ModR/M operand.
`define OPND_ENC_MODREGRM_RM 4'd3

// Unary, reg of opcode bits operand.
`define OPND_ENC_REG 4'd4

// Binary, r/m of ModR/M for r(+w) and immediate for read.
`define OPND_ENC_MODREGRM_RM_IMM 4'd5

// Binary, r/m of ModR/M for r(+w) and reg of ModR/M for read.
`define OPND_ENC_MODREGRM_RM_REG 4'd6

// Binary, reg of ModR/M for r(+w) and r/m of ModR/M for read.
`define OPND_ENC_MODREGRM_REG_RM 4'd7

// Binary, reg of opcode bits for r(+w) and immediate for read.
`define OPND_ENC_REG_IMM 4'd8

// Binary, implicit accumulator reg for r(+w) and immediate for read.
`define OPND_ENC_EAX_IMM 4'd9

// Binary, implicit accumulator reg for r+w and reg of opcode bits for r(+w).
`define OPND_ENC_EAX_REG 4'd10

// Trinary, reg of Mod/RM for r(+w), r/m of ModR/M for read, immediate for read.
`define OPND_ENC_MODREGRM_REG_RM_IMM 4'd11

// Trinary, r/m of ModR/M for r(+w), reg of ModR/M for read, immediate for read.
`define OPND_ENC_MODREGRM_RM_REG_IMM 4'd12

// Trinary, r/m of ModR/M for r(+w), reg of ModR/M for read, implicit CL reg for read.
`define OPND_ENC_MODREGRM_RM_REG_CL 4'd13

// Unknown operand encoding, should never be hit.
`define OPND_ENC_UNKNOWN 4'd15

// EFLAGS bits we care about
`define EFLAGS_CF 32'd0
`define EFLAGS_PF 32'd4
`define EFLAGS_ZF 32'd6
`define EFLAGS_SF 32'd7
`define EFLAGS_DF 32'd10
`define EFLAGS_OF 32'd11

// Like EFLAGS, but for the compressed status signal.
`define STAT_OF 3'd0
`define STAT_SF 3'd1
`define STAT_ZF 3'd2
`define STAT_PF 3'd3
`define STAT_CF 3'd4

// GPR numbering for register selectors/identification
// NOTE(ww): Weird numbering here is the canonical x86 numbering.
`define REG_EAX 3'd0
`define REG_EBX 3'd3
`define REG_ECX 3'd1
`define REG_EDX 3'd2
`define REG_ESI 3'd6
`define REG_EDI 3'd7
`define REG_ESP 3'd4
`define REG_EBP 3'd5

// ALU control signal numbering.
`define ALU_SRC_INV   4'd0
`define ALU_OP_ADD    4'd1
`define ALU_OP_AND    4'd2
`define ALU_OP_OR     4'd3
`define ALU_OP_XOR    4'd4
`define ALU_OP_MUL    4'd5
`define ALU_OP_DIV    4'd6
`define ALU_USE_CARRY 4'd7
`define ALU_SRC_INC   4'd8
`define ALU_NO_WR     4'd9
`define ALU_OP_SUB    4'd10
`define ALU_NO_FLAGS  4'd11
`define ALU_CLEAR_CF  4'd12
`define ALU_CLEAR_OF  4'd13
