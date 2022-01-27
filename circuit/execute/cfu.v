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
  input ecx_is_zero,
  input [31:0] eip,
  input [3:0] instr_len,
  input [31:0] address,

  output [31:0] next_eip
);

`include "funcs.v"

wire [127:0] opc_1hot = one_hot128(opc);

// Convenience aliases, to keep `jcc_eval` terse below.
wire cf = eflags[`EFLAGS_CF];
wire pf = eflags[`EFLAGS_PF];
// wire af = eflags[`EFLAGS_AF]; // NOTE: Unused.
wire zf = eflags[`EFLAGS_ZF];
wire sf = eflags[`EFLAGS_SF];
// wire tf = eflags[`EFLAGS_TF]; // NOTE: Unused.
// wire if_ = eflags[`EFLAGS_IF]; // NOTE: Unused.
// wire df = eflags[`EFLAGS_DF]; // NOTE: Unused.
wire of = eflags[`EFLAGS_OF];

// Evaluate the appropriate EFLAGS/ecx_is_zero for a Jcc.
// TODO(ww): Is there a cleaner way to express this?
wire jcc_eval = opc_1hot[`CMD_JO]   ? of               :
                opc_1hot[`CMD_JNO]  ? !of              :
                opc_1hot[`CMD_JB]   ? cf               :
                opc_1hot[`CMD_JAE]  ? !cf              :
                opc_1hot[`CMD_JE]   ? zf               :
                opc_1hot[`CMD_JNE]  ? !zf              :
                opc_1hot[`CMD_JBE]  ? cf | zf          :
                opc_1hot[`CMD_JA]   ? !cf & !zf        :
                opc_1hot[`CMD_JS]   ? sf               :
                opc_1hot[`CMD_JNS]  ? !sf              :
                opc_1hot[`CMD_JP]   ? pf               :
                opc_1hot[`CMD_JNP]  ? !pf              :
                opc_1hot[`CMD_JL]   ? sf != of         :
                opc_1hot[`CMD_JNL]  ? sf == of         :
                opc_1hot[`CMD_JLE]  ? zf | (sf != of)  :
                opc_1hot[`CMD_JG]   ? !zf & (sf == of) :
                opc_1hot[`CMD_JCXZ] ? ecx_is_zero      : 1'b0;

// Are we performing a control flow "transfer," i.e. doing anything other
// than moving the EIP to the next instruction in the text stream?
// TODO: Evaluate LOOP conditions here.
wire cf_xfer = jcc_eval             |
               opc_1hot[`CMD_CALLr] |
               opc_1hot[`CMD_CALLi] |
               opc_1hot[`CMD_JMPr]  |
               opc_1hot[`CMD_JMPi]  |
               opc_1hot[`CMD_RET]   ;

// TODO: Support other absolute indirect semantics.
wire cf_xfer_absolute = opc_1hot[`CMD_CALLi] |
                        opc_1hot[`CMD_JMPi]  |
                        opc_1hot[`CMD_RET]   ;

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
