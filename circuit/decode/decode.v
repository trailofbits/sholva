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

  output [5:0] opc,
  output [31:0] opnd0_r,
  output [31:0] opnd1_r,
  output [31:0] opnd2_r,
  output [1:0] dest0_sel,
  output [1:0] dest1_sel
  // output [3:0] opnd_form,
  // output [31:0] eax, ebx, ecx, edx, esi, edi, esp, ebp, eip, eflags
);

// Decode prefix: Extract prefix information from the raw instruction.

wire [79:0] unprefixed_instr;
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
wire [71:0] unescaped_instr;

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

decode_opc_phase2 decode_opc_phase2_x(
  .unescaped_instr(unescaped_instr),
  .is_2byte(is_2byte),

  .opc(opc),
  .opnd_form(opnd_form),
  .opnd_count(opnd_count),
  .imm_1byte(imm_1byte),
  .reg_1byte(reg_1byte)
);

// Decode operands (phase 1): take the operand form and some information about widths,
// return concrete operand (read) values and a write selector.

wire disp_1byte;

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

  .opc(opc),
  .opnd_form(opnd_form),
  .imm_1byte(imm_1byte),
  .reg_1byte(reg_1byte),
  .prefix_operand_16bit(prefix_operand_16bit),
  .prefix_address_16bit(prefix_address_16bit),

  // Outputs
  .disp_1byte(disp_1byte),
  .opnd0_r(opnd0_r),
  .opnd1_r(opnd1_r),
  .opnd2_r(opnd2_r),
  .dest0_sel(dest0_sel),
  .dest1_sel(dest1_sel)
);


endmodule