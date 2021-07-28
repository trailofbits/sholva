`include "codegen/commands.gen.v"

module meta(
  input [5:0] opc,
  input [7:0] ah_in,
  input [5:0] status_in,

  output ah_wr,
  output [7:0] ah_out,
  output [5:0] status_out
);

`include "funcs.v"

wire [63:0] opc_1hot = one_hot64(opc);

// assign status_out = opc_1hot[`];

endmodule
