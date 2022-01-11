`include "defines.v"
`include "codegen/commands.gen.v"

module execute(
  input [6:0] opc,
  input [31:0] eflags,
  input ecx_is_zero,
  input [31:0] eip,
  input [3:0] instr_len,
  input [31:0] opnd0_r,
  input [31:0] opnd1_r,
  input [31:0] opnd2_r,
  // TODO(ww): Input signal for 8/16/32 bit opnds

  output [31:0] o_eflags,
  output [31:0] next_eip,
  output [31:0] opnd0_w,
  output [31:0] opnd1_w
);

`include "funcs.v"

wire [127:0] opc_1hot = one_hot128(opc);

///
/// BEGIN ALU
///

// The ALU is responsible for the following instructions:
//
// ADD, ADC, INC -> ALU_OP_ADD
// SUB, SBB, DEC -> ALU_OP_SUB
// AND, TEST     -> ALU_OP_AND
// OR            -> ALU_OP_OR
// XOR, NOT      -> ALU_OP_XOR
// MUL, IMUL     -> ALU_OP_MUL
// DIV, IDIV     -> ALU_OP_DIV

// TODO(ww): The ALU needs to support each of the following:
// BSF, BSR, BT, BTC, BTR, BTS
// Jcc, JCXZ, SETcc (?), LOOPcc, PUSH(A), POP(A)

// ALU control signals.

// Core operation signals.
wire alu_op_add = opc_1hot[`CMD_ADD] |
                  opc_1hot[`CMD_ADC] |
                  opc_1hot[`CMD_INC] |
                  opc_1hot[`CMD_POP] ;

wire alu_op_sub = opc_1hot[`CMD_SUB]   |
                  opc_1hot[`CMD_SBB]   |
                  opc_1hot[`CMD_DEC]   |
                  opc_1hot[`CMD_CMP]   |
                  opc_1hot[`CMD_CMPS]  |
                  opc_1hot[`CMD_CALLr] |
                  opc_1hot[`CMD_CALLi] |
                  opc_1hot[`CMD_PUSH]  ;

wire alu_op_and = opc_1hot[`CMD_AND] |
                  opc_1hot[`CMD_TEST];

wire alu_op_or = opc_1hot[`CMD_OR];

wire alu_op_xor = opc_1hot[`CMD_XOR] |
                  opc_1hot[`CMD_NOT] ;

wire alu_op_mul = opc_1hot[`CMD_MUL] |
                  opc_1hot[`CMD_IMUL];

wire alu_op_div = opc_1hot[`CMD_DIV] |
                  opc_1hot[`CMD_IDIV];

// TODO(ww): SHLD, SHRD.

wire alu_op_shl = opc_1hot[`CMD_SHL];

wire alu_op_shr = opc_1hot[`CMD_SHR];

wire alu_op_rol = opc_1hot[`CMD_ROL];

wire alu_op_ror = opc_1hot[`CMD_ROR];

// Are we performing an ALU operation?
wire exe_is_alu = alu_op_add |
                  alu_op_sub |
                  alu_op_and |
                  alu_op_or  |
                  alu_op_xor |
                  alu_op_mul |
                  alu_op_div |
                  alu_op_shl |
                  alu_op_shr |
                  alu_op_rol |
                  alu_op_ror ;

// Auxiliary signals.
wire alu_src_inv = opc_1hot[`CMD_SUB] |
                   opc_1hot[`CMD_SBB] |
                   opc_1hot[`CMD_DEC];

wire alu_use_carry = opc_1hot[`CMD_ADC] |
                     opc_1hot[`CMD_SBB];

wire alu_src_inc = opc_1hot[`CMD_SUB] |
                   opc_1hot[`CMD_SBB];

// These commands do not use the ALU's 32-bit result.
wire alu_no_wr = opc_1hot[`CMD_CMP] |
                 opc_1hot[`CMD_CMPS] |
                 opc_1hot[`CMD_TEST];

