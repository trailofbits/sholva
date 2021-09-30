`include "codegen/commands.gen.v"
`include "defines.v"

module decode_opnds(
  input [87:0] unescaped_instr,
  input [31:0] eax, ebx, ecx, edx, esi, edi, esp, ebp,

  input hint1_is_write,
  input [31:0] hint1_address,
  input [31:0] hint1_data,
  input hint2_is_write,
  input [31:0] hint2_address,
  input [31:0] hint2_data,

  input [5:0] opc,
  input [3:0] opnd_form,
  input imm_1byte,
  input reg_1byte,
  input prefix_operand_16bit,
  input prefix_address_16bit,

  input opnd0_is_read,
  input opnd0_is_write,
  input opnd1_is_read,
  input opnd1_is_write,
  input opnd2_is_read,
  input opnd2_is_write,
  input source_is_sext,

  output [3:0] instr_body_len,
  output [31:0] opnd0_r,
  output [31:0] opnd1_r,
  output [31:0] opnd2_r,

  output [1:0] dest0_kind,
  output [1:0] dest1_kind,
  output [31:0] dest0_sel,
  output [31:0] dest1_sel
);

`include "funcs.v"

wire [3:0] imm_disp_len;
wire has_imm;
wire has_modrm;
wire has_sib;
wire has_disp;
wire is_disp8;
wire is_disp32;

wire [7:0] modrm;
wire [7:0] sib;
wire [31:0] disp;
wire [31:0] imm;

wire modrm_rm_is_reg_direct;

wire opnd0_modrm_rm;
wire opnd0_modrm_reg;
wire opnd0_disp;
wire opnd1_modrm_rm;
wire opnd1_modrm_reg;
wire opnd1_disp;

decode_opnd_signals decode_opnd_signals_x(
  // Inputs
  .unescaped_instr(unescaped_instr),
  .opnd_form(opnd_form),
  .prefix_address_16bit(prefix_address_16bit),
  .prefix_operand_16bit(prefix_operand_16bit),
  .imm_1byte(imm_1byte),
  .source_is_sext(source_is_sext),

  // Outputs
  .imm_disp_len(imm_disp_len),
  .has_imm(has_imm),
  .has_modrm(has_modrm),
  .has_sib(has_sib),
  .has_disp(has_disp),
  .is_disp8(is_disp8),
  .is_disp32(is_disp32),

  .modrm(modrm),
  .sib(sib),
  .disp(disp),
  .imm(imm),

  .modrm_rm_is_reg_direct(modrm_rm_is_reg_direct),

  .opnd0_modrm_rm(opnd0_modrm_rm),
  .opnd0_modrm_reg(opnd0_modrm_reg),
  .opnd0_disp(opnd0_disp),
  .opnd1_modrm_rm(opnd1_modrm_rm),
  .opnd1_modrm_reg(opnd1_modrm_reg),
  .opnd1_disp(opnd1_disp)
);

wire [15:0] opnd_form_1hot = one_hot16(opnd_form);
wire [63:0] opc_1hot = one_hot64(opc);


// Whether ModR/M.rm indicates a register indirect selector,
// i.e. a base address (and maybe a displacement).
wire modrm_rm_is_reg_indirect = ~has_sib
                             && ~modrm_rm_is_reg_direct
                             && modrm[7:6] != 2'b00
                             && modrm[2:0] != 3'b101;

wire [2:0] sib_base_regsel = sib[2:0];
wire [2:0] sib_index_regsel = sib[5:3];
wire [1:0] sib_scale = sib[7:6];

// SIB.base == 0b101 indicates scaled-index mode with no base register.
wire sib_no_base = sib_base_regsel == 3'b101 && modrm[7:6] == 2'b00;

// SIB.index == 0b100 indicates no index while in SIB addressing mode.
wire sib_no_index = sib_index_regsel == 3'b100;

///
/// OPERAND EXTRACTION
///

// The annoying and hard to visualize bit: we don't have any real control flow,
// so we have to compute each operand's prospective value as if it was an
// immediate, displacement, register, and memory operand. Then, we get to
// select from those unconditional computations based on which one it actually
// is.

///
/// REGISTER OPERANDS
///


// Is operand#0 a register?
wire opnd0_is_reg = opnd_form_1hot[`OPND_ENC_REG] ||
                    opnd_form_1hot[`OPND_ENC_MODREGRM_RM] ||
                    opnd_form_1hot[`OPND_ENC_EAX_IMM] ||
                    opnd_form_1hot[`OPND_ENC_EAX_REG] ||
                    opnd_form_1hot[`OPND_ENC_REG_IMM] ||
                    (opnd0_modrm_rm && modrm_rm_is_reg_direct) ||
                    opnd0_modrm_reg;

