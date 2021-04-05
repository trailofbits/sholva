// 64 bits one-hot decoder
function [63:0] one_hot64;
   input  [5:0] binary;
   begin
      one_hot64         = 64'h0000_0000_0000_0000;
      one_hot64[binary] =  1'b1;
   end
endfunction

function [7:0] one_hot8;
  input [2:0] binary;
  begin
    one_hot8 = 8'h00;
    one_hot8[binary] = 1'b1;
  end
endfunction
