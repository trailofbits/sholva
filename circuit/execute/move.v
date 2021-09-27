`include "defines.v"
`include "codegen/commands.gen.v"

module move(
  // Inputs.
  input [5:0] opc,
  input [31:0] opnd0_r,
  input [31:0] opnd1_r,

  // Outputs.
  output [31:0] opnd0_w,
  output [31:0] opnd1_w
);

endmodule
