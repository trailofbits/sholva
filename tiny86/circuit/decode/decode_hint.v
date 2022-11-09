module decode_hint(
  input [71:0] raw_hint,

  output valid_hint,
  output [1:0] mask,
  output is_write,
  output [31:0] address,
  output [31:0] data
);

`include "funcs.v"

wire [7:0] meta = raw_hint[71:64];

assign mask = meta[1:0];
assign is_write = meta[2];
assign valid_hint = meta[7];

assign address = raw_hint[63:32];
assign data = raw_hint[31:0];

endmodule
