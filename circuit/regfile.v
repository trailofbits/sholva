`include "defines.v"

module regfile(
  // Initial GPR/EIP/flag states.
  input [31:0] i_eax, i_ebx, i_ecx, i_edx, i_esi, i_edi, i_esp, i_ebp, i_eip, i_eflags,

  // GPR selector and value to write.
  input [2:0] gpr_selector,
  input [31:0] gpr_wr,

  // The next EIP value.
  input [31:0] next_eip,

  // ALU write flag + flag states.
  input alu_wr,
  input [5:0] alu_flags, // 0:CF, 1:PF, 2:ZF, 3:SF, 4:OF, 5:DF

  // Output GPR/EIP/flag states.
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

assign o_eip = next_eip;

// Status flag updates
assign o_eflags = alu_wr ?
  { i_eflags[31:12], alu_flags[5:4], i_eflags[9:8], alu_flags[3:2], i_eflags[5], alu_flags[1], i_eflags[3:1], alu_flags[0] }
  : i_eflags;

endmodule
