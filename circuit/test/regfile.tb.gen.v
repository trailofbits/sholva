// this file was generated by ./codegen/tbgen
// do NOT edit it by hand
module regfile_tb();
reg clk, reset;
reg [31:0] current_vec, error_count;
reg [713:0] test_vectors [127:0];
reg [31:0] i_eax;
reg [31:0] i_ebx;
reg [31:0] i_ecx;
reg [31:0] i_edx;
reg [31:0] i_esi;
reg [31:0] i_edi;
reg [31:0] i_esp;
reg [31:0] i_ebp;
reg [1:0] dest0_kind;
reg [1:0] dest1_kind;
reg [2:0] dest0_sel;
reg [2:0] dest1_sel;
reg [31:0] opnd0_w;
reg [31:0] opnd1_w;
reg [31:0] next_eip;
reg [31:0] next_eflags;
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
regfile dut(
.i_eax(i_eax),
.i_ebx(i_ebx),
.i_ecx(i_ecx),
.i_edx(i_edx),
.i_esi(i_esi),
.i_edi(i_edi),
.i_esp(i_esp),
.i_ebp(i_ebp),
.dest0_kind(dest0_kind),
.dest1_kind(dest1_kind),
.dest0_sel(dest0_sel),
.dest1_sel(dest1_sel),
.opnd0_w(opnd0_w),
.opnd1_w(opnd1_w),
.next_eip(next_eip),
.next_eflags(next_eflags),
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
    clk = 1; #5; clk = 0; #5;
  end
initial
  begin
    $dumpfile("regfile.tb.vcd");
    $dumpvars(0, regfile_tb);
    $readmemb("regfile.tv", test_vectors);
    current_vec = 0; error_count = 0;
    reset = 1; #10; reset = 0;
  end
always @(posedge clk)
  begin
    #1; { i_eax, i_ebx, i_ecx, i_edx, i_esi, i_edi, i_esp, i_ebp, dest0_kind, dest1_kind, dest0_sel, dest1_sel, opnd0_w, opnd1_w, next_eip, next_eflags, exp_o_eax, exp_o_ebx, exp_o_ecx, exp_o_edx, exp_o_esi, exp_o_edi, exp_o_esp, exp_o_ebp, exp_o_eip, exp_o_eflags } = test_vectors[current_vec];
  end
always @(negedge clk)
  begin
    if (~reset) begin
      if (exp_o_eax === o_eax || exp_o_eax === 32'bx) begin
  $display("TBGEN-PASS regfile:%0d o_eax", current_vec);
end else begin
  $display("TBGEN-FAIL regfile:%0d expected o_eax to be 0x%h, was 0x%h", current_vec, exp_o_eax, o_eax);
  error_count = error_count + 1;
end

if (exp_o_ebx === o_ebx || exp_o_ebx === 32'bx) begin
  $display("TBGEN-PASS regfile:%0d o_ebx", current_vec);
end else begin
  $display("TBGEN-FAIL regfile:%0d expected o_ebx to be 0x%h, was 0x%h", current_vec, exp_o_ebx, o_ebx);
  error_count = error_count + 1;
end

if (exp_o_ecx === o_ecx || exp_o_ecx === 32'bx) begin
  $display("TBGEN-PASS regfile:%0d o_ecx", current_vec);
end else begin
  $display("TBGEN-FAIL regfile:%0d expected o_ecx to be 0x%h, was 0x%h", current_vec, exp_o_ecx, o_ecx);
  error_count = error_count + 1;
end

if (exp_o_edx === o_edx || exp_o_edx === 32'bx) begin
  $display("TBGEN-PASS regfile:%0d o_edx", current_vec);
end else begin
  $display("TBGEN-FAIL regfile:%0d expected o_edx to be 0x%h, was 0x%h", current_vec, exp_o_edx, o_edx);
  error_count = error_count + 1;
end

if (exp_o_esi === o_esi || exp_o_esi === 32'bx) begin
  $display("TBGEN-PASS regfile:%0d o_esi", current_vec);
end else begin
  $display("TBGEN-FAIL regfile:%0d expected o_esi to be 0x%h, was 0x%h", current_vec, exp_o_esi, o_esi);
  error_count = error_count + 1;
end

if (exp_o_edi === o_edi || exp_o_edi === 32'bx) begin
  $display("TBGEN-PASS regfile:%0d o_edi", current_vec);
end else begin
  $display("TBGEN-FAIL regfile:%0d expected o_edi to be 0x%h, was 0x%h", current_vec, exp_o_edi, o_edi);
  error_count = error_count + 1;
end

if (exp_o_esp === o_esp || exp_o_esp === 32'bx) begin
  $display("TBGEN-PASS regfile:%0d o_esp", current_vec);
end else begin
  $display("TBGEN-FAIL regfile:%0d expected o_esp to be 0x%h, was 0x%h", current_vec, exp_o_esp, o_esp);
  error_count = error_count + 1;
end

if (exp_o_ebp === o_ebp || exp_o_ebp === 32'bx) begin
  $display("TBGEN-PASS regfile:%0d o_ebp", current_vec);
end else begin
  $display("TBGEN-FAIL regfile:%0d expected o_ebp to be 0x%h, was 0x%h", current_vec, exp_o_ebp, o_ebp);
  error_count = error_count + 1;
end

if (exp_o_eip === o_eip || exp_o_eip === 32'bx) begin
  $display("TBGEN-PASS regfile:%0d o_eip", current_vec);
end else begin
  $display("TBGEN-FAIL regfile:%0d expected o_eip to be 0x%h, was 0x%h", current_vec, exp_o_eip, o_eip);
  error_count = error_count + 1;
end

if (exp_o_eflags === o_eflags || exp_o_eflags === 32'bx) begin
  $display("TBGEN-PASS regfile:%0d o_eflags", current_vec);
end else begin
  $display("TBGEN-FAIL regfile:%0d expected o_eflags to be 0x%h, was 0x%h", current_vec, exp_o_eflags, o_eflags);
  error_count = error_count + 1;
end

      current_vec = current_vec + 1;

      if (test_vectors[current_vec] === 714'bx) begin
        $display("TBGEN-DONE regfile %0d errors=%0d", current_vec, error_count);
        $finish;
      end
    end
  end
endmodule
