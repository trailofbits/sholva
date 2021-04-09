// this file was generated by ./codegen/tbgen on 2021-04-09 15:26:01 -0400
// do NOT edit it by hand
module decode_opc_phase2_tb();
reg clk, reset;
reg [31:0] current_vec, error_count;
reg [86:0] test_vectors [127:0];
reg [71:0] unescaped_instr;
reg [0:0] is_2byte;
reg [5:0] exp_opc;
wire [5:0] opc;
reg [3:0] exp_opnd_form;
wire [3:0] opnd_form;
reg [1:0] exp_opnd_count;
wire [1:0] opnd_count;
reg [0:0] exp_imm_1byte;
wire [0:0] imm_1byte;
reg [0:0] exp_reg_1byte;
wire [0:0] reg_1byte;
decode_opc_phase2 dut(
.unescaped_instr(unescaped_instr),
.is_2byte(is_2byte),
.opc(opc),
.opnd_form(opnd_form),
.opnd_count(opnd_count),
.imm_1byte(imm_1byte),
.reg_1byte(reg_1byte)
);
always
  begin
    clk = 1; #5; clk = 0; #5;
  end
initial
  begin
    $dumpfile("decode_opc_phase2.tb.vcd");
    $dumpvars(0, decode_opc_phase2_tb);
    $readmemb("decode_opc_phase2.tv", test_vectors);
    current_vec = 0; error_count = 0;
    reset = 1; #10; reset = 0;
  end
always @(posedge clk)
  begin
    #1; { unescaped_instr, is_2byte, exp_opc, exp_opnd_form, exp_opnd_count, exp_imm_1byte, exp_reg_1byte } = test_vectors[current_vec];
  end
always @(negedge clk)
  begin
    if (~reset) begin
      if (exp_opc === opc || exp_opc === 6'bx) begin
  $display("TBGEN-PASS decode_opc_phase2:%0d opc", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opc_phase2:%0d expected opc to be 0x%h, was 0x%h", current_vec, exp_opc, opc);
  error_count = error_count + 1;
end

if (exp_opnd_form === opnd_form || exp_opnd_form === 4'bx) begin
  $display("TBGEN-PASS decode_opc_phase2:%0d opnd_form", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opc_phase2:%0d expected opnd_form to be 0x%h, was 0x%h", current_vec, exp_opnd_form, opnd_form);
  error_count = error_count + 1;
end

if (exp_opnd_count === opnd_count || exp_opnd_count === 2'bx) begin
  $display("TBGEN-PASS decode_opc_phase2:%0d opnd_count", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opc_phase2:%0d expected opnd_count to be 0x%h, was 0x%h", current_vec, exp_opnd_count, opnd_count);
  error_count = error_count + 1;
end

if (exp_imm_1byte === imm_1byte || exp_imm_1byte === 1'bx) begin
  $display("TBGEN-PASS decode_opc_phase2:%0d imm_1byte", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opc_phase2:%0d expected imm_1byte to be 0x%h, was 0x%h", current_vec, exp_imm_1byte, imm_1byte);
  error_count = error_count + 1;
end

if (exp_reg_1byte === reg_1byte || exp_reg_1byte === 1'bx) begin
  $display("TBGEN-PASS decode_opc_phase2:%0d reg_1byte", current_vec);
end else begin
  $display("TBGEN-FAIL decode_opc_phase2:%0d expected reg_1byte to be 0x%h, was 0x%h", current_vec, exp_reg_1byte, reg_1byte);
  error_count = error_count + 1;
end

      current_vec = current_vec + 1;

      if (test_vectors[current_vec] === 87'bx) begin
        $display("TBGEN-DONE decode_opc_phase2 %0d errors=%0d", current_vec, error_count);
        $finish;
      end
    end
  end
endmodule
