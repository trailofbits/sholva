module jack_tb();

reg clk;
reg [31:0] current_vec;
reg [2806:0] test_vectors [5:0];

reg [2806:0] current, next;
wire [0:0] result, dummy;

circuit dut(
    .current(current),
    .next(next),
    .result(result),
    .dummy(dummy)
);

always
begin
    clk = 1; #5; clk = 0; #5;
end

initial
begin
    $dumpfile("jack.tb.vcd");
    $dumpvars(0, jack_tb);
    $readmemb("jack.trace.txt", test_vectors);
    current_vec = 0;
end

always @(posedge clk)
begin
    #1; current = test_vectors[current_vec]; next = test_vectors[current_vec + 1];
end

always @(negedge clk) begin
    if (result === 1'b1) begin
        $display("TBGEN-PASS circuit:%0d result", result);
    end else begin
        $display("TBGEN-PASS circuit:%0d result", result);
    end

    current_vec = current_vec + 1;

    if (test_vectors[current_vec + 1] === 2807'bx) begin
        $display("TBGEN-DONE circuit %0d", current_vec);
        $finish;
    end
end

endmodule
