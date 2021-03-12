// this file was generated by ./codegen/tbgen on 2021-03-12 17:03:12 -0500
// do NOT edit it by hand
module mux8_32_tb();
reg clk, reset;
reg [31:0] current_vec, error_count;
reg [291:0] test_vectors [127:0];
reg [3:0] sel;
reg [31:0] in0;
reg [31:0] in1;
reg [31:0] in2;
reg [31:0] in3;
reg [31:0] in4;
reg [31:0] in5;
reg [31:0] in6;
reg [31:0] in7;
reg [31:0] exp_out;
wire [31:0] out;
mux8_32 dut(
.sel(sel),
.in0(in0),
.in1(in1),
.in2(in2),
.in3(in3),
.in4(in4),
.in5(in5),
.in6(in6),
.in7(in7),
.out(out)
);
always
  begin
    clk = 1; #5; clk = 0; #5;
  end
initial
  begin
    $readmemb("mux8_32.tv", test_vectors);
    current_vec = 0; error_count = 0;
    reset = 1; #10; reset = 0;
  end
always @(posedge clk)
  begin
    #1; { sel, in0, in1, in2, in3, in4, in5, in6, in7, exp_out } = test_vectors[current_vec];
  end
always @(negedge clk)
  begin
    if (~reset) begin
      if (exp_out !== out) begin
  $display("TBGEN-FAIL mux8_32:%0d expected out to be %h, was %h", current_vec, exp_out, out);
  error_count = error_count + 1;
end else begin
  $display("TBGEN-PASS mux8_32:%0d out", current_vec);
end

      current_vec = current_vec + 1;

      if (test_vectors[current_vec] === 292'bx) begin
        $display("TBGEN-DONE mux8_32 %0d errors=%0d", current_vec, error_count);
        $finish;
      end
    end
  end
endmodule
