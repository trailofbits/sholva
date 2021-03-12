module decode_regfile(
  input [319:0] raw_regs,

  output [31:0] eax,
  output [31:0] ebx,
  output [31:0] ecx,
  output [31:0] edx,
  output [31:0] esi,
  output [31:0] edi,
  output [31:0] esp,
  output [31:0] ebp,
  output [31:0] eip,
  output [31:0] eflags
);

assign {eax, ebx, ecx, edx, esi, edi, esp, ebp, eip, eflags} = raw_regs;

endmodule
