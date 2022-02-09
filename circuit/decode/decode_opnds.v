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

  input [6:0] opc,
  input [3:0] opnd_form,
  input imm_1byte,
  input reg_1byte,
  input prefix_operand_16bit,
  input prefix_address_16bit,

  input opnd0_is_read,
  input opnd0_is_write,

  input opnd1_is_one,
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
wire [127:0] opc_1hot = one_hot128(opc);


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
// is, for both reads and writes.

// NOTE(ww): From this point on, the "operands" of an instruction become
// somewhat fuzzy and flexible: they goal from being the "encoded" operands
// as they more-or-less appear in the instruction text to a collection of
// "read" operands (whose source can be registers, immediates, etc.) and "write"
// selectors (whose destinations can be registers or memory addresses).

///
/// REGISTER OPERANDS
///

// Is operand#0 a register, and do we read and/or write to it?
wire opnd0_is_reg = opnd_form_1hot[`OPND_ENC_REG]              ||
                    opnd_form_1hot[`OPND_ENC_EAX_IMM]          ||
                    opnd_form_1hot[`OPND_ENC_EAX_REG]          ||
                    opnd_form_1hot[`OPND_ENC_REG_IMM]          ||
                    (opnd0_modrm_rm && modrm_rm_is_reg_direct) ||
                    opnd0_modrm_reg;

wire opnd0_r_is_reg = opnd0_is_read && opnd0_is_reg;
wire opnd0_w_is_reg = opnd0_is_write && opnd0_is_reg;


// For operand#0, our register selector can come from four sources:
// TODO(ww): That's wrong. We also need to handle implicit register selector operands here,
// like some of the "zero-operand" encodings. Needs thought.
// * The lower three bits of the opcode itself (OPND_ENC_REG, OPND_ENC_REG_IMM)
// * The r/m selector of ModR/M (OPND_ENC_MODREGRM_RM_*) when in register direct mode (mod=0b11)
// * The reg selector of ModR/M (OPND_ENC_MODREGRM_REG_*)
// * An implicit EAX register (OPND_ENC_EAX_*)
wire [2:0] opnd0_rw_regsel = (opnd_form_1hot[`OPND_ENC_REG] || opnd_form_1hot[`OPND_ENC_REG_IMM]) ?
                                unescaped_instr[2:0] :
                             (opnd0_modrm_rm && modrm_rm_is_reg_direct) ?
                                modrm[2:0] :
                             (opnd0_modrm_reg) ?
                                modrm[5:3] :
                             (opnd_form_1hot[`OPND_ENC_EAX_IMM] || opnd_form_1hot[`OPND_ENC_EAX_REG]) ?
                                `REG_EAX : 3'b0;

wire cmd_is_loop = opc_1hot[`CMD_LOOP] | opc_1hot[`CMD_LOOPE] | opc_1hot[`CMD_LOOPNE];

// Is operand#1 a register, and do we read and/or write to it?
// LOOPcc is a special case here: it's disp8-only as an encoding, but
// we need to synthesize an operand for ECX (the counter we'll read and decrement).
wire opnd1_is_reg = opnd_form_1hot[`OPND_ENC_EAX_REG]          |
                    (opnd1_modrm_rm && modrm_rm_is_reg_direct) |
                    opnd1_modrm_reg                            |
                    cmd_is_loop                                ;

wire opnd1_r_is_reg = (opnd1_is_read && opnd1_is_reg) | cmd_is_loop;
wire opnd1_w_is_reg = (opnd1_is_write && opnd1_is_reg) | cmd_is_loop;


// For operand#1, our register selector can come from N sources:
// * The r/m selector of ModR/M (OPND_ENC_MODREGRM_REG_RM*) when in register direct mode (mod=0b11)
// * The reg selector of ModR/M (OPND_ENC_MODREGRM_RM_REG*)
// * The lower three bits of the opcode itself (OPND_ENC_*_REG)
// * Implicit ECX, if we're performing a LOOPcc.
// * TODO(ww): Implicit opnd1 register sources? Presumably some of the string operations?
wire [2:0] opnd1_rw_regsel = opnd1_modrm_rm && modrm_rm_is_reg_direct ? modrm[2:0]           :
                             opnd1_modrm_reg                          ? modrm[5:3]           :
                             opnd_form_1hot[`OPND_ENC_EAX_REG]        ? unescaped_instr[2:0] :
                             cmd_is_loop                              ? `REG_ECX             :
                                                                        3'b0                 ;

// TODO(ww): operand#2 regsel. This can only ever be CL.

// Finally, actually grab some values using our operand selectors.
wire [31:0] opnd0_r_regval;
mux8_32 mux8_32_opnd0_reg(
  .sel(opnd0_rw_regsel),
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
  .sel(opnd1_rw_regsel),
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
wire opnd0_is_mem = opnd0_r_is_mem_modrm |
                    opc_1hot[`CMD_MOVS]  |
                    opc_1hot[`CMD_CMPS]  |
                    opc_1hot[`CMD_SCAS]  |
                    opc_1hot[`CMD_POP]   |
                    opc_1hot[`CMD_LEAVE] ;

