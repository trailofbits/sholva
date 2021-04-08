// this file was generated by ./codegen/tbgen on 2021-04-08 16:08:54 -0400
// do NOT edit it by hand
module decode_prefix_tb();
reg clk, reset;
reg [31:0] current_vec, error_count;
reg [181:0] test_vectors [127:0];
reg [95:0] raw_instr;
reg [79:0] exp_unprefixed_instr;
wire [79:0] unprefixed_instr;
reg [0:0] exp_prefix_operand_16bit;
wire [0:0] prefix_operand_16bit;
reg [0:0] exp_prefix_address_16bit;
wire [0:0] prefix_address_16bit;
reg [1:0] exp_prefix_rep;
wire [1:0] prefix_rep;
reg [1:0] exp_prefix_count;
wire [1:0] prefix_count;
decode_prefix dut(
.raw_instr(raw_instr),
.unprefixed_instr(unprefixed_instr),
.prefix_operand_16bit(prefix_operand_16bit),
.prefix_address_16bit(prefix_address_16bit),
.prefix_rep(prefix_rep),
.prefix_count(prefix_count)
);
always
  begin
    clk = 1; #5; clk = 0; #5;
  end
initial
  begin
    $readmemb("decode_prefix.tv", test_vectors);
    current_vec = 0; error_count = 0;
    reset = 1; #10; reset = 0;
  end
always @(posedge clk)
  begin
    #1; { raw_instr, exp_unprefixed_instr, exp_prefix_operand_16bit, exp_prefix_address_16bit, exp_prefix_rep, exp_prefix_count } = test_vectors[current_vec];
  end
always @(negedge clk)
  begin
    if (~reset) begin
      if (exp_unprefixed_instr === unprefixed_instr || exp_unprefixed_instr === 80'bx) begin
  $display("TBGEN-PASS decode_prefix:%0d unprefixed_instr", current_vec);
end else begin
  $display("TBGEN-FAIL decode_prefix:%0d expected unprefixed_instr to be 0x%h, was 0x%h", current_vec, exp_unprefixed_instr, unprefixed_instr);
  error_count = error_count + 1;
end

if (exp_prefix_operand_16bit === prefix_operand_16bit || exp_prefix_operand_16bit === 1'bx) begin
  $display("TBGEN-PASS decode_prefix:%0d prefix_operand_16bit", current_vec);
end else begin
  $display("TBGEN-FAIL decode_prefix:%0d expected prefix_operand_16bit to be 0x%h, was 0x%h", current_vec, exp_prefix_operand_16bit, prefix_operand_16bit);
  error_count = error_count + 1;
end

if (exp_prefix_address_16bit === prefix_address_16bit || exp_prefix_address_16bit === 1'bx) begin
  $display("TBGEN-PASS decode_prefix:%0d prefix_address_16bit", current_vec);
end else begin
  $display("TBGEN-FAIL decode_prefix:%0d expected prefix_address_16bit to be 0x%h, was 0x%h", current_vec, exp_prefix_address_16bit, prefix_address_16bit);
  error_count = error_count + 1;
end

if (exp_prefix_rep === prefix_rep || exp_prefix_rep === 2'bx) begin
  $display("TBGEN-PASS decode_prefix:%0d prefix_rep", current_vec);
end else begin
  $display("TBGEN-FAIL decode_prefix:%0d expected prefix_rep to be 0x%h, was 0x%h", current_vec, exp_prefix_rep, prefix_rep);
  error_count = error_count + 1;
end

if (exp_prefix_count === prefix_count || exp_prefix_count === 2'bx) begin
  $display("TBGEN-PASS decode_prefix:%0d prefix_count", current_vec);
end else begin
  $display("TBGEN-FAIL decode_prefix:%0d expected prefix_count to be 0x%h, was 0x%h", current_vec, exp_prefix_count, prefix_count);
  error_count = error_count + 1;
end

      current_vec = current_vec + 1;

      if (test_vectors[current_vec] === 182'bx) begin
        $display("TBGEN-DONE decode_prefix %0d errors=%0d", current_vec, error_count);
        $finish;
      end
    end
  end
endmodule
