`default_nettype none
`include "defines.v"

module regfile(
  // register file enabled.
  input en,

  // Initial GPR/flag states.
  input [31:0] i_eax, i_ebx, i_ecx, i_edx, i_esi, i_edi, i_esp, i_ebp, i_eip, i_eflags,

  // TODO(ww): Maybe special wires to signal stack inc/dec,
  // ECX/EDX and ESI:EDI inc/dec? Worth it?

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
assign o_eax = (en && dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_EAX]) ? opnd0_w :
               (en && dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_EAX]) ? opnd1_w : i_eax;

assign o_ebx = (en && dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_EBX]) ? opnd0_w :
               (en && dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_EBX]) ? opnd1_w : i_ebx;

assign o_ecx = (en && dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_ECX]) ? opnd0_w :
               (en && dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_ECX]) ? opnd1_w : i_ecx;

assign o_edx = (en && dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_EDX]) ? opnd0_w :
               (en && dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_EDX]) ? opnd1_w : i_edx;

assign o_esi = (en && dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_ESI]) ? opnd0_w :
               (en && dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_ESI]) ? opnd1_w : i_esi;

assign o_edi = (en && dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_EDI]) ? opnd0_w :
               (en && dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_EDI]) ? opnd1_w : i_edi;

assign o_esp = (en && dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_ESP]) ? opnd0_w :
               (en && dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_ESP]) ? opnd1_w : i_esp;

assign o_ebp = (en && dest0_kind[`OPND_DEST_REG] && dest0_sel_1hot[`REG_EBP]) ? opnd0_w :
               (en && dest1_kind[`OPND_DEST_REG] && dest1_sel_1hot[`REG_EBP]) ? opnd1_w : i_ebp;

assign o_eip = en ? next_eip : i_eip;
assign o_eflags = en ? next_eflags : i_eflags;

endmodule
