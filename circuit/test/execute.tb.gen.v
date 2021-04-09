// this file was generated by ./codegen/tbgen on 2021-04-09 15:27:42 -0400
// do NOT edit it by hand
module execute_tb();
reg clk, reset;
reg [31:0] current_vec, error_count;
reg [165:0] test_vectors [127:0];
reg [5:0] opc;
reg [31:0] eflags;
reg [31:0] opnd0_r;
reg [31:0] opnd1_r;
reg [31:0] exp_o_eflags;
wire [31:0] o_eflags;
reg [31:0] exp_opnd0_w;
wire [31:0] opnd0_w;
execute dut(
.opc(opc),
.eflags(eflags),
.opnd0_r(opnd0_r),
.opnd1_r(opnd1_r),
.o_eflags(o_eflags),
.opnd0_w(opnd0_w)
);
always
  begin
    clk = 1; #5; clk = 0; #5;
  end
initial
  begin
    $dumpfile("execute.tb.vcd");
    $dumpvars(0, execute_tb);
    $readmemb("execute.tv", test_vectors);
    current_vec = 0; error_count = 0;
    reset = 1; #10; reset = 0;
  end
always @(posedge clk)
  begin
    #1; { opc, eflags, opnd0_r, opnd1_r, exp_o_eflags, exp_opnd0_w } = test_vectors[current_vec];
  end
always @(negedge clk)
  begin
    if (~reset) begin
      if (exp_o_eflags === o_eflags || exp_o_eflags === 32'bx) begin
  $display("TBGEN-PASS execute:%0d o_eflags", current_vec);
end else begin
  $display("TBGEN-FAIL execute:%0d expected o_eflags to be 0x%h, was 0x%h", current_vec, exp_o_eflags, o_eflags);
  error_count = error_count + 1;
end

if (exp_opnd0_w === opnd0_w || exp_opnd0_w === 32'bx) begin
  $display("TBGEN-PASS execute:%0d opnd0_w", current_vec);
end else begin
  $display("TBGEN-FAIL execute:%0d expected opnd0_w to be 0x%h, was 0x%h", current_vec, exp_opnd0_w, opnd0_w);
  error_count = error_count + 1;
end

      current_vec = current_vec + 1;

      if (test_vectors[current_vec] === 166'bx) begin
        $display("TBGEN-DONE execute %0d errors=%0d", current_vec, error_count);
        $finish;
      end
    end
  end
endmodule
