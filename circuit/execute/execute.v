`include "codegen/commands.gen.v"

module execute(
  input [5:0] opc
);

`include "funcs.v"

wire [63:0] opc_1hot = one_hot64(opc);

// ALU control signals.

// Core operation signals.
wire alu_add = opc_1hot[`CMD_ADD]
               | opc_1hot[`CMD_ADC] | opc_1hot[`CMD_SUB]
               | opc_1hot[`CMD_SBB] | opc_1hot[`CMD_INC]
               | opc_1hot[`CMD_DEC];
wire alu_and = opc_1hot[`CMD_AND];
wire alu_or = opc_1hot[`CMD_OR];
wire alu_xor = opc_1hot[`CMD_XOR];
wire alu_mul = opc_1hot[`CMD_MUL] | opc_1hot[`CMD_IMUL];
wire alu_div = opc_1hot[`CMD_DIV] | opc_1hot[`CMD_IDIV];

// Auxiliary signals.
wire alu_src_inv = opc_1hot[`CMD_SUB] | opc_1hot[`CMD_SBB] | opc_1hot[`CMD_DEC];

endmodule
