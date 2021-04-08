// this file was generated by ./codegen/tbgen on 2021-04-08 16:32:32 -0400
// do NOT edit it by hand
module decode_opc_phase1_tb();
reg clk, reset;
reg [31:0] current_vec, error_count;
reg [152:0] test_vectors [127:0];
reg [79:0] unprefixed_instr;
reg [0:0] exp_is_2byte;
wire [0:0] is_2byte;
reg [71:0] exp_unescaped_instr;
wire [71:0] unescaped_instr;
decode_opc_phase1 dut(
.unprefixed_instr(unprefixed_instr),
.is_2byte(is_2byte),
.unescaped_instr(unescaped_instr)
);
always
  begin
    clk = 1; #10; clk = 0; #10;
  end
initial
  begin
    $readmemb("decode_opc_phase1.tv", test_vectors);
    current_vec = 0; error_count = 0;
    reset = 1; #10; reset = 0;
  end
always @(posedge clk)
  begin
    #1; { unprefixed_instr, exp_is_2byte, exp_unescaped_instr } = test_vectors[current_vec];
  end
always @(negedge clk)
  begin
    if (~reset) begin
      if (exp_is_2byte === is_2byte || exp_is_2byte === 1'bx) begin
  $display("TBGEN-PASS decode_opc_phase1:%0d is_2byte", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opc_phase1:%0d expected is_2byte to be 0x%h, was 0x%h", current_vec, exp_is_2byte, is_2byte);
  error_count = error_count + 1;
end

if (exp_unescaped_instr === unescaped_instr || exp_unescaped_instr === 72'bx) begin
  $display("TBGEN-PASS decode_opc_phase1:%0d unescaped_instr", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opc_phase1:%0d expected unescaped_instr to be 0x%h, was 0x%h", current_vec, exp_unescaped_instr, unescaped_instr);
  error_count = error_count + 1;
end

      current_vec = current_vec + 1;

      if (test_vectors[current_vec] === 153'bx) begin
        $display("TBGEN-DONE decode_opc_phase1 %0d errors=%0d", current_vec, error_count);
        $finish;
      end
    end
  end
endmodule
