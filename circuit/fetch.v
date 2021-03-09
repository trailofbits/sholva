module fetch(
  input [559:0] step,

  output [95:0] raw_instr,
  output [319:0] raw_regs,
  output [71:0] raw_hint1,
  output [71:0] raw_hint2
);

assign raw_instr = step[95:0];
assign raw_regs = step[415:96];
assign raw_hint1 = step[487:416];
assign raw_hint2 = step[559:488];

endmodule
