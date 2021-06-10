`include "codegen/commands.gen.v"
`include "defines.v"

module decode_opnd_signals(
  input [71:0] unescaped_instr,
  input [3:0] opnd_form,
  input prefix_address_16bit,

  output has_imm,
  output has_modrm,
  output has_sib,
  output has_disp,

  output [7:0] modrm,
  output [7:0] sib,

  output modrm_rm_is_reg_direct,

  output opnd0_modrm_rm,
  output opnd0_modrm_reg,
  output opnd1_modrm_rm,
  output opnd1_modrm_reg
);

`include "funcs.v"

wire [15:0] opnd_form_1hot = one_hot16(opnd_form);

// Whether we have any immediate byte(s).
assign has_imm = opnd_form_1hot[`OPND_ENC_IMM] ||
               opnd_form_1hot[`OPND_ENC_MODREGRM_RM_IMM] ||
               opnd_form_1hot[`OPND_ENC_REG_IMM] ||
               opnd_form_1hot[`OPND_ENC_EAX_IMM] ||
               opnd_form_1hot[`OPND_ENC_MODREGRM_REG_RM_IMM] ||
               opnd_form_1hot[`OPND_ENC_MODREGRM_RM_REG_IMM];

// ModR/M encodings where R/M is operand#0 (i.e. op.d=0)
assign opnd0_modrm_rm = opnd_form_1hot[`OPND_ENC_MODREGRM_RM] ||
                      opnd_form_1hot[`OPND_ENC_MODREGRM_RM_IMM] ||
                      opnd_form_1hot[`OPND_ENC_MODREGRM_RM_REG] ||
                      opnd_form_1hot[`OPND_ENC_MODREGRM_RM_REG_IMM] ||
                      opnd_form_1hot[`OPND_ENC_MODREGRM_RM_REG_CL];


// ModR/M encodings where REG is operand#0 (i.e. op.d=1)
assign opnd0_modrm_reg = opnd_form_1hot[`OPND_ENC_MODREGRM_REG_RM] ||
                       opnd_form_1hot[`OPND_ENC_MODREGRM_REG_RM_IMM];


// ModR/M encodings where R/M is operand#1.
assign opnd1_modrm_rm = opnd0_modrm_reg;

// ModR/M encodings where REG is operand#1.
assign opnd1_modrm_reg = opnd_form_1hot[`OPND_ENC_MODREGRM_RM_REG] ||
                       opnd_form_1hot[`OPND_ENC_MODREGRM_RM_REG_IMM] ||
                       opnd_form_1hot[`OPND_ENC_MODREGRM_RM_REG_CL];

// Whether we have a ModR/M byte supplying one or more operands.
assign has_modrm = opnd0_modrm_rm || opnd0_modrm_reg;

// The actual ModR/M byte, if `has_modrm`.
assign modrm = unescaped_instr[15:8];

// Whether ModR/M.rm indicates a register, i.e. "register direct".
assign modrm_rm_is_reg_direct = modrm[7:6] == 2'b11;

// Intel SDM Vol. 2A Table 2-1/2-2/2-3: the SIB byte is only present when all
// of the following conditions hold:
//  * The ModR/M byte is present;
//  * We are not performing a 16-bit addressing operation;
//  * We are not in register direct mode and ModR/M.rm == 0b100
assign has_sib = has_modrm
               && ~prefix_address_16bit
               && ~modrm_rm_is_reg_direct
               && modrm[2:0] == 3'b100;

// The actual SIB byte, if `has_sib`.
assign sib = unescaped_instr[23:16];

// Whether we have displacement byte(s).
// Displacement byte(s) are present in two cases:
// First, when all of the following conditions hold:
// * The ModR/M byte is present;
// * We are not in register direct mode;
// * One of:
//   * We are in a displacement-only mode (ModR/M.rm == 0b101 and ModR/M.mod == 0b00)
//   * We are in an indirect + displacement addressing mode (ModR/M.mod == 0b01 or 0b10)
// Second, when we are in a displacement-only encoding (i.e., no ModR/M whatsoever).
// TODO(ww): Handle that second case.
assign has_disp = (has_modrm
                   && ~modrm_rm_is_reg_direct
                   && ((modrm[2:0] == 3'b101 && modrm[7:6] == 2'b00)
                       || (modrm[7:6] == 2'b01 || modrm[7:6] == 2'b10)))
                || opnd_form_1hot[`OPND_ENC_DISP];
endmodule
