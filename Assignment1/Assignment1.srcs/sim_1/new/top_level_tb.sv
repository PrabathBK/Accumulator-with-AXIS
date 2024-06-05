`timescale 1ns / 1ps

module top_level_tb;

    localparam w = 3;
    localparam CLOCKS_PER_PULSE = 4;
    localparam BIT_PER_WORD = 7;
    localparam W_OUT = 14;
    localparam CLK_PERIOD = 10;
    
    logic clk = 0;
    logic rstn = 0;
    logic rx;
    
    initial forever #(CLK_PERIOD / 2) clk = ~clk;

    top_level #(
        .w(w),
        .CLOCKS_PER_PULSE(CLOCKS_PER_PULSE),
        .BIT_PER_WORD(BIT_PER_WORD),
        .W_OUT(W_OUT)
    ) dut (
        .clk(clk),
        .rstn(rstn),
        .rx(rx)
    );
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, top_level_tb);

        // Initial reset
        rstn = 0;
        rx = 1;
        #20 rstn = 1;

        // Send data through UART RX
        #30 rx = 0;  // Start bit
        #40 rx = 1;  // Data bit 0
        #40 rx = 0;  // Data bit 1
        #40 rx = 1;  // Data bit 2
        #40 rx = 1;  // Data bit 3
        #40 rx = 0;  // Data bit 4
        #40 rx = 1;  // Data bit 5
        #40 rx = 0;  // Data bit 6
        #40 rx = 1;  // Stop bit

        // Additional delay to observe behavior
        #200;
        $finish();
    end
    


endmodule
