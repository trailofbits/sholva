`include "defines.v"
`include "codegen/commands.gen.v"

module decode_opc_phase2(
  input [87:0] unescaped_instr,
  input is_2byte,

  output [6:0] opc,
  output [3:0] opnd_form,
  output [1:0] opnd_count,
  output imm_1byte,
  output reg_1byte,

  output opnd0_is_one,
  output opnd0_is_read,
  output opnd0_is_write,

  output opnd1_is_one,
  output opnd1_is_read,
  output opnd1_is_write,

  output opnd2_is_one,
  output opnd2_is_read,
  output opnd2_is_write,

  output source_is_sext,
  output disp_is_rel
);

// A convenience assignment for the opcode byte, with any register operand bits
// masked off. There aren't any 2-byte encodings that use the embedded operand
// form, so we don't need any special casing here.
wire [7:0] opc_without_regs = unescaped_instr[7:0] & 8'b11111000;

// Off to the races.
`include "codegen/opc_map.gen.v"

endmodule
