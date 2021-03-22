`include "defines.v"

module regfile(
  // Initial GPR/flag states.
  // We unconditionally modify the EIP, so no need for it as an input.
  input [31:0] i_eax, i_ebx, i_ecx, i_edx, i_esi, i_edi, i_esp, i_ebp, i_eflags,

  // GPR selector for register to update.
  // TODO(ww): We're probably going to need multiple of these, for
  // explicit register write + implicit register modify (like decrementing ECX)
  // Or: maybe we just include a counter wire that we use with the direction
  // flag to determine whether to increment/decrement ECX/EDX?
  // TODO(ww): We are definitely going to need multiple, for instructions that
  // modify 64-bit pairs like ECX:EDX.
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

// NOTE(ww): There is absolutely a better way to do this.
assign o_eax = gpr_selector == `REG_EAX ? gpr_wr : i_eax;
assign o_ebx = gpr_selector == `REG_EBX ? gpr_wr : i_ebx;
assign o_ecx = gpr_selector == `REG_ECX ? gpr_wr : i_ecx;
assign o_edx = gpr_selector == `REG_EDX ? gpr_wr : i_edx;
assign o_esi = gpr_selector == `REG_ESI ? gpr_wr : i_esi;
assign o_edi = gpr_selector == `REG_EDI ? gpr_wr : i_edi;
assign o_esp = gpr_selector == `REG_ESP ? gpr_wr : i_esp;
assign o_ebp = gpr_selector == `REG_EBP ? gpr_wr : i_ebp;

assign o_eip = next_eip;

// Status flag updates
assign o_eflags = alu_wr ?
  { i_eflags[31:12], alu_flags[5:4], i_eflags[9:8], alu_flags[3:2], i_eflags[5], alu_flags[1], i_eflags[3:1], alu_flags[0] }
  : i_eflags;

endmodule
