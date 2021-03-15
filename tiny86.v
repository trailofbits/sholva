module tiny86(
  input [559:0] step
);

// Fetch: Extract the individual components from a trace step.

wire [95:0] raw_instr;
wire [319:0] raw_regs;
wire [71:0] raw_hint1;
wire [71:0] raw_hint2;

fetch fetch_x(
  .step(step),

  .raw_instr(raw_instr),
  .raw_regs(raw_regs),
  .raw_hint1(raw_hint1),
  .raw_hint2(raw_hint2)
);

// Decode regfile.
wire [31:0] eax, ebx, ecx, edx, esi, edi, esp, ebp, eip, eflags;

decode_regfile decode_regfile_x(
  .raw_regs(raw_regs),

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


// Decode hints.
wire [1:0] hint1_mask;
wire hint1_rw;
wire [31:0] hint1_address;
wire [31:0] hint1_data;

decode_hint decode_hint1(
  .raw_hint(raw_hint1),

  .mask(hint1_mask),
  .rw(hint1_rw),
  .address(hint1_address),
  .data(hint1_data)
);

wire [1:0] hint2_mask;
wire hint2_rw;
wire [31:0] hint2_address;
wire [31:0] hint2_data;

decode_hint decode_hint2(
  .raw_hint(raw_hint2),

  .mask(hint2_mask),
  .rw(hint2_rw),
  .address(hint2_address),
  .data(hint2_data)
);


// Decode prefix: Extract prefix information from the raw instruction.

wire [79:0] unprefixed_instr;
wire prefix_operand_32bit;
wire prefix_address_32bit;
wire [1:0] prefix_rep;
wire [1:0] prefix_count;

decode_prefix decode_prefix_x(
  .raw_instr(raw_instr),

  .unprefixed_instr(unprefixed_instr),
  .prefix_operand_32bit(prefix_operand_32bit),
  .prefix_address_32bit(prefix_address_32bit),
  .prefix_rep(prefix_rep),
  .prefix_count(prefix_count)
);

// Decode opcode (phase 1): detect an opcode escape and truncate as appropriate.

wire is_2byte;
wire [71:0] unescaped_instr;

decode_opc_phase1 decode_opc_phase1_x(
  .unprefixed_instr(unprefixed_instr),

  .is_2byte(is_2byte),
  .unescaped_instr(unescaped_instr)
);

// Decode opcode (phase 2): extract the rough form of the opcode

wire [5:0] opc;
wire [3:0] opnd_form;
wire imm_1byte;
wire reg_1byte;

decode_opc_phase2 decode_opc_phase2_x(
  .unescaped_instr(unescaped_instr),
  .is_2byte(is_2byte),

  .opc(opc),
  .opnd_form(opnd_form),
  .imm_1byte(imm_1byte),
  .reg_1byte(reg_1byte)
);

// Decode operands (phase 1): take the operand form and some information about widths,
// return concrete operand selectors.

// TODO


// Execute
// TODO


// Register writeback + updates.
wire [31:0] o_eax, o_ebx, o_ecx, o_edx, o_esi, o_edi, o_esp, o_ebp, o_eip, o_eflags;

regfile regfile_x(
  .i_eax(eax),
  .i_ebx(ebx),
  .i_ecx(ecx),
  .i_edx(edx),
  .i_esi(esi),
  .i_edi(edi),
  .i_esp(esp),
  .i_ebp(ebp),
  .i_eip(eip),
  .i_eflags(eflags),

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
