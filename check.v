`default_nettype none
module check(
  input [559:0] step0,
  input [559:0] step1,

  output ok
);

// TODO: Need to check memory hint consistency here as well.

// Output states.
wire [31:0] o_eax, o_ebx, o_ecx, o_edx, o_esi, o_edi, o_esp, o_ebp, o_eip, o_eflags;

// Next (input) states.
wire [31:0] n_eax, n_ebx, n_ecx, n_edx, n_esi, n_edi, n_esp, n_ebp, n_eip, n_eflags;

wire [95:0] unused_raw_instr;
wire [71:0] unused_raw_hint1;
wire [71:0] unused_raw_hint2;

tiny86 check0(
  .step(step0),

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

fetch fetch1(
  .step(step1),

  .raw_instr(unused_raw_instr),
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
  .raw_hint1(unused_raw_hint1),
  .raw_hint2(unused_raw_hint2)
);

assign ok = (o_eax == n_eax) &
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