// For operand#0, our register selector can come from four sources:
// TODO(ww): That's wrong. We also need to handle implicit register selector operands here,
// like some of the "zero-operand" encodings. Needs thought.
// * The lower three bits of the opcode itself (OPND_ENC_REG, OPND_ENC_REG_IMM)
// * The r/m selector of ModR/M (OPND_ENC_MODREGRM_RM_*) when in register direct mode (mod=0b11)
// * The reg selector of ModR/M (OPND_ENC_MODREGRM_REG_*)
// * An implicit EAX register (OPND_ENC_EAX_*)
wire [2:0] opnd0_r_regsel = (opnd_form_1hot[`OPND_ENC_REG] || opnd_form_1hot[`OPND_ENC_REG_IMM]) ?
                                unescaped_instr[2:0] :
                            (opnd0_modrm_rm && modrm_rm_is_reg_direct) ?
                                modrm[2:0] :
                            (opnd0_modrm_reg) ?
                                modrm[5:3] :
                            (opnd_form_1hot[`OPND_ENC_EAX_IMM] || opnd_form_1hot[`OPND_ENC_EAX_REG]) ?
                                `REG_EAX : 3'b0;

// Is operand#1 a register?
wire opnd1_is_reg = opnd_form_1hot[`OPND_ENC_EAX_REG] ||
                    (opnd1_modrm_rm && modrm_rm_is_reg_direct) ||
                    opnd1_modrm_reg;

