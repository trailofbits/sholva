// this file was generated by ./codegen/tbgen on 2021-04-08 18:33:06 -0400
// do NOT edit it by hand
module decode_opnds_tb();
reg clk, reset;
reg [31:0] current_vec, error_count;
reg [506:0] test_vectors [127:0];
reg [71:0] unescaped_instr;
reg [31:0] eax;
reg [31:0] ebx;
reg [31:0] ecx;
reg [31:0] edx;
reg [31:0] esi;
reg [31:0] edi;
reg [31:0] esp;
reg [31:0] ebp;
reg [5:0] opc;
reg [3:0] opnd_form;
reg [0:0] imm_1byte;
reg [0:0] reg_1byte;
reg [0:0] prefix_operand_16bit;
reg [0:0] prefix_address_16bit;
reg [0:0] exp_disp_1byte;
wire [0:0] disp_1byte;
reg [31:0] exp_opnd0_r;
wire [31:0] opnd0_r;
reg [31:0] exp_opnd1_r;
wire [31:0] opnd1_r;
reg [31:0] exp_opnd2_r;
wire [31:0] opnd2_r;
reg [1:0] exp_dest0_kind;
wire [1:0] dest0_kind;
reg [1:0] exp_dest1_kind;
wire [1:0] dest1_kind;
reg [31:0] exp_dest0_sel;
wire [31:0] dest0_sel;
reg [31:0] exp_dest1_sel;
wire [31:0] dest1_sel;
decode_opnds dut(
.unescaped_instr(unescaped_instr),
.eax(eax),
.ebx(ebx),
.ecx(ecx),
.edx(edx),
.esi(esi),
.edi(edi),
.esp(esp),
.ebp(ebp),
.opc(opc),
.opnd_form(opnd_form),
.imm_1byte(imm_1byte),
.reg_1byte(reg_1byte),
.prefix_operand_16bit(prefix_operand_16bit),
.prefix_address_16bit(prefix_address_16bit),
.disp_1byte(disp_1byte),
.opnd0_r(opnd0_r),
.opnd1_r(opnd1_r),
.opnd2_r(opnd2_r),
.dest0_kind(dest0_kind),
.dest1_kind(dest1_kind),
.dest0_sel(dest0_sel),
.dest1_sel(dest1_sel)
);
always
  begin
    clk = 1; #5; clk = 0; #5;
  end
initial
  begin
    $dumpfile("decode_opnds.tb.vcd");
    $dumpvars(0, decode_opnds_tb);
    $readmemb("decode_opnds.tv", test_vectors);
    current_vec = 0; error_count = 0;
    reset = 1; #10; reset = 0;
  end
always @(posedge clk)
  begin
    #1; { unescaped_instr, eax, ebx, ecx, edx, esi, edi, esp, ebp, opc, opnd_form, imm_1byte, reg_1byte, prefix_operand_16bit, prefix_address_16bit, exp_disp_1byte, exp_opnd0_r, exp_opnd1_r, exp_opnd2_r, exp_dest0_kind, exp_dest1_kind, exp_dest0_sel, exp_dest1_sel } = test_vectors[current_vec];
  end
always @(negedge clk)
  begin
    if (~reset) begin
      if (exp_disp_1byte === disp_1byte || exp_disp_1byte === 1'bx) begin
  $display("TBGEN-PASS decode_opnds:%0d disp_1byte", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opnds:%0d expected disp_1byte to be 0x%h, was 0x%h", current_vec, exp_disp_1byte, disp_1byte);
  error_count = error_count + 1;
end

if (exp_opnd0_r === opnd0_r || exp_opnd0_r === 32'bx) begin
  $display("TBGEN-PASS decode_opnds:%0d opnd0_r", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opnds:%0d expected opnd0_r to be 0x%h, was 0x%h", current_vec, exp_opnd0_r, opnd0_r);
  error_count = error_count + 1;
end

if (exp_opnd1_r === opnd1_r || exp_opnd1_r === 32'bx) begin
  $display("TBGEN-PASS decode_opnds:%0d opnd1_r", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opnds:%0d expected opnd1_r to be 0x%h, was 0x%h", current_vec, exp_opnd1_r, opnd1_r);
  error_count = error_count + 1;
end

if (exp_opnd2_r === opnd2_r || exp_opnd2_r === 32'bx) begin
  $display("TBGEN-PASS decode_opnds:%0d opnd2_r", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opnds:%0d expected opnd2_r to be 0x%h, was 0x%h", current_vec, exp_opnd2_r, opnd2_r);
  error_count = error_count + 1;
end

if (exp_dest0_kind === dest0_kind || exp_dest0_kind === 2'bx) begin
  $display("TBGEN-PASS decode_opnds:%0d dest0_kind", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opnds:%0d expected dest0_kind to be 0x%h, was 0x%h", current_vec, exp_dest0_kind, dest0_kind);
  error_count = error_count + 1;
end

if (exp_dest1_kind === dest1_kind || exp_dest1_kind === 2'bx) begin
  $display("TBGEN-PASS decode_opnds:%0d dest1_kind", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opnds:%0d expected dest1_kind to be 0x%h, was 0x%h", current_vec, exp_dest1_kind, dest1_kind);
  error_count = error_count + 1;
end

if (exp_dest0_sel === dest0_sel || exp_dest0_sel === 32'bx) begin
  $display("TBGEN-PASS decode_opnds:%0d dest0_sel", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opnds:%0d expected dest0_sel to be 0x%h, was 0x%h", current_vec, exp_dest0_sel, dest0_sel);
  error_count = error_count + 1;
end

if (exp_dest1_sel === dest1_sel || exp_dest1_sel === 32'bx) begin
  $display("TBGEN-PASS decode_opnds:%0d dest1_sel", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opnds:%0d expected dest1_sel to be 0x%h, was 0x%h", current_vec, exp_dest1_sel, dest1_sel);
  error_count = error_count + 1;
end

      current_vec = current_vec + 1;

      if (test_vectors[current_vec] === 507'bx) begin
        $display("TBGEN-DONE decode_opnds %0d errors=%0d", current_vec, error_count);
        $finish;
      end
    end
  end
endmodule
