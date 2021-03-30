`include "defines.v"

module alu(
  input [11:0] cntl,
  input [4:0] status_in, // 4:CF, 3:PF, 2:ZF, 1:SF, 0:OF
  input [31:0] opnd0_r,
  input [31:0] opnd1_r,

  output [4:0] status_out, // 4:CF, 3:PF, 2:ZF, 1:SF, 0:OF
  output [31:0] result
);

wire alu_src_inv = cntl[`ALU_SRC_INV];
wire alu_src_inc = cntl[`ALU_SRC_INC];
wire alu_use_carry = cntl[`ALU_USE_CARRY];
wire alu_no_wr = cntl[`ALU_NO_WR];

// Apply our carry bit if CF is high *and* the ALU is specifically asked to use it.
wire carry = alu_use_carry & status_in[`STAT_CF];

wire [32:0] opnd0_r_tmp = { 1'b0, opnd0_r };
wire [32:0] opnd1_r_tmp = { 1'b0, opnd1_r };

wire [32:0] result_add = opnd0_r_tmp + opnd1_r_tmp + { 32'b0, carry };
wire [32:0] result_sub = opnd0_r_tmp - opnd1_r_tmp + { 32'b0, carry };
wire [32:0] result_and = opnd0_r_tmp & opnd1_r_tmp;
wire [32:0] result_or = opnd0_r_tmp | opnd1_r_tmp;
wire [32:0] result_xor = opnd0_r_tmp ^ opnd1_r_tmp;
wire [32:0] result_mul = opnd0_r_tmp * opnd1_r_tmp;
wire [32:0] result_div = opnd0_r_tmp / opnd1_r_tmp;

wire [32:0] stat_result = cntl[`ALU_OP_ADD] ? result_add :
                          cntl[`ALU_OP_SUB] ? result_sub :
                          cntl[`ALU_OP_AND] ? result_sub :
                          cntl[`ALU_OP_OR]  ? result_sub :
                          cntl[`ALU_OP_XOR] ? result_sub :
                          cntl[`ALU_OP_MUL] ? result_sub :
                                              result_div;

assign status_out[`STAT_CF] = stat_result[32];
assign status_out[`STAT_PF] = 1'b0; // TODO
assign status_out[`STAT_ZF] = stat_result[31:0] == 32'b0;
assign status_out[`STAT_SF] = stat_result[31];
assign status_out[`STAT_OF] = 1'b0; // TODO

endmodule
