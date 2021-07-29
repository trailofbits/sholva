`include "defines.v"
`include "codegen/commands.gen.v"

module meta(
  input [5:0] opc,
  input [31:0] opnd_in,
  input [6:0] status_in,

  output ah_wr,
  output [31:0] result,
  output [6:0] status_out
);

`include "funcs.v"

wire [63:0] opc_1hot = one_hot64(opc);

// Take AH from opnd_in. opnd_in might not actually be EAX, so only
// use it if we're sure.
wire [7:0] maybe_ah = opnd_in[15:8];

// Map the flag fields of the AH register to their corresponding bits
// in our compressed status; our compressed status also contains fields
// that SAHF can't modify (DF and OF), so we preserve those.
wire [6:0] ah_to_status = {
                            status_in[`STAT_DF],
                            maybe_ah[`EFLAGS_AF],
                            maybe_ah[`EFLAGS_CF],
                            maybe_ah[`EFLAGS_PF],
                            maybe_ah[`EFLAGS_ZF],
                            maybe_ah[`EFLAGS_SF],
                            status_in[`STAT_OF]
                          };

assign status_out = opc_1hot[`CMD_CLC] ? {status_in[6:5], 1'b0, status_in[3:0]}
                  : opc_1hot[`CMD_CLD] ? {1'b0, status_in[5:0]}
                  : opc_1hot[`CMD_STC] ? {status_in[6:5], 1'b1, status_in[3:0]}
                  : opc_1hot[`CMD_STD] ? {1'b1, status_in[5:0]}
                  : opc_1hot[`CMD_SAHF] ? ah_to_status
                  : status_in;

assign ah_wr = opc_1hot[`CMD_LAHF];
assign result = ah_wr ? opnd_in : opnd_in; // TODO(ww): actually set this.

endmodule