// These commands do not use the ALU to modify the EFLAGS.
wire alu_no_flags = opc_1hot[`CMD_NOT]   |
                    opc_1hot[`CMD_CALLr] |
                    opc_1hot[`CMD_CALLi] |
                    opc_1hot[`CMD_PUSH]  |
                    opc_1hot[`CMD_POP]   ;

// TODO(ww): Flesh these out more:
// https://sandpile.org/x86/flags.htm
wire alu_clear_cf = opc_1hot[`CMD_AND] |
                    opc_1hot[`CMD_OR] |
                    opc_1hot[`CMD_XOR] |
                    opc_1hot[`CMD_TEST];

wire alu_clear_of = opc_1hot[`CMD_AND] |
                    opc_1hot[`CMD_OR] |
                    opc_1hot[`CMD_XOR] |
                    opc_1hot[`CMD_TEST];

wire [17:0] alu_cntl = {
                          alu_op_ror,    // 17
                          alu_op_rol,    // 16
                          alu_op_shr,    // 15
                          alu_op_shl,    // 14
                          alu_clear_of,  // 13
                          alu_clear_cf,  // 12
                          alu_no_flags,  // 11
                          alu_op_sub,    // 10
                          alu_no_wr,     // 9
                          alu_src_inc,   // 8
                          alu_use_carry, // 7
                          alu_op_div,    // 6
                          alu_op_mul,    // 5
                          alu_op_xor,    // 4
                          alu_op_or,     // 3
                          alu_op_and,    // 2
                          alu_op_add,    // 1
                          alu_src_inv    // 0
                       };

// Input arithmetic flag states.
wire [6:0] status_in = {
                          eflags[`EFLAGS_DF], // 6
                          eflags[`EFLAGS_AF], // 5
                          eflags[`EFLAGS_CF], // 4
                          eflags[`EFLAGS_PF], // 3
                          eflags[`EFLAGS_ZF], // 2
                          eflags[`EFLAGS_SF], // 1
                          eflags[`EFLAGS_OF]  // 0
                       };

wire [6:0] alu_status_out;
wire [31:0] alu_result;

wire alu_op_is_stack_adjust = opc_1hot[`CMD_CALLr] |
                              opc_1hot[`CMD_CALLi] |
                              opc_1hot[`CMD_PUSH]  |
                              opc_1hot[`CMD_POP]   ;

// When we're using the ALU as part of a CALL instruction, we need to do some
// operand re-routing. Specifically, we need to use opnd#1 and opnd#2 as
// opnd#0 and opnd#1 respectively.
wire [31:0] alu_opnd0_r = alu_op_is_stack_adjust ? opnd1_r : opnd0_r;
wire [31:0] alu_opnd1_r = alu_op_is_stack_adjust ? opnd2_r : opnd1_r;

alu alu_x(
  .cntl(alu_cntl),
  .status_in(status_in),
  .opnd0_r(alu_opnd0_r),
  .opnd1_r(alu_opnd1_r),

  .status_out(alu_status_out),
  .result(alu_result)
);

