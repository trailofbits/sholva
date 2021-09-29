`include "codegen/commands.gen.v"
`include "defines.v"

module decode_opnd_signals(
  input [87:0] unescaped_instr,
  input [3:0] opnd_form,
  input prefix_address_16bit,
  input prefix_operand_16bit,
  input imm_1byte,
  input source_is_sext,

  output [3:0] imm_disp_len,
  output has_imm,
  output has_modrm,
  output has_sib,
  output has_disp,
  output is_disp8,
  output is_disp32,

  output [7:0] modrm,
  output [7:0] sib,
  output [31:0] disp,
  output [31:0] imm,

  output modrm_rm_is_reg_direct,

  output opnd0_modrm_rm,
  output opnd0_modrm_reg,
  output opnd0_disp,
  output opnd1_modrm_rm,
  output opnd1_modrm_reg,
  output opnd1_disp
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
assign modrm_rm_is_reg_direct = has_modrm && modrm[7:6] == 2'b11;

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
                || opnd_form_1hot[`OPND_ENC_DISP8]
                || opnd_form_1hot[`OPND_ENC_DISP32];

// Whether our displacement is a single byte.
assign is_disp8 = has_disp
                  && (opnd_form_1hot[`OPND_ENC_DISP8]
                      || (has_modrm && modrm[7:6] == 2'b01));

// Whether our displacement is 32 bits.
assign is_disp32 = has_disp
                   && (opnd_form_1hot[`OPND_ENC_DISP32]
                       || (has_modrm
                           && ((modrm[2:0] == 3'b101 && modrm[7:6] == 2'b00)
                               || (modrm[7:6] == 2'b10))));

// Actually grab our displacement bytes, with the region depending
// on whether we have a ModR/M and/or SIB byte preceeding.
// Sign-extend as necessary.
// TODO(ww): This could definitely be optimized.
assign disp = has_disp ?
              (has_modrm ?
                (has_sib ?
                  (is_disp8 ? (source_is_sext ? sext8_32(unescaped_instr[31:24]) : zext8_32(unescaped_instr[31:24])) : (unescaped_instr[55:24]))    // ModR/M and SIB
                  : (is_disp8 ? (source_is_sext ? sext8_32(unescaped_instr[23:16]) : zext8_32(unescaped_instr[23:16])) : (unescaped_instr[47:16]))) // ModR/M only, no SIB
                : (is_disp8 ? (source_is_sext ? sext8_32(unescaped_instr[15:8]) : zext8_32(unescaped_instr[15:8])) : (unescaped_instr[39:8])))     // No ModR/M or SIB
              : 32'd0;                                                                          // No disp whatsoever

// Determine which of our operands actually uses the disp bytes.
// Instructions that are disp-only (OPND_ENC_DISP8/OPND_ENC_DISP32) always
// use it for operand#0; for all others it depends on which operand is using
// the relevant parts of the ModR/M.
// TODO(ww): Not 100% sure these are correct -- ModR/M includes a disp32-only
// encoding that *seems* to map to the operand that takes the R/M field, but
// I'm not positive about that.
assign opnd0_disp = opnd_form_1hot[`OPND_ENC_DISP8]
                    || opnd_form_1hot[`OPND_ENC_DISP32]
                    || (has_disp && opnd0_modrm_rm);

assign opnd1_disp = has_disp && opnd1_modrm_rm;

// Finally, immediate handling.
// Immediates are 32, 16, or 8 bits. 8-bit immediates have special opcodes,
// which we have signaled for us by the imm_1byte wire. We distinguish the
// 16-bit case from the 32-bit case with the prefix_operand_16bit wire.

wire is_imm8 = has_imm && imm_1byte;
wire is_imm16 = has_imm && prefix_operand_16bit;
wire is_imm32 = has_imm && (~is_imm8 && ~is_imm16);

`include "codegen/imm.gen.v"

wire [3:0] imm_len = is_imm32 ? 4 :
                     is_imm16 ? 2 :
                     is_imm8  ? 1 : 0;

wire [3:0] disp_len = is_disp32 ? 4 :
                      is_disp8  ? 1 : 0;

assign imm_disp_len = imm_len + disp_len;

endmodule
