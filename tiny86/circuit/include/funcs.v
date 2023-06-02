// 64 bit one-hot decoder
function [63:0] one_hot64;
  input [5:0] binary;
  begin
    one_hot64         = 64'h0000_0000_0000_0000;
    one_hot64[binary] = 1'b1;
  end
endfunction

// 128 bit one-hot decoder
function [127:0] one_hot128;
  input [6:0] binary;
  begin
    one_hot128         = 128'h0000_0000_0000_0000_0000_0000_0000_0000;
    one_hot128[binary] = 1'b1;
  end
endfunction

function [7:0] one_hot8;
  input [2:0] binary;
  begin
    one_hot8 = 8'h00;
    one_hot8[binary] = 1'b1;
  end
endfunction

function [15:0] one_hot16;
  input [3:0] binary;
  begin
    one_hot16 = 16'h0000;
    one_hot16[binary] = 1'b1;
  end
endfunction

function [31:0] sext8_32;
  input [7:0] x;
  begin
    sext8_32 = {{24{x[7]}}, x};
  end
endfunction

function [31:0] sext16_32;
  input [15:0] x;
  begin
    sext16_32 = {{{16{x[15]}}}, x};
  end
endfunction

function [31:0] zext8_32;
  input [7:0] x;
  begin
    zext8_32 = {{24{1'b0}}, x};
  end
endfunction

function [31:0] zext16_32;
  input [15:0] x;
  begin
    zext16_32 = {{{16{1'b0}}}, x};
  end
endfunction

function [31:0] swap_endian;
  input [31:0] x;
  begin
    swap_endian = {x[7:0], x[15:8], x[23:16], x[31:24]};
  end
endfunction

function [31:0] long_regsel;
  input [2:0] regsel;
  begin
    long_regsel = {29'b0, regsel};
  end
endfunction
