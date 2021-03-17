`include "defines.v"

module decode_opnds(
  input [71:0] unescaped_instr,
  input [31:0] eax, ebx, ecx, edx, esi, edi, esp, ebp,
  input [5:0] opc,
  input [3:0] opnd_form,
  input imm_1byte,
  input reg_1byte,
  input prefix_operand_16bit,
  input prefix_address_16bit,

  output disp_1byte,
  output [1:0] opnd_count,
  // TODO(ww): Output wires for opnd0's write destination
  // (whether a memory address or a register selector)
  output [31:0] opnd0_r,
  output [31:0] opnd1_r,
  output [31:0] opnd2_r
);

// Whether we have any immediate byte(s).
wire has_imm = opnd_form == `OPND_ENC_IMM ||
               opnd_form == `OPND_ENC_MODREGRM_RM_IMM ||
               opnd_form == `OPND_ENC_REG_IMM ||
               opnd_form == `OPND_ENC_EAX_IMM ||
               opnd_form == `OPND_ENC_MODREGRM_REG_RM_IMM ||
               opnd_form == `OPND_ENC_MODREGRM_RM_REG_IMM;


// ModR/M encodings where R/M is operand#0 (i.e. op.d=0)
wire opnd0_modrm_rm = opnd_form == `OPND_ENC_MODREGRM_RM ||
                      opnd_form == `OPND_ENC_MODREGRM_RM_IMM ||
                      opnd_form == `OPND_ENC_MODREGRM_RM_REG ||
                      opnd_form == `OPND_ENC_MODREGRM_RM_REG_IMM ||
                      opnd_form == `OPND_ENC_MODREGRM_RM_REG_CL;

// ModR/M encodings where REG is operand#0 (i.e. op.d=1)
wire opnd0_modrm_reg = opnd_form == `OPND_ENC_MODREGRM_REG_RM ||
                       opnd_form == `OPND_ENC_MODREGRM_REG_RM_IMM;

// ModR/M encodings where R/M is operand#1.
wire opnd1_modrm_rm = opnd0_modrm_reg;

// ModR/M encodings where REG is operand#1.
wire opnd1_modrm_reg = opnd_form == `OPND_ENC_MODREGRM_RM_REG ||
                       opnd_form == `OPND_ENC_MODREGRM_RM_REG_IMM ||
                       opnd_form == `OPND_ENC_MODREGRM_RM_REG_CL;

// Whether we have a ModR/M byte supplying one or more operands.
wire has_modrm = opnd0_modrm_rm || opnd0_modrm_reg;

// The actual ModR/M byte, if `has_modrm`.
wire [7:0] maybe_modrm = unescaped_instr[15:8];
wire modrm_rm_is_regsel = maybe_modrm[7:6] == 2'b11;

// Intel SDM Vol. 2A Table 2-1/2-2/2-3: the SIB byte is only present when all
// of the following conditions hold:
//  * The ModR/M byte is present;
//  * We are not performing a 16-bit addressing operation;
//  * ModR/M.mod != 0b11 and ModR/M.rm == 0b100
wire has_sib = has_modrm
               && ~prefix_address_16bit
               && maybe_modrm[7:6] != 2'b11
               && maybe_modrm[2:0] == 3'b100;

// The actual SIB byte, if `has_sib`.
wire [7:0] maybe_sib = unescaped_instr[23:16];

// Implicit

// The annoying and hard to visualize bit: we don't have any real control flow,
// so we have to compute each operand's prospective value as if it was an
// immediate, displacement, register, and memory operand. Then, we get to
// select from those unconditional computations based on which one it actually
// is.
// TODO(ww): Actually support more than just register-register.
// TODO(ww): Assign opndN_r_form as OPND_IMM, OPND_MEM, etc.

// For operand#0, our register selector can come from four sources:
// TODO(ww): That's wrong. We also need to handle implicit register selector operands here,
// like some of the "zero-operand" encodings. Needs thought.
// * The lower three bits of the opcode itself (OPND_ENC_REG, OPND_ENC_REG_IMM)
// * The r/m selector of ModR/M (OPND_ENC_MODREGRM_RM_*) when in register direct mode (mod=0b11)
// * The reg selector of ModR/M (OPND_ENC_MODREGRM_REG_*)
// * An implicit EAX register (OPND_ENC_EAX_*)
wire [2:0] opnd0_r_regsel = (opnd_form == `OPND_ENC_REG || opnd_form == `OPND_ENC_REG_IMM) ?
                                unescaped_instr[2:0] :
                            (opnd0_modrm_rm && modrm_rm_is_regsel) ?
                                maybe_modrm[2:0] :
                            (opnd0_modrm_reg) ?
                                maybe_modrm[5:3] :
                            (opnd_form == `OPND_ENC_EAX_IMM || opnd_form == `OPND_ENC_EAX_REG) ?
                                `REG_EAX : 3'bxxx;

// For operand#1, our register selector can come from N sources:
// * The r/m selector of ModR/M (OPND_ENC_MODREGRM_REG_RM*) when in register direct mode (mod=0b11)
// * The reg selector of ModR/M (OPND_ENC_MODREGRM_RM_REG*)
// * The lower three bits of the opcode itself (OPND_ENC_*_REG)
// * TODO(ww): Implicit opnd1 register sources? Presumably some of the string operations?
wire [2:0] opnd1_r_regsel = (opnd1_modrm_rm && modrm_rm_is_regsel) ?
                                maybe_modrm[2:0] :
                            (opnd1_modrm_reg) ?
                                maybe_modrm[5:3] :
                            (opnd_form == `OPND_ENC_EAX_REG) ?
                                unescaped_instr[2:0] : 3'bxxx;

// TODO(ww): operand#2 regsel. This can only ever be CL.

// Finally, actually grab some values using our operand selectors.
wire [31:0] opnd0_r_regval;
mux8_32 mux8_32_opnd0(
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
mux8_32 mux8_32_opnd1(
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

// TODO(ww): This eventually needs to be a multiplexor against
// opndN_r_regval, opndN_r_memval, opndN_r_immval, etc.
assign opnd0_r = opnd0_r_regval;
assign opnd1_r = opnd1_r_regval;


// TODO(ww): Temporary assignments, to make testing easier.
assign disp_1byte = 1'd0;
assign opnd2_r = 32'd0;
assign opnd_count = 2'd0;

endmodule
