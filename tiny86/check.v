`default_nettype none
module check(
  input [655:0] step0,
  input [655:0] step1,

  output ok
);

// TODO: Need to check memory hint consistency here as well.

// Output states.
wire [31:0] o_eax, o_ebx, o_ecx, o_edx, o_esi, o_edi, o_esp, o_ebp, o_eip, o_eflags;
wire [7:0] o_syscall_state;

tiny86 check0(
  .step(step0),

  .o_syscall_state(o_syscall_state),
  .o_eax(o_eax),
  .o_ebx(o_ebx),
  .o_ecx(o_ecx),
  .o_edx(o_edx),
  .o_esi(o_esi),
  .o_edi(o_edi),
  .o_esp(o_esp),
  .o_ebp(o_ebp),
  .o_eip(o_eip),
  .os_eax(ns_eax),
  .os_ebx(ns_ebx),
  .os_ecx(ns_ecx),
  .o_eflags(o_eflags)
);

// Next (input) states.
wire [31:0] n_eax, n_ebx, n_ecx, n_edx, n_esi, n_edi, n_esp, n_ebp, n_eip, n_eflags, ns_eax, ns_ebx, ns_ecx;

wire [95:0] _raw_instr;
wire [71:0] raw_hint1;
wire [71:0] raw_hint2;

fetch fetch1(
  .step(step1),

  .raw_instr(_raw_instr),
  .eax(n_eax),
  .ebx(n_ebx),
  .ecx(n_ecx),
  .edx(n_edx),
  .esi(n_esi),
  .edi(n_edi),
  .esp(n_esp),
  .ebp(n_ebp),
  .eip(n_eip),
  .eflags(n_eflags),
  .raw_hint1(raw_hint1),
  .raw_hint2(raw_hint2)
);

// NOTE(jl): could just instantiate whole `decode_hint` circuit here.
wire [7:0] meta1 = raw_hint1[71:64];
wire [7:0] meta2 = raw_hint2[71:64];
wire [7:0] n_syscall_state = {raw_hint1[6:3], raw_hint2[6:3]};

assign ok = (o_syscall_state == n_syscall_state) &&
            (o_eax == n_eax) &
            (o_ebx == n_ebx) &
            (o_ecx == n_ecx) &
            (o_edx == n_edx) &
            (o_esi == n_esi) &
            (o_edi == n_edi) &
            (o_esp == n_esp) &
            (o_ebp == n_ebp) &
            (o_eip == n_eip) &
            (o_eflags == n_eflags);

endmodule
