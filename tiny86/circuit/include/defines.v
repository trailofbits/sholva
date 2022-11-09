`define OPND_IMM 2'd1
`define OPND_MEM 2'd2
`define OPND_REG 2'd3

// Valid destination (i.e., write) operand locations.
// Only registers and memory can be written to.
// Managed as a one-hot, for quick compares.
`define OPND_DEST_REG  1'd0
`define OPND_DEST_MEM  1'd1

`define OPND_DEST_REG_1HOT  2'b01
`define OPND_DEST_MEM_1HOT  2'b10
`define OPND_DEST_NONE      2'b00

// No operands, or a special case that we'll handle independently.
`define OPND_ENC_NONE 4'd0

// Unary, immediate operand.
`define OPND_ENC_IMM 4'd1

// Unary, 8-bit displacement operand.
`define OPND_ENC_DISP8 4'd2

// Unary, r/m of ModR/M operand.
`define OPND_ENC_MODREGRM_RM 4'd3

// Unary, reg of opcode bits operand.
`define OPND_ENC_REG 4'd4

// Unary, implicit accumulator reg for r(+w).
`define OPND_ENC_EAX 4'd14

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

// Unary, 32-bit displacement operand.
`define OPND_ENC_DISP32 4'd14

// Binary, r/m of ModR/M for r(+w), CL for read.
`define OPND_ENC_MODREGRM_RM_CL 4'd15

// Unknown operand encoding, should never be hit.
`define OPND_ENC_UNKNOWN 4'dx

// EFLAGS bits we care about
`define EFLAGS_CF 32'd0
`define EFLAGS_PF 32'd2
`define EFLAGS_AF 32'd4
`define EFLAGS_ZF 32'd6
`define EFLAGS_SF 32'd7
`define EFLAGS_TF 32'd8
`define EFLAGS_IF 32'd9
`define EFLAGS_DF 32'd10
`define EFLAGS_OF 32'd11

// Like EFLAGS, but for the compressed status signal.
`define STAT_OF 3'd0
`define STAT_SF 3'd1
`define STAT_ZF 3'd2
`define STAT_PF 3'd3
`define STAT_CF 3'd4
`define STAT_AF 3'd5
`define STAT_DF 3'd6

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
`define ALU_SRC_INV   5'd0   // Invert the source (TODO(ww): Why did I add this?)
`define ALU_OP_ADD    5'd1   // Perform an ADD
`define ALU_OP_AND    5'd2   // Perform an AND
`define ALU_OP_OR     5'd3   // Perform an OR
`define ALU_OP_XOR    5'd4   // Perform an XOR
`define ALU_OP_MUL    5'd5   // Perform a MUL
`define ALU_OP_DIV    5'd6   // Perform a DIV
`define ALU_USE_CARRY 5'd7   // Use the carry-in bit as part of the operation.
`define ALU_SRC_INC   5'd8   // Increment the source (TODO(ww): Why did I add this?)
`define ALU_NO_WR     5'd9   // Do not write the result (but maybe modify the flags)
`define ALU_OP_SUB    5'd10  // Perform a SUB
`define ALU_NO_FLAGS  5'd11  // Do not modify the flags
`define ALU_CLEAR_CF  5'd12  // Always clear CF
`define ALU_CLEAR_OF  5'd13  // Always clear OF
`define ALU_OP_SHL    5'd14  // Perform a SHL
`define ALU_OP_SHR    5'd15  // Perform a SHR
`define ALU_OP_ROL    5'd16  // Perform a ROL
`define ALU_OP_ROR    5'd17  // Perform a ROR

// Move unit control signals.
// The first bit controls whether we're doing a "move" (SRC -> DST)
// or a "swap" (OP1 -> x, OP2 -> OP1, x -> OP2) operation.
`define MU_MOVE 1'd0
`define MU_SEXT 1'd1
