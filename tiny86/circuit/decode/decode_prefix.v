`default_nettype none

module decode_prefix(
  input [95:0] raw_instr,

  output [87:0] unprefixed_instr,
  output prefix_operand_16bit,
  output prefix_address_16bit,
  output [1:0] prefix_rep,
  output [1:0] prefix_count
);

// NOTE(ww): For the time being, we impose a canonical prefix order:
// We expect REP/REPNE before any address/operand override.

assign prefix_rep = (raw_instr[7:0] == 8'hF2) ? 2'd1 :
                    (raw_instr[7:0] == 8'hF3) ? 2'd2 : 2'd0;

assign prefix_operand_16bit = (raw_instr[7:0] == 8'h66 || raw_instr[15:8] == 8'h66);

assign prefix_address_16bit = (raw_instr[7:0] == 8'h67 || raw_instr[15:8] == 8'h67);

assign prefix_count = (prefix_rep != 2'd0 && (prefix_operand_16bit || prefix_address_16bit)) ?
                      2'd2 : (prefix_rep != 2'd0 || prefix_operand_16bit || prefix_address_16bit) ?
                      2'd1 : 2'd0;

assign unprefixed_instr = (prefix_count == 2'd2) ? {8'd0, raw_instr[95:16]} :
                          (prefix_count == 2'd1) ? raw_instr[95:8] : raw_instr[87:0];

endmodule
