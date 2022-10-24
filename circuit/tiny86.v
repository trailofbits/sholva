`include "defines.v"

module tiny86(
  input [559:0] step,

  output [31:0] o_eax,
  output [31:0] o_ebx,
  output [31:0] o_ecx,
  output [31:0] o_edx,
  output [31:0] o_esi,
  output [31:0] o_edi,
  output [31:0] o_esp,
  output [31:0] o_ebp,
  output [31:0] o_eip,
  output [31:0] o_eflags
);

// Fetch: Extract the individual components from a trace step.

wire [95:0] raw_instr;
wire [31:0] eax, ebx, ecx, edx, esi, edi, esp, ebp, eip, eflags;
wire [71:0] raw_hint1;
wire [71:0] raw_hint2;

fetch fetch_x(
  .step(step),

  .raw_instr(raw_instr),
  .eax(eax),
  .ebx(ebx),
  .ecx(ecx),
  .edx(edx),
  .esi(esi),
  .edi(edi),
  .esp(esp),
  .ebp(ebp),
  .eip(eip),
  .eflags(eflags),
  .raw_hint1(raw_hint1),
  .raw_hint2(raw_hint2)
);

// Decode hints.
wire hint1_valid;
wire [3:0] hint1_syscall_state;
wire [1:0] hint1_mask;
wire hint1_is_write;
wire [31:0] hint1_address;
wire [31:0] hint1_data;

decode_hint decode_hint1(
  .raw_hint(raw_hint1),

  .valid_hint(hint1_valid),
  .syscall_state(hint1_syscall_state),
  .mask(hint1_mask),
  .is_write(hint1_is_write),
  .address(hint1_address),
  .data(hint1_data)
);

wire hint2_valid;
wire [3:0] hint2_syscall_state;
wire [1:0] hint2_mask;
wire hint2_is_write;
wire [31:0] hint2_address;
wire [31:0] hint2_data;

decode_hint decode_hint2(
  .raw_hint(raw_hint2),

  .valid_hint(hint2_valid),
  .syscall_state(hint2_syscall_state),
  .mask(hint2_mask),
  .is_write(hint2_is_write),
  .address(hint2_address),
  .data(hint2_data)
);


// Core instruction decoding: extract the core instruction semantics, decompose
// operands into their concrete 32-bit values, extract reg/mem selectors for
// writeback.
wire [3:0] instr_len;
wire [6:0] opc;
wire [31:0] opnd0_r;
wire [31:0] opnd1_r;
wire [31:0] opnd2_r;
wire [1:0] dest0_kind;
wire [1:0] dest1_kind;
wire [31:0] dest0_sel;
wire [31:0] dest1_sel;

decode decode_instr(
  .raw_instr(raw_instr),
  .eax(eax),
  .ebx(ebx),
  .ecx(ecx),
  .edx(edx),
  .esi(esi),
  .edi(edi),
  .esp(esp),
  .ebp(ebp),

  .hint1_is_write(hint1_is_write),
  .hint1_address(hint1_address),
  .hint1_data(hint1_data),

  .hint2_is_write(hint2_is_write),
  .hint2_address(hint2_address),
  .hint2_data(hint2_data),

  .instr_len(instr_len),
  .opc(opc),
  .opnd0_r(opnd0_r),
  .opnd1_r(opnd1_r),
  .opnd2_r(opnd2_r),
  .dest0_kind(dest0_kind),
  .dest1_kind(dest1_kind),
  .dest0_sel(dest0_sel),
  .dest1_sel(dest1_sel)
);


// Execute
wire ecx_is_zero = ecx == 32'b0;

wire [31:0] next_eflags;
wire [31:0] next_eip;
wire [31:0] opnd0_w;
wire [31:0] opnd1_w;

execute execute_x(
  .opc(opc),
  .eax(eax),
  .eflags(eflags),
  .ecx_is_zero(ecx_is_zero),
  .eip(eip),
  .instr_len(instr_len),
  .opnd0_r(opnd0_r),
  .opnd1_r(opnd1_r),
  .opnd2_r(opnd2_r),

  .o_eflags(next_eflags),
  .next_eip(next_eip),
  .opnd0_w(opnd0_w),
  .opnd1_w(opnd1_w)
);

// Syscall.

// FIXME(jl): how to integrate these with state in hints.
wire [3:0] i_syscall_state;
wire [3:0] o_syscall_state;

syscall syscall_x(
    .i_eax(eax),
    .i_ebx(ebx),
    .i_ecx(ecx),
    .i_syscall_state(i_syscall_state),
    .o_eax(o_eax),
    .o_ebx(o_ebx),
    .o_ecx(o_ecx),
    .o_syscall_state(o_syscall_state)
);

// Register writeback + updates.

// TODO(jl): the register file needs to swap 'ignore' the execute unit in the case of a syscall.
regfile regfile_x(
  .i_eax(eax),
  .i_ebx(ebx),
  .i_ecx(ecx),
  .i_edx(edx),
  .i_esi(esi),
  .i_edi(edi),
  .i_esp(esp),
  .i_ebp(ebp),

  .dest0_kind(dest0_kind),
  .dest1_kind(dest1_kind),

  .dest0_sel(dest0_sel[2:0]),
  .dest1_sel(dest1_sel[2:0]),

  .opnd0_w(opnd0_w),
  .opnd1_w(opnd1_w),

  .next_eflags(next_eflags),
  .next_eip(next_eip),

  .o_eax(o_eax),
  .o_ebx(o_ebx),
  .o_ecx(o_ecx),
  .o_edx(o_edx),
  .o_esi(o_esi),
  .o_edi(o_edi),
  .o_esp(o_esp),
  .o_ebp(o_ebp),
  .o_eip(o_eip),
  .o_eflags(o_eflags)
);

endmodule
