`include "defines.v"
`include "codegen/commands.gen.v"

module decode_opc_phase2(
  input [71:0] unescaped_instr,
  input is_2byte,

  output [6:0] opc,
  output [3:0] opnd_form,
  output imm_1byte,
  output reg_1byte

  // TODO: outputs:
  // operand 1 selector (imm, reg, mem)
  // operand 2 selector (imm, reg, mem)
  // some wires for operand sizes (8/16/32)
  // some wires for whether operands are sign/zero extended
);

assign opc_8byte = ~unescaped_instr[0];

assign opc_assign_rm = ~unescaped_instr[1];
assign opc_assign_reg = ~opc_assign_reg;

// Off to the races.
`include "codegen/opc_map.gen.v"

endmodule
