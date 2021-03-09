module decode_opc_phase1(
  input [79:0] unprefixed_instr,

  output is_2byte,
  output [71:0] unescaped_instr
);

assign is_2byte = (unprefixed_instr[7:0] == 8'h0F);
assign unescaped_instr = (is_2byte) ? unprefixed_instr[79:8] : unprefixed_instr[71:0];

endmodule
