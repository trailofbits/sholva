`include "codegen/commands.gen.v"

module execute(
  input [5:0] opc,
  input [31:0] eflags,
  input [31:0] opnd0_r,
  input [31:0] opnd1_r

  // TODO: opndN_w for outputs
);

`include "funcs.v"

wire [63:0] opc_1hot = one_hot64(opc);

// ALU control signals.

// Core operation signals.
wire alu_op_add = opc_1hot[`CMD_ADD]
               | opc_1hot[`CMD_ADC] | opc_1hot[`CMD_SUB]
               | opc_1hot[`CMD_SBB] | opc_1hot[`CMD_INC]
               | opc_1hot[`CMD_DEC];
wire alu_op_and = opc_1hot[`CMD_AND];
wire alu_op_or = opc_1hot[`CMD_OR];
wire alu_op_xor = opc_1hot[`CMD_XOR];
wire alu_op_mul = opc_1hot[`CMD_MUL] | opc_1hot[`CMD_IMUL];
wire alu_op_div = opc_1hot[`CMD_DIV] | opc_1hot[`CMD_IDIV];

// Auxiliary signals.
wire alu_src_inv = opc_1hot[`CMD_SUB] | opc_1hot[`CMD_SBB] | opc_1hot[`CMD_DEC];
wire alu_use_carry = opc_1hot[`CMD_ADC] | opc_1hot[`CMD_SBB];
wire alu_src_inc = opc_1hot[`CMD_SUB] | opc_1hot[`CMD_SBB];
wire alu_no_wr = opc_1hot[`CMD_CMP] | opc_1hot[`CMD_CMPS];

wire [9:0] alu_cntl = {
                        alu_no_wr,     // 10
                        alu_src_inc,   // 9
                        alu_use_carry, // 8
                        alu_op_add,    // 7
                        alu_op_and,    // 6
                        alu_op_or,     // 5
                        alu_op_xor,    // 4
                        alu_op_mul,    // 3
                        alu_op_div,    // 2
                        alu_src_inv    // 1
                      };

alu alu_x(
  .cntl(alu_cntl),
  .opnd0_r(opnd0_r),
  .opnd1_r(opnd1_r)
);

endmodule
