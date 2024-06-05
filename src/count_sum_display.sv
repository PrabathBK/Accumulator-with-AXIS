module count_sum #(w=3)( 
    input  logic clk, rstn,incr,
    input logic [w-1:0] s_data,//[N-1:0][w-1:0] s_data,
    output logic [2*w:0] sum,
    output logic [1:0][6:0] m_data
);
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            sum <= 0;
            m_data[0] <= 0;
            m_data[1] <= 0;
        end
        else if (incr) begin
            sum <= sum + s_data;
            m_data[0] <= sum % 10;
            m_data[1] <= sum / 10;
        end
    end
endmodule