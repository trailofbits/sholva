`include "defines.v"

module regfile(
  // Initial GPR/flag states.
  // We unconditionally modify the EIP and EFLAGS, so no need for them as inputs.
  input [31:0] i_eax, i_ebx, i_ecx, i_edx, i_esi, i_edi, i_esp, i_ebp,

  // Potential modified GPR values.
  input [31:0] w_eax, w_ebx, w_ecx, w_edx, w_esi, w_edi, w_esp, w_ebp,

  // A write mask for selecting GPRs to update.
  input [7:0] gpr_wrmask,

  // The next EIP value.
  input [31:0] next_eip,

  // The next EFLAGS value.
  input [31:0] next_eflags,

  // Output GPR/EIP/flag states.
  output [31:0] o_eax, o_ebx, o_ecx, o_edx, o_esi, o_edi, o_esp, o_ebp, o_eip, o_eflags
);

assign o_eax = gpr_wrmask[`REG_EAX] ? w_eax : i_eax;
assign o_ebx = gpr_wrmask[`REG_EBX] ? w_ebx : i_ebx;
assign o_ecx = gpr_wrmask[`REG_ECX] ? w_ecx : i_ecx;
assign o_edx = gpr_wrmask[`REG_EDX] ? w_edx : i_edx;
assign o_esi = gpr_wrmask[`REG_ESI] ? w_esi : i_esi;
assign o_edi = gpr_wrmask[`REG_EDI] ? w_edi : i_edi;
assign o_esp = gpr_wrmask[`REG_ESP] ? w_esp : i_esp;
assign o_ebp = gpr_wrmask[`REG_EBP] ? w_ebp : i_ebp;

assign o_eip = next_eip;
assign o_eflags = next_eflags;

endmodule
