module decode_hint(
  input [71:0] raw_hint,

  output valid_hint,
  output [1:0] mask,
  output rw,
  output [31:0] address,
  output [31:0] data
);

assign mask = raw_hint[1:0];
assign rw = raw_hint[2];
assign valid_hint = raw_hint[7];

assign address = raw_hint[39:8];
assign data = raw_hint[71:40];

endmodule
