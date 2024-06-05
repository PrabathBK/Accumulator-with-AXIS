module top_level #(parameter w = 3, 
parameter CLOCKS_PER_PULSE = 4, 
parameter BIT_PER_WORD = 7, 
parameter W_OUT = 14) (
    input logic clk,
    input logic rstn,
    input logic rx
);
    // Signals for UART RX
    logic m_valid;
    logic [W_OUT-1:0] m_data;

    // Signals for count_sum
    logic incr;
    logic [w-1:0] s_data;
    logic [2*w:0] sum;
    logic [1:0][6:0] m_data_sum;

    // Instantiate UART RX
    uart_rx #(
        .CLOCKS_PER_PULSE(CLOCKS_PER_PULSE),
        .BIT_PER_WORD(BIT_PER_WORD),
        .W_OUT(W_OUT)
    ) uart_rx_inst (
        .clk(clk),
        .rstn(rstn),
        .rx(rx),
        .m_valid(m_valid),
        .m_data(m_data)
    );

    // Instantiate count_sum
    count_sum #(.w(w)) count_sum_inst (
        .clk(clk),
        .rstn(rstn),
        .incr(m_valid),  // Use m_valid as incr signal
        .s_data(m_data[w-1:0]),  // Use the appropriate width part of m_data
        .sum(sum),
        .m_data(m_data_sum)
    );

endmodule
