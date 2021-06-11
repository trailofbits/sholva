module agu(
  input [1:0] scale,
  input [31:0] index,
  input [31:0] base,
  input [31:0] disp,

  output [31:0] address
);

assign address = ((1 << scale) * index) + base + disp;

endmodule
