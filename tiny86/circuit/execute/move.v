`default_nettype none

`include "defines.v"
`include "codegen/commands.gen.v"

module move(
  // Inputs.
  input [1:0] cntl,
  input [31:0] opnd0_r,
  input [31:0] opnd1_r,

  // Outputs.
  output [31:0] opnd0_w,
  output [31:0] opnd1_w
);

wire op_is_move = cntl[`MU_MOVE];
wire op_is_swap = ~op_is_move;

wire op_is_sext = cntl[`MU_SEXT];

// Move or swap, we always perform SRC -> DST.
// With MU_SEXT, DST is the sign extension of SRC.
assign opnd0_w = op_is_sext ? {32{opnd1_r[31]}} : opnd1_r;

// For swaps, we also perform the second half.
assign opnd1_w = op_is_swap ? opnd0_r : opnd1_r;

endmodule
