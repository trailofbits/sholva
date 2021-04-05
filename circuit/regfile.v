`include "defines.v"

module regfile(
  // Initial GPR/flag states.
  // We unconditionally modify the EIP and EFLAGS, so no need for them as inputs.
  input [31:0] i_eax, i_ebx, i_ecx, i_edx, i_esi, i_edi, i_esp, i_ebp,

  input [1:0] dest0_kind, dest1_kind,
  input [2:0] dest0_sel, dest1_sel,
  input [31:0] opnd0_w, opnd1_w,

  // The next EIP value.
  input [31:0] next_eip,

  // The next EFLAGS value.
  input [31:0] next_eflags,

  // Output GPR/EIP/flag states.
  output [31:0] o_eax, o_ebx, o_ecx, o_edx, o_esi, o_edi, o_esp, o_ebp, o_eip, o_eflags
);

`include "funcs.v"

wire [7:0] dest0_sel_1hot = one_hot8(dest0_sel);
wire [7:0] dest1_sel_1hot = one_hot8(dest1_sel);

// Ugly.
assign o_eax = (dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_EAX]) ? opnd0_w :
               (dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_EAX]) ? opnd1_w : i_eax;

assign o_ebx = (dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_EBX]) ? opnd0_w :
               (dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_EBX]) ? opnd1_w : i_ebx;

assign o_ecx = (dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_ECX]) ? opnd0_w :
               (dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_ECX]) ? opnd1_w : i_ecx;

assign o_edx = (dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_EDX]) ? opnd0_w :
               (dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_EDX]) ? opnd1_w : i_edx;

assign o_esi = (dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_ESI]) ? opnd0_w :
               (dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_ESI]) ? opnd1_w : i_esi;

assign o_edi = (dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_EDI]) ? opnd0_w :
               (dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_EDI]) ? opnd1_w : i_edi;

assign o_esp = (dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_ESP]) ? opnd0_w :
               (dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_ESP]) ? opnd1_w : i_esp;

assign o_ebp = (dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_EBP]) ? opnd0_w :
               (dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_EBP]) ? opnd1_w : i_ebp;

assign o_eip = next_eip;
assign o_eflags = next_eflags;

endmodule