// Mash the ALU states back into our prospective EFLAGS.
wire [31:0] alu_eflags = {
                            eflags[31:12],
                            alu_status_out[`STAT_OF],
                            eflags[`EFLAGS_DF],
                            eflags[`EFLAGS_IF],
                            eflags[`EFLAGS_TF],
                            alu_status_out[`STAT_SF],
                            alu_status_out[`STAT_ZF],
                            eflags[5], // reserved
                            alu_status_out[`STAT_AF],
                            eflags[3], // reserved
                            alu_status_out[`STAT_PF],
                            eflags[1], // reserved
                            alu_status_out[`STAT_CF]
                         };

///
/// END ALU
///

///
/// BEGIN MOVE UNIT
///

// The move unit is responsible for the following instructions:
//
// MOV, MOVSZ, MOVZX, LEA, MOVS, XCHG -> MU_OP_MOV


// Move unit control signals.

wire mu_sext = opc_1hot[`CMD_MOVSX];
wire mu_zext = opc_1hot[`CMD_MOVZX];

// Are we performing a move operation?
// We treat LEAs as moves: every LEA is essentially an address calculation,
// moved into a register.
wire exe_is_mu = opc_1hot[`CMD_MOV]   |
                 opc_1hot[`CMD_LEA]   |
                 opc_1hot[`CMD_MOVS]  |
                 opc_1hot[`CMD_MOVSX] |
                 opc_1hot[`CMD_MOVZX] |
                 opc_1hot[`CMD_XCHG];

// XCHG is the only swap operation, so far.
wire mu_cntl = exe_is_mu && !opc_1hot[`CMD_XCHG];

wire [31:0] mu_opnd0_w;
wire [31:0] mu_opnd1_w;

move move_x(
  .cntl(mu_cntl),
  .opnd0_r(opnd0_r),
  .opnd1_r(opnd1_r),

  .opnd0_w(mu_opnd0_w),
  .opnd1_w(mu_opnd1_w)
);

///
/// END MOVE UNIT
///

///
/// BEGIN META UNIT
///

// The "meta" unit is responsible for various instructions that manipulate
// EFLAGS or other non-GPR/memory architectural state directly.

wire exe_is_meta = opc_1hot[`CMD_STC]  |
                   opc_1hot[`CMD_STD]  |
                   opc_1hot[`CMD_CLC]  |
                   opc_1hot[`CMD_CLD]  |
                   opc_1hot[`CMD_LAHF] |
                   opc_1hot[`CMD_SAHF];

wire ah_wr;
wire [31:0] meta_result;
wire [6:0] meta_status_out;


// TODO(ww): Need to actually wire up opnd0_r to EAX to LAHF/SAHF.
meta meta_x(
  .opc(opc),
  .opnd_in(opnd0_r),
  .status_in(status_in),

  .ah_wr(ah_wr),
  .result(meta_result),
  .status_out(meta_status_out)
);

// Mash any flag changes from the meta unit back into our prospective EFLAGS.
wire [31:0] meta_eflags = {
                            eflags[31:12],
                            meta_status_out[`STAT_OF], // not actually modified
                            meta_status_out[`STAT_DF],
                            eflags[`EFLAGS_IF],
                            eflags[`EFLAGS_TF],
                            meta_status_out[`STAT_SF],
                            meta_status_out[`STAT_ZF],
                            eflags[5], // reserved
                            meta_status_out[`STAT_AF],
                            eflags[3], // reserved
                            meta_status_out[`STAT_PF],
                            eflags[1], // reserved
                            meta_status_out[`STAT_CF]
                          };

///
/// END META UNIT
///

///
/// BEGIN CFU
///

// Every step changes the EIP in *some* way, so the CFU always runs.

cfu cfu_x(
  .opc(opc),
  .eflags(eflags),
  .ecx_is_zero(ecx_is_zero),
  .eip(eip),
  .instr_len(instr_len),
  .address(opnd0_r),

  .next_eip(next_eip)
);

///
/// END CFU
///

// The CFU never *directly* affects the write operands. But it can *influence*
// them, e.g. if the instruction is a CALL, by operating in tandem with the ALU.
// When that happens, `exe_is_alu` is high and we apply the result correctly.
// See the HACK note below.

assign opnd0_w = exe_is_alu ? alu_result  :
                 exe_is_mu  ? mu_opnd0_w  :
                              opnd0_r     ; // No operation? Use the input.

// HACK(ww): Route alu_result into opnd1_w if and only if we're executing the
// ALU in the context of a stack adjustment operation. We do this
// because the ALU performs the stack adjustment for us and other parts of the
// circuit expect to do the ESP writeback via opnd#1 (since opnd0_r is used
// for the EIP adjustment or other "primary" instruction semantic).
// See the construction of dest1_kind and dest1_sel during operand decoding for
// more context.
assign opnd1_w = exe_is_mu                            ? mu_opnd1_w :
                 exe_is_alu && alu_op_is_stack_adjust ? alu_result :
                 opnd1_r                                           ; // TODO(ww): Others.

// Update our flag state based on whichever execution unit actually took effect.
// Only the ALU and meta units can modify flag state, so we don't need to check
// for the move unit here.
assign o_eflags = exe_is_alu  ? alu_eflags  :
                  exe_is_meta ? meta_eflags :
                                eflags      ;

endmodule
