module count_sum #(parameter w = 3, parameter N = 5) (
    input  logic clk, rstn,
    input  logic s_valid, m_ready,
    input  logic [w-1:0] s_data,
    output logic m_valid, s_ready,
    output logic [1:0][6:0] m_data
);
    logic [2*w:0] sum;
    logic [3:0] count;
    logic [6:0] ones, tens;

    // State Machine States
    typedef enum logic [1:0] {
        IDLE,
        ACCUMULATE,
//        CONVERT,
        OUTPUT
    } state_t;

    state_t state, next_state;

    // State Machine
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                if (s_valid && s_ready) begin
                    next_state = ACCUMULATE;
                end
            end
            ACCUMULATE: begin
                if (count == N) begin
                    next_state = OUTPUT;
                end else if (s_valid && s_ready) begin
                    next_state = ACCUMULATE;
                end
            end
//            CONVERT: begin
//                next_state = OUTPUT;
//            end
            OUTPUT: begin
                if (m_ready || m_valid ) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Logic for Accumulation and Sum Calculation
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            sum <= 0;
            count <= 0;
        end else if (state == ACCUMULATE && s_valid && s_ready) begin
            sum <= sum + s_data;
            ones <= sum % 10;
            tens <= sum / 10;
            if(m_ready)begin
            m_data[0] <= convert_to_7segment(ones);
            m_data[1] <= convert_to_7segment(tens);
            end
            count <= count + 1;
        end else if (state == OUTPUT) begin
            sum <= 0; // Maintain sum value during conversion
            count <= 0; // Reset count for next accumulation
//            s_valid <=0; 
            s_ready <=0;

        end
    end


   always_ff @(posedge clk or negedge rstn) begin
       if (!rstn) begin
           sum <= 0;
           count <= 0;
       end else if (state == IDLE) begin
            count <=0;
            sum <=0;
//            s_valid <=0;
            s_ready <=1;
            m_valid <=0;
//            m_ready <=0;
       end
   end



    // AXI Stream Handshaking
    assign s_ready = (state == IDLE) || (state == ACCUMULATE);
    assign s_valid = ~(m_valid && ~(m_ready));
    assign m_valid = (state == OUTPUT || count == (N));

    // Function to convert digit to 7-segment encoding
    function [6:0] convert_to_7segment;
        input [3:0] digit;
        case (digit)
            4'd0: convert_to_7segment = 7'b0111111;
            4'd1: convert_to_7segment = 7'b0000110;
            4'd2: convert_to_7segment = 7'b1011011;
            4'd3: convert_to_7segment = 7'b1001111;
            4'd4: convert_to_7segment = 7'b1100110;
            4'd5: convert_to_7segment = 7'b1101101;
            4'd6: convert_to_7segment = 7'b1111101;
            4'd7: convert_to_7segment = 7'b0000111;
            4'd8: convert_to_7segment = 7'b1111111;
            4'd9: convert_to_7segment = 7'b1101111;
            default: convert_to_7segment = 7'b0000000;
        endcase
    endfunction
endmodule

