module tb;

wire [7:0] result;
wire done;
reg clk,rst,start;
reg [3:0] Q,M;

topmodule DUT(.clk(clk), .rst(rst), .start(start), .Q(Q), .M(M)
,.result(result), .done_top(done));

initial clk=0;
always #10 clk=~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0,tb);
    $monitor("Rst=%b  |  Start=%b  |  Q=%b  |  M=%b  | Done=%b  | Result=%b",rst,start,Q,M,done,result);
    rst=1;start=0;
    #20 rst=0;Q=4'b0011;M=4'b1010;
    #20 start=1;
    #20 start=0;
    #500
    $display("\nFinal Result: %b (decimal: %d)", result, result);
    $display("Expected: 3 × 3 = 9 = 00001001");
    $finish; 
    $finish;
end

endmodule