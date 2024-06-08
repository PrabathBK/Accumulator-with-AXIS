`timescale 1ns/1ps
module SSAccumulator_tb;
localparam WIDTH=3, NO_OF_STEPS=4,CLK_PERIOD=10;
logic clk=0,rstn=0;
logic [WIDTH-1:0] s_data;
logic [1:0][7-1:0] m_data;

initial forever #(CLK_PERIOD/2) clk <= !clk;

SSAccumulator #(.WIDTH(WIDTH), .NO_OF_STEPS(NO_OF_STEPS)) dut (.*);

initial begin
    repeat(2) @(posedge clk);
    #1 rstn <= 1;

    for (int i=0;i < NO_OF_STEPS;i++) begin
//        s_data <= $urandom_range(0,2**(WIDTH)-1);
        s_data <= i;
        @(posedge clk) #1;
    end
    s_data <=0;
    repeat(5)   @(posedge clk);
    $finish();


end
endmodule
