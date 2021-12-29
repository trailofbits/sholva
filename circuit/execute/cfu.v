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

// Are we performing a control flow "transfer," i.e. doing anything other
// than moving the EIP to the next instruction in the text stream?
// TODO: Evaluate Jcc, LOOP, JCXZ conditions here.
wire cf_xfer = opc_1hot[`CMD_CALL] ||
               opc_1hot[`CMD_JMP]  ||
               opc_1hot[`CMD_RET]  ;

// TODO: Handle absolute/relative transfers. Only relative is currently supported.
wire cf_xfer_absolute = 1'b0;

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