wire opnd0_r_is_mem = opnd0_is_read && opnd0_is_mem;
wire opnd0_w_is_mem = opnd0_is_write && opnd0_is_mem;

// Is operand#1 a memory address?
// TODO(ww): Missing anything?
wire opnd1_r_is_mem_modrm = (opnd1_modrm_rm && ~modrm_rm_is_reg_direct);
wire opnd1_is_mem = opnd1_r_is_mem_modrm |
                    opc_1hot[`CMD_MOVS]  |
                    opc_1hot[`CMD_CMPS]  |
                    opc_1hot[`CMD_STOS]  |
                    opc_1hot[`CMD_LODS]  ;

wire opnd1_r_is_mem = opnd1_is_read && opnd1_is_mem;
wire opnd1_w_is_mem = opnd1_is_write && opnd1_is_mem;

// To actually calculate our effective addresses for operand#0 and operand#1,
// we need to get the (scale, index, base, displacement) for each, or
// appropriate dummy values.
// Selecting the base register selector goes as follows:
// * If we have a SIB byte, it's the SIB base selector.
// * If we have a bare ModR/M byte with ModR/M.mod != 0b11, it's the ModR/M.rm
//   selector.
// * If we're doing a POP or a RET, then operand#0 is ESP.
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
  opc_1hot[`CMD_MOVS] | opc_1hot[`CMD_STOS] | opc_1hot[`CMD_SCAS] ? `REG_EDI :
  opc_1hot[`CMD_CMPS]                                             ? `REG_ESI :
  opc_1hot[`CMD_POP] | opc_1hot[`CMD_RET] | opc_1hot[`CMD_LEAVE]  ? `REG_ESP :
  opndX_r_mem_base_regsel                                                    ;

wire [2:0] opnd1_r_mem_base_regsel =
  opc_1hot[`CMD_MOVS] | opc_1hot[`CMD_LODS] ? `REG_ESI :
  opc_1hot[`CMD_CMPS]                       ? `REG_EDI :
  opndX_r_mem_base_regsel                              ;

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

// NOTE(ww): Without a SIB byte, we never have an index register (in 32-bit mode, which
// is all we care about). With a SIB byte, we have an index register only when
// the SIB byte explicitly says so (per `sib_no_index`).
wire no_index = !has_sib || sib_no_index;

wire [31:0] opnd0_r_mem_effective_index = no_index ? 32'b0 : opnd0_r_mem_selected_index;
wire [31:0] opnd1_r_mem_effective_index = no_index ? 32'b0 : opnd1_r_mem_selected_index;

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

wire opnd0_is_disp = opnd_form_1hot[`OPND_ENC_DISP8] ||
                     opnd_form_1hot[`OPND_ENC_DISP32];

wire [31:0] opnd0_r_dispval = disp;

///
/// END DISPLACEMENT OPERANDS
///

///
/// BEGIN PHONY OPERANDS
///

// In addition to all of the "real" operand types above, we also have a couple
// of "phony" operands that we produce to simplify other parts of the circuit.
// Some are already signaled for us: for example, `opndN_is_one` tells us that
// an operand has an implicit value of 1. Others need to be checked below.

// For CALL, PUSH, and POP instructions, we introduce two phony operands:
// opnd1 becomes ESP, and opnd2 becomes the immediate 4.
// We do this so that we can re-use the ALU for stack adjustment during
// each execution.
// POP and RET have a third phony: we reuse opnd0_r to store the popped value
// even though the "real" operand#0 is a write-only operand (the stack pop
// destination).
//
// LEAVE is nearly identical to POP, but opnd1 is EBP instead (since LEAVE
// is defined as `ESP := EBP; POP EBP`). `opnd2` is still the stack adjustment
// immediate, and `opnd0_r` is still the popped value.
//
// Similarly, we create a single phony operand for the LOOPcc family:
// operand#2 becomes 1, i.e. the decrement for the counter (ECX).
// This assumes that operand#1 is ECX, which is special-case in register operand
// handling above.

wire stack_adjust_phonies = opc_1hot[`CMD_CALLr] |
                            opc_1hot[`CMD_CALLi] |
                            opc_1hot[`CMD_PUSH]  |
                            opc_1hot[`CMD_POP]   |
                            opc_1hot[`CMD_RET]   |
                            opc_1hot[`CMD_LEAVE];

wire ecx_adjust_phones = cmd_is_loop;

wire pop_phony = opc_1hot[`CMD_POP] | opc_1hot[`CMD_RET] | opc_1hot[`CMD_LEAVE];

wire opnd0_r_is_phony = pop_phony;

wire opnd1_r_is_phony = opnd1_is_one | stack_adjust_phonies;

wire opnd2_is_phony = stack_adjust_phonies | cmd_is_loop;

wire [31:0] opnd0_r_phonyval = pop_phony ? opnd0_r_memval : 32'b0;

wire [31:0] opnd1_r_phonyval = opnd1_is_one         ? 32'b1 :
                               opc_1hot[`CMD_LEAVE] ? ebp   :
                               stack_adjust_phonies ? esp   : 32'b0;

wire [31:0] opnd2_r_phonyval = stack_adjust_phonies ? 32'd4 :
                               ecx_adjust_phones    ? 32'd1 : 32'b0;

///
/// END PHONY OPERANDS
///

///
/// END OPERAND EXTRACTION
///

// Operand multiplexors.

assign opnd0_r = opnd0_r_is_phony ? opnd0_r_phonyval :
                 opnd0_r_is_reg   ? opnd0_r_regval   :
                 opnd0_r_is_mem   ? opnd0_r_memval   :
                 opnd0_is_imm     ? opnd0_r_immval   :
                 opnd0_is_disp    ? opnd0_r_dispval  : 32'b0;

assign opnd1_r = opnd1_r_is_phony ? opnd1_r_phonyval :
                 opnd1_r_is_reg   ? opnd1_r_regval   :
                 opnd1_r_is_mem   ? opnd1_r_memval   :
                 opnd1_is_imm     ? opnd1_r_immval   : 32'b0;

assign opnd2_r = opnd2_is_phony ? opnd2_r_phonyval : 32'b0;

// TODO(ww): Is this the right place for this? Maybe we should do it
// further on in instruction decoding, when looking at `opc` more closely.

// Figure out the *kind* of destination(s) for our operation.
// In most cases it's the same as the source of the operand.
// The main edge case is "phony" operands, which are synthesized and don't
// have explicit read/write semantics. These need to be fixed up manually.

// TODO(ww): Clean this up. In particular, the decision of which
// destination operand to use for phony operands is subjective and hard to follow:
// I decided to use `dest1` below since `opnd1` is a phony-sourced `ESP`,
// but that makes routing the adjusted `ESP` from the ALU more tedious elsewhere
// (since the ALU otherwise gets its result routed to `opnd0` by default).

// This is particularly confusing: we need to reroute dest0 to a memory selector
// if and only if we're POPing *and* the encoding form indicates that our POP
// destination is a memory destination instead of a register destination.
// We can't put this logic in `pop_phony` itself, since `pop_phony` also
// controls whether we re-reroute the value read from the stack (which is
// invariant across destination selectors).
wire dest0_is_phony_mem = pop_phony && (opnd_form_1hot[`OPND_ENC_MODREGRM_RM_IMM] && !modrm_rm_is_reg_direct);

