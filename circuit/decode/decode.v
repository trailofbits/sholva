module decode(
  input [95:0] raw_instr,
  input [31:0] eax,
  input [31:0] ebx,
  input [31:0] ecx,
  input [31:0] edx,
  input [31:0] esi,
  input [31:0] edi,
  input [31:0] esp,
  input [31:0] ebp,

  input hint1_is_write,
  input [31:0] hint1_address,
  input [31:0] hint1_data,
  input hint2_is_write,
  input [31:0] hint2_address,
  input [31:0] hint2_data,

  output [5:0] opc,
  output [31:0] opnd0_r,
  output [31:0] opnd1_r,
  output [31:0] opnd2_r,
  output [1:0] dest0_kind,
  output [1:0] dest1_kind,
  output [31:0] dest0_sel,
  output [31:0] dest1_sel
);

// Decode prefix: Extract prefix information from the raw instruction.

wire [87:0] unprefixed_instr;
wire prefix_operand_16bit;
wire prefix_address_16bit;
wire [1:0] prefix_rep;
wire [1:0] prefix_count;

decode_prefix decode_prefix_x(
  .raw_instr(raw_instr),

  .unprefixed_instr(unprefixed_instr),
  .prefix_operand_16bit(prefix_operand_16bit),
  .prefix_address_16bit(prefix_address_16bit),
  .prefix_rep(prefix_rep),
  .prefix_count(prefix_count)
);

// Decode opcode (phase 1): detect an opcode escape and truncate as appropriate.

wire is_2byte;
wire [87:0] unescaped_instr;

decode_opc_phase1 decode_opc_phase1_x(
  .unprefixed_instr(unprefixed_instr),

  .is_2byte(is_2byte),
  .unescaped_instr(unescaped_instr)
);

// Decode opcode (phase 2): extract the rough form of the opcode

wire [3:0] opnd_form;
wire [1:0] opnd_count;
wire imm_1byte;
wire reg_1byte;
wire opnd0_is_read;
wire opnd0_is_write;
wire opnd1_is_read;
wire opnd1_is_write;
wire opnd2_is_read;
wire opnd2_is_write;
wire source_is_sext;


decode_opc_phase2 decode_opc_phase2_x(
  .unescaped_instr(unescaped_instr),
  .is_2byte(is_2byte),

  .opc(opc),
  .opnd_form(opnd_form),
  .opnd_count(opnd_count),
  .imm_1byte(imm_1byte),
  .reg_1byte(reg_1byte),
  .opnd0_is_read(opnd0_is_read),
  .opnd0_is_write(opnd0_is_write),
  .opnd1_is_read(opnd1_is_read),
  .opnd1_is_write(opnd1_is_write),
  .opnd2_is_read(opnd2_is_read),
  .opnd2_is_write(opnd2_is_write),
  .source_is_sext(source_is_sext)
);

// Decode operands (phase 1): take the operand form and some information about widths,
// return concrete operand (read) values and a write selector.

decode_opnds decode_opnds_x(
  // Inputs
  .unescaped_instr(unescaped_instr),
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

  .opc(opc),
  .opnd_form(opnd_form),
  .imm_1byte(imm_1byte),
  .reg_1byte(reg_1byte),
  .prefix_operand_16bit(prefix_operand_16bit),
  .prefix_address_16bit(prefix_address_16bit),

  .opnd0_is_read(opnd0_is_read),
  .opnd0_is_write(opnd0_is_write),
  .opnd1_is_read(opnd1_is_read),
  .opnd1_is_write(opnd1_is_write),
  .opnd2_is_read(opnd2_is_read),
  .opnd2_is_write(opnd2_is_write),
  .source_is_sext(source_is_sext),

  // Outputs
  .opnd0_r(opnd0_r),
  .opnd1_r(opnd1_r),
  .opnd2_r(opnd2_r),
  .dest0_kind(dest0_kind),
  .dest1_kind(dest1_kind),
  .dest0_sel(dest0_sel),
  .dest1_sel(dest1_sel)
);


endmodule
