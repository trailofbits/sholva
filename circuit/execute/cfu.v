// The "control flow unit" for Tiny86. Handles all possible EIP changes:
// 1. No control flow transfers: the next EIP in decoding order
// 2. Control flow transfer, relative to the current EIP
// 3. Control flow transfer, relative to the next EIP
// 4. Control flow transfer, absolute displacement

`include "defines.v"
`include "codegen/commands.gen.v"

module cfu(
  input [6:0] opc,
  input [31:0] eflags,
  input [31:0] eip,
  input [3:0] instr_len,
  input [31:0] address,

  output [31:0] next_eip
);

`include "funcs.v"

wire [127:0] opc_1hot = one_hot128(opc);

// Are we performing a conditional jump?
// TODO(ww): Need appropriate control wires for `ECX == 0`.
wire cmd_is_jcc = opc_1hot[`CMD_JO]   ||
                  opc_1hot[`CMD_JCXZ] ||
                  opc_1hot[`CMD_JNO]  ||
                  opc_1hot[`CMD_JNO]  ||
                  opc_1hot[`CMD_JB]   ||
                  opc_1hot[`CMD_JAE]  ||
                  opc_1hot[`CMD_JE]   ||
                  opc_1hot[`CMD_JNE]  ||
                  opc_1hot[`CMD_JBE]  ||
                  opc_1hot[`CMD_JA]   ||
                  opc_1hot[`CMD_JS]   ||
                  opc_1hot[`CMD_JNS]  ||
                  opc_1hot[`CMD_JP]   ||
                  opc_1hot[`CMD_JNP]  ||
                  opc_1hot[`CMD_JL]   ||
                  opc_1hot[`CMD_JNL]  ||
                  opc_1hot[`CMD_JLE]  ||
                  opc_1hot[`CMD_JG]   ;

// Are we performing a control flow "transfer," i.e. doing anything other
// than moving the EIP to the next instruction in the text stream?
// TODO: Evaluate Jcc, LOOP, JCXZ conditions here.
wire cf_xfer = cmd_is_jcc            ||
               opc_1hot[`CMD_CALLr]  ||
               opc_1hot[`CMD_CALLi]  ||
               opc_1hot[`CMD_JMPr]   ||
               opc_1hot[`CMD_JMPi]   ||
               opc_1hot[`CMD_RET]    ;

// TODO: Support other absolute indirect semantics.
wire cf_xfer_absolute = opc_1hot[`CMD_CALLi] | opc_1hot[`CMD_JMPi];

// The EIP immediately after our current one in decoding order, which may
// or may not be our actual next EIP depending on control flow.
wire [31:0] seq_eip = eip + {28'd0, instr_len};

// The "transfer" EIP, which is either an absolute address or the sum of our
// next sequential EIP and a relative address.
// TODO: There are probably some annoying edge cases where we need
// `eip + address` instead of `seq_eip + address`.
wire [31:0] xfer_eip = cf_xfer_absolute ? address : seq_eip + address;

assign next_eip = cf_xfer ? xfer_eip : seq_eip;

endmodule