// For LEAVE, we use the dest0 kind and selector for POPing into EBP.
wire dest0_is_phony_ebp = opc_1hot[`CMD_LEAVE];

wire dest1_is_phony_esp = stack_adjust_phonies;
wire dest1_is_phony_ecx = ecx_adjust_phones;

// NOTE(ww): Technically dest0_is_phony_mem is redundant here since
// the POP case is also covered by opnd0_w_is_mem.
assign dest0_kind = dest0_is_phony_mem ? `OPND_DEST_MEM_1HOT :
                    dest0_is_phony_ebp ? `OPND_DEST_REG_1HOT :
                    !opnd0_is_write    ? `OPND_DEST_NONE     :
                    opnd0_w_is_reg     ? `OPND_DEST_REG_1HOT :
                    opnd0_w_is_mem     ? `OPND_DEST_MEM_1HOT :
                                         `OPND_DEST_NONE     ;

// Special cases, per above:
// * ESP if we're doing a CALL or other stack-adjusting instruction
// * ECX if we're doing a LOOPcc
assign dest1_kind = dest1_is_phony_esp ? `OPND_DEST_REG_1HOT :
                    dest1_is_phony_ecx ? `OPND_DEST_REG_1HOT :
                    !opnd1_is_write    ? `OPND_DEST_NONE     :
                    opnd1_w_is_reg     ? `OPND_DEST_REG_1HOT :
                    opnd1_w_is_mem     ? `OPND_DEST_MEM_1HOT :
                                         `OPND_DEST_NONE     ;

// Special case for POP: when dest0 indicates a memory selector, it's normally
// opnd0_r_mem_addr (a misnomer, since it's actually a write). However, when it's
// a POP, we used opnd1_r_mem_addr instead, since the first AGU is occupied.
assign dest0_sel = dest0_kind == `OPND_DEST_REG_1HOT                                              ?
                      (dest0_is_phony_ebp ? long_regsel(`REG_EBP) : long_regsel(opnd0_rw_regsel)) :
                   dest0_kind == `OPND_DEST_MEM_1HOT                                              ?
                      (pop_phony ? opnd1_r_mem_addr : opnd0_r_mem_addr)                           :
                   32'b0;

// Same ESP special case for CALL.
assign dest1_sel = dest1_kind == `OPND_DEST_REG_1HOT ?
  (dest1_is_phony_esp ? long_regsel(`REG_ESP) : long_regsel(opnd1_rw_regsel)) :
  32'b0;

assign instr_body_len = (has_modrm ? 4'd1 : 4'd0) + (has_sib ? 4'd1 : 4'd0) + imm_disp_len;

endmodule
