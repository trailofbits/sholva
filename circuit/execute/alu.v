`include "defines.v"

module alu(
  input [13:0] cntl,
  input [4:0] status_in,
  input [31:0] opnd0_r,
  input [31:0] opnd1_r,

  output [4:0] status_out,
  output [31:0] result
);

wire alu_src_inv = cntl[`ALU_SRC_INV];
wire alu_src_inc = cntl[`ALU_SRC_INC];
wire alu_use_carry = cntl[`ALU_USE_CARRY];
wire alu_no_wr = cntl[`ALU_NO_WR];
wire alu_clear_cf = cntl[`ALU_CLEAR_CF];
wire alu_clear_of = cntl[`ALU_CLEAR_OF];

// Apply our carry bit if CF is high *and* the ALU is specifically asked to use it.
wire carry_in = alu_use_carry & status_in[`STAT_CF];

wire [32:0] opnd0_r_tmp = { 1'b0, opnd0_r };
wire [32:0] opnd1_r_tmp = { 1'b0, opnd1_r };

wire [32:0] result_add = opnd0_r_tmp + opnd1_r_tmp + { 32'b0, carry_in };
wire [32:0] result_sub = opnd0_r_tmp - opnd1_r_tmp + { 32'b0, carry_in };
wire [32:0] result_and = opnd0_r_tmp & opnd1_r_tmp;
wire [32:0] result_or = opnd0_r_tmp | opnd1_r_tmp;
wire [32:0] result_xor = opnd0_r_tmp ^ opnd1_r_tmp;
wire [32:0] result_mul = opnd0_r_tmp * opnd1_r_tmp;
wire [32:0] result_div = opnd0_r_tmp / opnd1_r_tmp;

wire [32:0] stat_result = cntl[`ALU_OP_ADD] ? result_add :
                          cntl[`ALU_OP_SUB] ? result_sub :
                          cntl[`ALU_OP_AND] ? result_and :
                          cntl[`ALU_OP_OR]  ? result_or  :
                          cntl[`ALU_OP_XOR] ? result_xor :
                          cntl[`ALU_OP_MUL] ? result_mul :
                                              result_div;

// TODO(ww): Fill these in.
wire cf_no_wr = alu_no_wr;
wire pf_no_wr = alu_no_wr;
wire zf_no_wr = alu_no_wr;
wire sf_no_wr = alu_no_wr;
wire of_no_wr = alu_no_wr;

assign status_out[`STAT_CF] = cf_no_wr     ? status_in[`STAT_CF] :
                              alu_clear_cf ? 1'b0 :
                              stat_result[32];

assign status_out[`STAT_PF] = pf_no_wr ? status_in[`STAT_PF] : ~^stat_result[31:0];

assign status_out[`STAT_ZF] = zf_no_wr ? status_in[`STAT_ZF] : stat_result[31:0] == 32'b0;

assign status_out[`STAT_SF] = sf_no_wr ? status_in[`STAT_SF] : stat_result[31];

assign status_out[`STAT_OF] = of_no_wr     ? status_in[`STAT_OF] :
                              alu_clear_of ? 1'b0 :
                              carry_in ^ stat_result[32];

// TODO(ww): Maybe get rid of alu_no_wr entirely and check it only in execute.v.
assign result = alu_no_wr ? 32'b0 : stat_result[31:0];

endmodule