// For operand#1, our register selector can come from N sources:
// * The r/m selector of ModR/M (OPND_ENC_MODREGRM_REG_RM*) when in register direct mode (mod=0b11)
// * The reg selector of ModR/M (OPND_ENC_MODREGRM_RM_REG*)
// * The lower three bits of the opcode itself (OPND_ENC_*_REG)
// * TODO(ww): Implicit opnd1 register sources? Presumably some of the string operations?
wire [2:0] opnd1_r_regsel = (opnd1_modrm_rm && modrm_rm_is_reg_direct) ?
                                modrm[2:0] :
                            (opnd1_modrm_reg) ?
                                modrm[5:3] :
                            (opnd_form_1hot[`OPND_ENC_EAX_REG]) ?
                                unescaped_instr[2:0] : 3'b0;

// TODO(ww): operand#2 regsel. This can only ever be CL.

// Finally, actually grab some values using our operand selectors.
wire [31:0] opnd0_r_regval;
mux8_32 mux8_32_opnd0_reg(
  .sel(opnd0_r_regsel),
  .in0(eax),
  .in1(ecx),
  .in2(edx),
  .in3(ebx),
  .in4(esp),
  .in5(ebp),
  .in6(esi),
  .in7(edi),

  .out(opnd0_r_regval)
);

wire [31:0] opnd1_r_regval;
mux8_32 mux8_32_opnd1_reg(
  .sel(opnd1_r_regsel),
  .in0(eax),
  .in1(ecx),
  .in2(edx),
  .in3(ebx),
  .in4(esp),
  .in5(ebp),
  .in6(esi),
  .in7(edi),

  .out(opnd1_r_regval)
);

///
/// END REGISTER OPERANDS
///

///
/// MEMORY OPERANDS
///

// Is operand#0 a memory address?
// TODO(ww): Missing anything?
wire opnd0_r_is_mem_modrm = (opnd0_modrm_rm && ~modrm_rm_is_reg_direct);
wire opnd0_is_mem = opnd0_r_is_mem_modrm ||
                    opc_1hot[`CMD_MOVS] ||
                    opc_1hot[`CMD_CMPS] ||
                    opc_1hot[`CMD_SCAS];

// Is operand#1 a memory address?
// TODO(ww): Missing anything?
wire opnd1_r_is_mem_modrm = (opnd1_modrm_rm && ~modrm_rm_is_reg_direct);
wire opnd1_is_mem = opnd1_r_is_mem_modrm ||
                    opc_1hot[`CMD_MOVS] ||
                    opc_1hot[`CMD_CMPS] ||
                    opc_1hot[`CMD_STOS] ||
                    opc_1hot[`CMD_LODS];

// To actually calculate our effective addresses for operand#0 and operand#1,
// we need to get the (scale, index, base, displacement) for each, or
// appropriate dummy values.
// Selecting the base register selector goes as follows:
// * If we have a SIB byte, it's the SIB base selector.
// * If we have a bare ModR/M byte with ModR/M.mod != 0b11, it's the ModR/M.rm
//   selector.
// * Otherwise, it's an implicit selector for one of the string/data
//   instructions, which means that it's EDI or ESI.

wire [1:0] opnd0_r_mem_scale = (opnd0_r_is_mem_modrm && has_sib)
                               ? sib_scale : 2'b00;
wire [2:0] opnd0_r_mem_index_regsel = (opnd0_r_is_mem_modrm && has_sib)
                                      ? sib_index_regsel : 3'b000;


wire [1:0] opnd1_r_mem_scale = (opnd1_r_is_mem_modrm && has_sib)
                               ? sib_scale : 2'b00;
wire [2:0] opnd1_r_mem_index_regsel = (opnd1_r_is_mem_modrm && has_sib)
                                      ? sib_index_regsel : 3'b000;


// A "generic" base register selector, specialized for opnd0/1 below.
wire [2:0] opndX_r_mem_base_regsel =
  has_sib ?
    sib_base_regsel :
  ((opnd0_modrm_rm || opnd1_modrm_rm) && ~modrm_rm_is_reg_direct) ?
    modrm[2:0] : 3'b000;

wire [2:0] opnd0_r_mem_base_regsel =
  (opc_1hot[`CMD_MOVS] || opc_1hot[`CMD_STOS] || opc_1hot[`CMD_SCAS]) ?
    `REG_EDI :
  (opc_1hot[`CMD_CMPS]) ?
    `REG_ESI : opndX_r_mem_base_regsel;

wire [2:0] opnd1_r_mem_base_regsel =
  (opc_1hot[`CMD_MOVS] || opc_1hot[`CMD_LODS]) ?
    `REG_ESI :
  (opc_1hot[`CMD_CMPS]) ?
    `REG_EDI : opndX_r_mem_base_regsel;

wire [31:0] opnd0_r_mem_disp = opnd0_disp ? disp : 32'b0;
wire [31:0] opnd1_r_mem_disp = opnd1_disp ? disp : 32'b0;

wire [31:0] opnd0_r_mem_selected_index;
mux8_32 mux8_32_opnd0_mem_index(
  .sel(opnd0_r_mem_index_regsel),
  .in0(eax),
  .in1(ecx),
  .in2(edx),
  .in3(ebx),
  .in4(esp),
  .in5(ebp),
  .in6(esi),
  .in7(edi),

  .out(opnd0_r_mem_selected_index)
);

wire [31:0] opnd1_r_mem_selected_index;
mux8_32 mux8_32_opnd1_mem_index(
  .sel(opnd1_r_mem_index_regsel),
  .in0(eax),
  .in1(ecx),
  .in2(edx),
  .in3(ebx),
  .in4(esp),
  .in5(ebp),
  .in6(esi),
  .in7(edi),

  .out(opnd1_r_mem_selected_index)
);

wire [31:0] opnd0_r_mem_effective_index = sib_no_index ? 32'b0 : opnd0_r_mem_selected_index;
wire [31:0] opnd1_r_mem_effective_index = sib_no_index ? 32'b0 : opnd1_r_mem_selected_index;

wire [31:0] opnd0_r_mem_selected_base;
mux8_32 mux8_32_opnd0_mem_base(
  .sel(opnd0_r_mem_base_regsel),
  .in0(eax),
  .in1(ecx),
  .in2(edx),
  .in3(ebx),
  .in4(esp),
  .in5(ebp),
  .in6(esi),
  .in7(edi),

  .out(opnd0_r_mem_selected_base)
);

wire [31:0] opnd1_r_mem_selected_base;
mux8_32 mux8_32_opnd1_mem_base(
  .sel(opnd1_r_mem_base_regsel),
  .in0(eax),
  .in1(ecx),
  .in2(edx),
  .in3(ebx),
  .in4(esp),
  .in5(ebp),
  .in6(esi),
  .in7(edi),

  .out(opnd1_r_mem_selected_base)
);

// TODO(ww): Need to handle implicit bases here.
wire [31:0] opnd0_r_mem_effective_base = (modrm_rm_is_reg_indirect || ~sib_no_base)
                                         ? opnd0_r_mem_selected_base : 32'b0;

wire [31:0] opnd1_r_mem_effective_base = (modrm_rm_is_reg_indirect || ~sib_no_base)
                                         ? opnd1_r_mem_selected_base : 32'b0;

// Finally, actually calculate our effective memory address for operand#0 and operand#1.
wire [31:0] opnd0_r_mem_addr;
agu opnd0_r_mem_agu(
  .scale(opnd0_r_mem_scale),
  .index(opnd0_r_mem_effective_index),
  .base(opnd0_r_mem_effective_base),
  .disp(opnd0_r_mem_disp),

  .address(opnd0_r_mem_addr)
);

wire [31:0] opnd1_r_mem_addr;
agu opnd1_r_mem_agu(
  .scale(opnd1_r_mem_scale),
  .index(opnd1_r_mem_effective_index),
  .base(opnd1_r_mem_effective_base),
  .disp(opnd1_r_mem_disp),

  .address(opnd1_r_mem_addr)
);

// Edge case: LEA uses the AGU, but doesn't actually read memory.
// When we have a "phony" operation like this, we return the computed effective
// address rather than the matching hint's data.
wire memop_is_phony = opc_1hot[`CMD_LEA];

wire [31:0] opnd0_r_memval = memop_is_phony ? opnd0_r_mem_addr
                           : (~hint1_is_write && hint1_address == opnd0_r_mem_addr) ? hint1_data
                           : (~hint2_is_write && hint2_address == opnd0_r_mem_addr) ? hint2_data
                           : 32'b0;


wire [31:0] opnd1_r_memval = memop_is_phony ? opnd1_r_mem_addr
                           : (~hint1_is_write && hint1_address == opnd1_r_mem_addr) ? hint1_data
                           : (~hint2_is_write && hint2_address == opnd1_r_mem_addr) ? hint2_data
                           : 32'b0;


///
/// END MEMORY OPERANDS
///

///
/// BEGIN IMMEDIATE OPERANDS
///

// TODO(ww): Trinary opcode forms where operand#2 is an immediate.

wire opnd0_is_imm = opnd_form_1hot[`OPND_ENC_IMM];

wire opnd1_is_imm = opnd_form_1hot[`OPND_ENC_MODREGRM_RM_IMM] ||
                    opnd_form_1hot[`OPND_ENC_REG_IMM] ||
                    opnd_form_1hot[`OPND_ENC_EAX_IMM];

// Unconditionally assign these, since we'll mux them correctly later.
wire [31:0] opnd0_r_immval = imm;
wire [31:0] opnd1_r_immval = imm;

///
/// END IMMEDIATE OPERANDS
///

///
/// BEGIN DISPLACEMENT OPERANDS
///

// NOTE(ww): Our displacement handling is simple, since we only support two
// displacement operand forms and both are unary.

wire opnd0_is_disp = 1'b0;

///
/// END DISPLACEMENT OPERANDS
///

// TODO(ww): Immediate and memory operands.
// TODO(ww): "Implicit" immediates, like `INC reg` -> `ADD reg, 1`

///
/// END OPERAND EXTRACTION
///

// TODO(ww): This eventually needs to be a multiplexor against
// opndN_r_regval, opndN_r_memval, opndN_r_immval, etc.
// TODO(ww): Also handle special operand fixups here. For example, opnd1_r
// will be 32'b1 for CMD_NOT.
assign opnd0_r = opnd0_is_reg ? opnd0_r_regval :
                 opnd0_is_mem ? opnd0_r_memval :
                 opnd0_is_imm ? opnd0_r_immval : 32'b0;

assign opnd1_r = opnd1_is_reg ? opnd1_r_regval :
                 opnd1_is_mem ? opnd1_r_memval :
                 opnd1_is_imm ? opnd1_r_immval : 32'b0;


assign opnd2_r = 32'd0;

// TODO(ww): Is this the right place for this? Maybe we should do it
// further on in instruction decoding, when looking at `opc` more closely.
assign dest0_kind = !opnd0_is_write ? `OPND_DEST_NONE
                  : opnd0_is_reg ? `OPND_DEST_REG_1HOT
                  : opnd0_is_mem ? `OPND_DEST_MEM_1HOT
                  : `OPND_DEST_NONE;

assign dest1_kind = !opnd1_is_write ? `OPND_DEST_NONE
                  : opnd1_is_reg ? `OPND_DEST_REG_1HOT
                  : opnd1_is_mem ? `OPND_DEST_MEM_1HOT
                  : `OPND_DEST_NONE;

assign dest0_sel = dest0_kind[`OPND_DEST_REG] ?
                                 { 29'b0, opnd0_r_regsel } : 32'b0;
assign dest1_sel = dest1_kind[`OPND_DEST_REG] ?
                                 { 29'b0, opnd1_r_regsel } : 32'b0;

assign instr_body_len = (has_modrm ? 4'd1 : 4'd0) + (has_sib ? 4'd1 : 4'd0) + imm_disp_len;

endmodule
