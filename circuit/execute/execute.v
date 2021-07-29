`include "defines.v"
`include "codegen/commands.gen.v"

module execute(
  input [5:0] opc,
  input [31:0] eflags,
  input [31:0] opnd0_r,
  input [31:0] opnd1_r,
  // TODO(ww): Input signal for 8/16/32 bit opnds

  output [31:0] o_eflags,
  output [31:0] opnd0_w
  // TODO: opndN_w for outputs
  // output [31:0] opnd1_w,
);

`include "funcs.v"

wire [63:0] opc_1hot = one_hot64(opc);

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
                  opc_1hot[`CMD_INC];

wire alu_op_sub = opc_1hot[`CMD_SUB] |
                  opc_1hot[`CMD_SBB] |
                  opc_1hot[`CMD_DEC] |
                  opc_1hot[`CMD_CMP] |
                  opc_1hot[`CMD_CMPS];

wire alu_op_and = opc_1hot[`CMD_AND] |
                  opc_1hot[`CMD_TEST];

wire alu_op_or = opc_1hot[`CMD_OR];

wire alu_op_xor = opc_1hot[`CMD_XOR] |
                  opc_1hot[`CMD_NOT];

wire alu_op_mul = opc_1hot[`CMD_MUL] |
                  opc_1hot[`CMD_IMUL];

wire alu_op_div = opc_1hot[`CMD_DIV] |
                  opc_1hot[`CMD_IDIV];

// Are we performing an ALU operation?
wire exe_is_alu = alu_op_add |
                  alu_op_sub |
                  alu_op_and |
                  alu_op_or  |
                  alu_op_xor |
                  alu_op_mul |
                  alu_op_div;

// Auxiliary signals.
wire alu_src_inv = opc_1hot[`CMD_SUB] |
                   opc_1hot[`CMD_SBB] |
                   opc_1hot[`CMD_DEC];

wire alu_use_carry = opc_1hot[`CMD_ADC] |
                     opc_1hot[`CMD_SBB];

wire alu_src_inc = opc_1hot[`CMD_SUB] |
                   opc_1hot[`CMD_SBB];

wire alu_no_wr = opc_1hot[`CMD_CMP] |
                 opc_1hot[`CMD_CMPS] |
                 opc_1hot[`CMD_TEST];

wire alu_no_flags = opc_1hot[`CMD_NOT];

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

wire [13:0] alu_cntl = {
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
                          eflags[`EFLAGS_DF],
                          eflags[`EFLAGS_AF],
                          eflags[`EFLAGS_CF],
                          eflags[`EFLAGS_PF],
                          eflags[`EFLAGS_ZF],
                          eflags[`EFLAGS_SF],
                          eflags[`EFLAGS_OF]
                       };

wire [6:0] alu_status_out;
wire [31:0] alu_result;

alu alu_x(
  .cntl(alu_cntl),
  .status_in(status_in),
  .opnd0_r(opnd0_r),
  .opnd1_r(opnd1_r),

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

wire [31:0] mu_result = 32'b0; // TODO

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
wire [7:0] ah_out;
wire [6:0] meta_status_out;


// TODO(ww): Need to actually wire up opnd0_r to EAX to LAHF/SAHF.
meta meta_x(
  .opc(opc),
  .ah_in(opnd0_r[15:8]),
  .status_in(status_in),

  .ah_wr(ah_wr),
  .ah_out(ah_out),
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

assign opnd0_w = exe_is_alu ? alu_result :
                 exe_is_mu  ? mu_result  :
                              32'b0;

// Update our flag state based on whichever execution unit actually took effect.
// Only the ALU and meta units can modify flag state, so we don't need to check
// for the move unit here.
assign o_eflags = exe_is_alu ? alu_eflags
                  : (exe_is_meta ? meta_eflags : eflags);

endmodule
