`include "defines.v"
`include "codegen/commands.gen.v"

module move(
  // Inputs.
  input cntl,
  input [31:0] opnd0_r,
  input [31:0] opnd1_r,

  // Outputs.
  output [31:0] opnd0_w,
  output [31:0] opnd1_w
);

wire op_is_move = cntl;
wire op_is_swap = ~op_is_move;

// Move or swap, we always perform SRC -> DST.
assign opnd0_w = opnd1_r;

// For swaps, we also perform the second half.
assign opnd1_w = op_is_swap ? opnd0_r : opnd1_r;

endmodule
