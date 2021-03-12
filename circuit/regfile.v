module regfile(
  input [31:0] i_eax, i_ebx, i_ecx, i_edx, i_esi, i_edi, i_esp, i_ebp, i_eip, i_eflags,

  // TODO(ww): other inputs:
  // * ALU flags
  // * Write selector
  // * Write value

  output [31:0] o_eax, o_ebx, o_ecx, o_edx, o_esi, o_edi, o_esp, o_ebp, o_eip, o_eflags
);

assign o_eax = i_eax;
assign o_ebx = i_ebx;
assign o_ecx = i_ecx;
assign o_edx = i_edx;
assign o_esi = i_esi;
assign o_edi = i_edi;
assign o_esp = i_esp;
assign o_ebp = i_ebp;
assign o_eip = i_eip;
assign o_eflags = i_eflags;

endmodule
