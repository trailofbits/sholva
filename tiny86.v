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

wire [6:0] opc;
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

endmodule
