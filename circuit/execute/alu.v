`include "defines.v"

module alu(
  input [10:0] cntl,
  input [31:0] opnd0_r,
  input [31:0] opnd1_r
);

wire alu_src_inv = cntl[`ALU_SRC_INV];
wire alu_src_inc = cntl[`ALU_SRC_INC];
wire alu_use_carry = cntl[`ALU_USE_CARRY];
wire alu_no_wr = cntl[`ALU_NO_WR];

wire [32:0] opnd0_r_tmp = { alu_use_carry, opnd0_r };
wire [32:0] opnd1_r_tmp = { 1'b0, opnd1_r };
wire [32:0] result;

wire [32:0] result_add = opnd0_r_tmp + opnd1_r_tmp;
wire [32:0] result_sub = opnd0_r_tmp - opnd1_r_tmp;
wire [32:0] result_and = opnd0_r_tmp & opnd1_r_tmp;
wire [32:0] result_or = opnd0_r_tmp | opnd1_r_tmp;
wire [32:0] result_xor = opnd0_r_tmp ^ opnd1_r_tmp;
wire [32:0] result_mul = opnd0_r_tmp * opnd1_r_tmp;
wire [32:0] result_div = opnd0_r_tmp / opnd1_r_tmp;

endmodule
