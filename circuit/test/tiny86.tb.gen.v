// this file was generated by ./codegen/tbgen on 2021-04-08 17:42:34 -0400
// do NOT edit it by hand
module tiny86_tb();
reg clk, reset;
reg [31:0] current_vec, error_count;
reg [879:0] test_vectors [127:0];
reg [559:0] step;
reg [31:0] exp_o_eax;
wire [31:0] o_eax;
reg [31:0] exp_o_ebx;
wire [31:0] o_ebx;
reg [31:0] exp_o_ecx;
wire [31:0] o_ecx;
reg [31:0] exp_o_edx;
wire [31:0] o_edx;
reg [31:0] exp_o_esi;
wire [31:0] o_esi;
reg [31:0] exp_o_edi;
wire [31:0] o_edi;
reg [31:0] exp_o_esp;
wire [31:0] o_esp;
reg [31:0] exp_o_ebp;
wire [31:0] o_ebp;
reg [31:0] exp_o_eip;
wire [31:0] o_eip;
reg [31:0] exp_o_eflags;
wire [31:0] o_eflags;
tiny86 dut(
.step(step),
.o_eax(o_eax),
.o_ebx(o_ebx),
.o_ecx(o_ecx),
.o_edx(o_edx),
.o_esi(o_esi),
.o_edi(o_edi),
.o_esp(o_esp),
.o_ebp(o_ebp),
.o_eip(o_eip),
.o_eflags(o_eflags)
);
always
  begin
    clk = 1; #10; clk = 0; #10;
  end
initial
  begin
    $readmemb("tiny86.tv", test_vectors);
    current_vec = 0; error_count = 0;
    reset = 1; #10; reset = 0;
  end
always @(posedge clk)
  begin
    #1; { step, exp_o_eax, exp_o_ebx, exp_o_ecx, exp_o_edx, exp_o_esi, exp_o_edi, exp_o_esp, exp_o_ebp, exp_o_eip, exp_o_eflags } = test_vectors[current_vec];
  end
always @(negedge clk)
  begin
    if (~reset) begin
      if (exp_o_eax === o_eax || exp_o_eax === 32'bx) begin
  $display("TBGEN-PASS tiny86:%0d o_eax", current_vec);
end else begin
  $display("TBGEN-FAIL tiny86:%0d expected o_eax to be 0x%h, was 0x%h", current_vec, exp_o_eax, o_eax);
  error_count = error_count + 1;
end

if (exp_o_ebx === o_ebx || exp_o_ebx === 32'bx) begin
  $display("TBGEN-PASS tiny86:%0d o_ebx", current_vec);
end else begin
  $display("TBGEN-FAIL tiny86:%0d expected o_ebx to be 0x%h, was 0x%h", current_vec, exp_o_ebx, o_ebx);
  error_count = error_count + 1;
end

if (exp_o_ecx === o_ecx || exp_o_ecx === 32'bx) begin
  $display("TBGEN-PASS tiny86:%0d o_ecx", current_vec);
end else begin
  $display("TBGEN-FAIL tiny86:%0d expected o_ecx to be 0x%h, was 0x%h", current_vec, exp_o_ecx, o_ecx);
  error_count = error_count + 1;
end

if (exp_o_edx === o_edx || exp_o_edx === 32'bx) begin
  $display("TBGEN-PASS tiny86:%0d o_edx", current_vec);
end else begin
  $display("TBGEN-FAIL tiny86:%0d expected o_edx to be 0x%h, was 0x%h", current_vec, exp_o_edx, o_edx);
  error_count = error_count + 1;
end

if (exp_o_esi === o_esi || exp_o_esi === 32'bx) begin
  $display("TBGEN-PASS tiny86:%0d o_esi", current_vec);
end else begin
  $display("TBGEN-FAIL tiny86:%0d expected o_esi to be 0x%h, was 0x%h", current_vec, exp_o_esi, o_esi);
  error_count = error_count + 1;
end

if (exp_o_edi === o_edi || exp_o_edi === 32'bx) begin
  $display("TBGEN-PASS tiny86:%0d o_edi", current_vec);
end else begin
  $display("TBGEN-FAIL tiny86:%0d expected o_edi to be 0x%h, was 0x%h", current_vec, exp_o_edi, o_edi);
  error_count = error_count + 1;
end

if (exp_o_esp === o_esp || exp_o_esp === 32'bx) begin
  $display("TBGEN-PASS tiny86:%0d o_esp", current_vec);
end else begin
  $display("TBGEN-FAIL tiny86:%0d expected o_esp to be 0x%h, was 0x%h", current_vec, exp_o_esp, o_esp);
  error_count = error_count + 1;
end

if (exp_o_ebp === o_ebp || exp_o_ebp === 32'bx) begin
  $display("TBGEN-PASS tiny86:%0d o_ebp", current_vec);
end else begin
  $display("TBGEN-FAIL tiny86:%0d expected o_ebp to be 0x%h, was 0x%h", current_vec, exp_o_ebp, o_ebp);
  error_count = error_count + 1;
end

if (exp_o_eip === o_eip || exp_o_eip === 32'bx) begin
  $display("TBGEN-PASS tiny86:%0d o_eip", current_vec);
end else begin
  $display("TBGEN-FAIL tiny86:%0d expected o_eip to be 0x%h, was 0x%h", current_vec, exp_o_eip, o_eip);
  error_count = error_count + 1;
end

if (exp_o_eflags === o_eflags || exp_o_eflags === 32'bx) begin
  $display("TBGEN-PASS tiny86:%0d o_eflags", current_vec);
end else begin
  $display("TBGEN-FAIL tiny86:%0d expected o_eflags to be 0x%h, was 0x%h", current_vec, exp_o_eflags, o_eflags);
  error_count = error_count + 1;
end

      current_vec = current_vec + 1;

      if (test_vectors[current_vec] === 880'bx) begin
        $display("TBGEN-DONE tiny86 %0d errors=%0d", current_vec, error_count);
        $finish;
      end
    end
  end
endmodule
