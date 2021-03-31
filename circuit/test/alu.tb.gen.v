// this file was generated by ./codegen/tbgen on 2021-03-31 14:52:45 -0400
// do NOT edit it by hand
module alu_tb();
reg clk, reset;
reg [31:0] current_vec, error_count;
reg [119:0] test_vectors [127:0];
reg [13:0] cntl;
reg [4:0] status_in;
reg [31:0] opnd0_r;
reg [31:0] opnd1_r;
reg [4:0] exp_status_out;
wire [4:0] status_out;
reg [31:0] exp_result;
wire [31:0] result;
alu dut(
.cntl(cntl),
.status_in(status_in),
.opnd0_r(opnd0_r),
.opnd1_r(opnd1_r),
.status_out(status_out),
.result(result)
);
always
  begin
    clk = 1; #5; clk = 0; #5;
  end
initial
  begin
    $readmemb("alu.tv", test_vectors);
    current_vec = 0; error_count = 0;
    reset = 1; #10; reset = 0;
  end
always @(posedge clk)
  begin
    #1; { cntl, status_in, opnd0_r, opnd1_r, exp_status_out, exp_result } = test_vectors[current_vec];
  end
always @(negedge clk)
  begin
    if (~reset) begin
      if (exp_status_out === status_out || exp_status_out === 5'bx) begin
  $display("TBGEN-PASS alu:%0d status_out", current_vec);
end else begin
  $display("TBGEN-FAIL alu:%0d expected status_out to be 0x%h, was 0x%h", current_vec, exp_status_out, status_out);
  error_count = error_count + 1;
end

if (exp_result === result || exp_result === 32'bx) begin
  $display("TBGEN-PASS alu:%0d result", current_vec);
end else begin
  $display("TBGEN-FAIL alu:%0d expected result to be 0x%h, was 0x%h", current_vec, exp_result, result);
  error_count = error_count + 1;
end

      current_vec = current_vec + 1;

      if (test_vectors[current_vec] === 120'bx) begin
        $display("TBGEN-DONE alu %0d errors=%0d", current_vec, error_count);
        $finish;
      end
    end
  end
endmodule