`include "defines.v"

module alu(
  input [9:0] cntl,
  input [31:0] opnd0_r,
  input [31:0] opnd1_r
);

wire alu_src_inv = cntl[`ALU_SRC_INV];
wire alu_src_inc = cntl[`ALU_SRC_INC];
wire alu_use_carry = cntl[`ALU_USE_CARRY];
wire alu_no_wr = cntl[`ALU_NO_WR];

endmodule
