module fetch(
  input [559:0] step,

  output [95:0] raw_instr,
  output [31:0] eax, ebx, ecx, edx, esi, edi, esp, ebp, eip, eflags,
  output [71:0] raw_hint1,
  output [71:0] raw_hint2
);

assign raw_instr = step[95:0];
assign raw_hint1 = step[559:488];
assign raw_hint2 = step[487:416];

decode_regfile decode_regfile_x(
  .raw_regs(step[415:96]),

  .eax(eax),
  .ebx(ebx),
  .ecx(ecx),
  .edx(edx),
  .esi(esi),
  .edi(edi),
  .esp(esp),
  .ebp(ebp),
  .eip(eip),
  .eflags(eflags)
);

endmodule
