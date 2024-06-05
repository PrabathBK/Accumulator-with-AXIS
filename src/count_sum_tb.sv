
`timescale 1ns/1ps
module count_sum_tb;


    localparam w=3,N=5,CLK_PERIOD= 10;
    logic clk=0, rstn=0;
    logic s_valid=1, m_ready=0;
    logic [w-1:0] s_data;
    logic m_valid, s_ready;
    logic [1:0][6:0] m_data;
    logic [2*w:0] sum;
    logic [3:0] count;
    logic [6:0] ones, tens;

    initial forever #(CLK_PERIOD/2) clk <= !clk;

    count_sum #(.w(w), .N(N)) dut (.*);


    initial begin
        #10 rstn <= 0;
        #10 begin
            s_valid <= 1;
            s_ready <=1 ;
            count=0;
            sum=0;
           end
         #10 rstn<=1;
         #10 s_data<='d3;
         #10 s_data<='d4;
         #10 s_data<='d5;
         #10 s_data<='d2;
         #10 s_data<='d6;
         #10 s_data<='d1;
           
         
           
           
          end
//        m_ready <= 0; // Initially ready to accept output
//        s_data <= 0;
//        sum<=0;
//        count<=0;
//        ones <= 0;
//        tens <=0;
//        #(CLK_PERIOD*2) rstn <= 1;
//        #10 begin
//             s_valid <= 1;
//             s_ready <=1 ;
//        end


//        // Apply inputs
//        send_data(3);
//        send_data(5);
//        send_data(6);
//        send_data(7);
//        send_data(1);

//        // Wait for output to be valid
//        wait(m_valid);
        
//        // Check output
//        // Sum of inputs: 3 + 5 + 6 + 7 + 1 = 22
//        // Ones place: 2 (7-segment code for 2 is 7'b1011011)
//        // Tens place: 2 (7-segment code for 2 is 7'b1011011)
//        assert(m_data[0] == 7'b1011011) else $fatal("Ones place incorrect: %b", m_data[0]); // 2 in 7-segment
//        assert(m_data[1] == 7'b1011011) else $fatal("Tens place incorrect: %b", m_data[1]); // 2 in 7-segment

//        $display("Test passed!");
//        $finish;
   
//  end
//    // Task to send data with proper timing
//    task send_data(input [w-1:0] data);
//        begin
//            s_data = data;
//            s_valid = 1;
//            @(posedge clk); // Wait for a clock cycle
//            #1;
//            s_valid = 0;
//            @(posedge clk); // Ensure the data is processed
//        end
//    endtask
   








endmodule