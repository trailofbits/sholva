`include "defines.v"
`include "codegen/commands.gen.v"

module decode_opc_phase2(
  input [71:0] unescaped_instr,
  input is_2byte,

  output [5:0] opc,
  output [3:0] opnd_form,
  output [1:0] opnd_count,
  output imm_1byte,
  output reg_1byte,
  output opnd0_is_read,
  output opnd0_is_write,
  output opnd1_is_read,
  output opnd1_is_write,
  output opnd2_is_read,
  output opnd2_is_write
);

wire opc_8byte = ~unescaped_instr[0];

wire opc_assign_rm = ~unescaped_instr[1];
wire opc_assign_reg = ~opc_assign_reg;

// Off to the races.
`include "codegen/opc_map.gen.v"

endmodule
