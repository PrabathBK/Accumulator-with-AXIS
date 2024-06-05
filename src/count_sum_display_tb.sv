module count_sum_tb;

timeunit 1ns/1ps;

localparam w=3,CLK_PERIOD= 10;

logic [w-1:0] s_data;
logic clk=0, rstn=0;
logic [2*w:0] sum; 
initial forever #(CLK_PERIOD/2) clk <= !clk;
logic incr;
logic [1:0][6:0] m_data;

count_sum #(.w(w)) dut (.*);

initial begin
    $dumpfile("dump.vcd"); $dumpvars;
     // Initial reset
    rstn = 0;
    s_data = 'd0;

    // Deassert reset
    repeat(2) @(posedge clk);
    rstn = 1;
    incr =1;

    // Apply stimulus
    #10 s_data = 'd2;
    #10 s_data = 'd5;
    #10 s_data = 'd3;
    #10 s_data = 'd1;
    $finish();
end
endmodule