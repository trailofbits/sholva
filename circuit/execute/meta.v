`include "defines.v"
`include "codegen/commands.gen.v"

module meta(
  input [5:0] opc,
  input [7:0] ah_in,
  input [6:0] status_in,

  output ah_wr,
  output [7:0] ah_out,
  output [6:0] status_out
);

`include "funcs.v"

wire [63:0] opc_1hot = one_hot64(opc);

assign status_out = opc_1hot[`CMD_CLC] ? {status_in[6:5], 1'b0, status_in[3:0]}
                  : opc_1hot[`CMD_CLD] ? {1'b0, status_in[5:0]}
                  : opc_1hot[`CMD_STC] ? {status_in[6:5], 1'b1, status_in[3:0]}
                  : opc_1hot[`CMD_STD] ? {1'b1, status_in[5:0]}
                  : status_in;

assign ah_wr = opc_1hot[`CMD_LAHF];
assign ah_out = ah_wr ? ah_in : ah_in; // TODO(ww): actually set this.

endmodule
