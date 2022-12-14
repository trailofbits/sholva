module decode_opc_phase1(
  input [87:0] unprefixed_instr,

  output is_2byte,
  output [87:0] unescaped_instr
);

assign is_2byte = (unprefixed_instr[7:0] == 8'h0F);
assign unescaped_instr = (is_2byte) ? ({8'd0, unprefixed_instr[87:8]}) : unprefixed_instr;

endmodule
