`define SIZ_BIT 1'd0
`define DIR_BIT 1'd1

`define OPND_IMM 2'd1
`define OPND_MEM 2'd2
`define OPND_REG 2'd3

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

// Trinary, reg of Mod/RM for r(+w), r/m of ModR/M for read, immediate for read.
`define OPND_ENC_MODREGRM_REG_RM_IMM 4'd10

// Trinary, r/m of ModR/M for r(+w), reg of ModR/M for read, immediate for read.
`define OPND_ENC_MODREGRM_RM_REG_IMM 4'd11

// Trinary, r/m of ModR/M for r(+w), reg of ModR/M for read, implicit CL reg for read.
`define OPND_ENC_MODREGRM_RM_REG_CL 4'd12

// Unknown operand encoding, should never be hit.
`define OPND_ENC_UNKNOWN 4'd15
