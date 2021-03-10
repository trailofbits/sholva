// this file was generated by ./codegen/tbgen on 2021-03-10 18:44:07 -0500
// do NOT edit it by hand
module fetch_tb();
reg clk, reset;
reg [31:0] current_vec, error_count;
reg [1119:0] test_vectors [127:0];
reg [559:0] step;
reg [95:0] exp_raw_instr;
wire [95:0] raw_instr;
reg [319:0] exp_raw_regs;
wire [319:0] raw_regs;
reg [71:0] exp_raw_hint1;
wire [71:0] raw_hint1;
reg [71:0] exp_raw_hint2;
wire [71:0] raw_hint2;
fetch dut(
.step(step),
.raw_instr(raw_instr),
.raw_regs(raw_regs),
.raw_hint1(raw_hint1),
.raw_hint2(raw_hint2)
);
always
  begin
    clk = 1; #5; clk = 0; #5;
  end
initial
  begin
    $readmemh("fetch.tv", test_vectors);
    current_vec = 0; error_count = 0;
    reset = 1; #10; reset = 0;
  end
always @(posedge clk)
  begin
    #1; { step, exp_raw_instr, exp_raw_regs, exp_raw_hint1, exp_raw_hint2 } = test_vectors[current_vec];
  end
always @(negedge clk)
  begin
    if (~reset) begin
      if (exp_raw_instr !== raw_instr) begin
  $display("FAIL(fetch:%0d): expected raw_instr to be %h, was %h", current_vec, exp_raw_instr, raw_instr);
  error_count = error_count + 1;
end else begin
  $display("PASS(fetch:%0d): raw_instr", current_vec);
end

if (exp_raw_regs !== raw_regs) begin
  $display("FAIL(fetch:%0d): expected raw_regs to be %h, was %h", current_vec, exp_raw_regs, raw_regs);
  error_count = error_count + 1;
end else begin
  $display("PASS(fetch:%0d): raw_regs", current_vec);
end

if (exp_raw_hint1 !== raw_hint1) begin
  $display("FAIL(fetch:%0d): expected raw_hint1 to be %h, was %h", current_vec, exp_raw_hint1, raw_hint1);
  error_count = error_count + 1;
end else begin
  $display("PASS(fetch:%0d): raw_hint1", current_vec);
end

if (exp_raw_hint2 !== raw_hint2) begin
  $display("FAIL(fetch:%0d): expected raw_hint2 to be %h, was %h", current_vec, exp_raw_hint2, raw_hint2);
  error_count = error_count + 1;
end else begin
  $display("PASS(fetch:%0d): raw_hint2", current_vec);
end

      current_vec = current_vec + 1;

      if (test_vectors[current_vec] === 1120'bx) begin
        $display("DONE(fetch): errors=%0d", error_count);
        $finish;
      end
    end
  end
endmodule
