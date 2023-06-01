// 8-way 32-bit multiplexor.
`default_nettype none

module mux8_32 (
    input [ 2:0] sel,
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [31:0] in4,
    input [31:0] in5,
    input [31:0] in6,
    input [31:0] in7,

    output [31:0] out
);

  assign out = (sel == 3'd0) ? in0 :
             (sel == 3'd1) ? in1 :
             (sel == 3'd2) ? in2 :
             (sel == 3'd3) ? in3 :
             (sel == 3'd4) ? in4 :
             (sel == 3'd5) ? in5 :
             (sel == 3'd6) ? in6 : in7;

endmodule
