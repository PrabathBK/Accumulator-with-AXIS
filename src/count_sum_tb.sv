
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
            s_valid <= 0;
//            s_ready <=1 ;
            s_data <= 'd0;
            count=0;
            sum=0;
           end
         #10 begin
         rstn<=1;
         m_ready <=1;
         m_valid <=1;
         end
         
         #10 begin
//         s_ready <=1;
         s_valid <=1;
         end
         
         #10 s_data<='d3;
         #10 s_data<='d4;
         #10 s_data<='d5;
         #10 s_data<='d2;
         #10 begin
         s_data<='d6;
//         s_valid <=0;
         end
         #10 s_data<='d0;
         #10 s_valid <=0;
     
         #10 s_data<='d1;
                 // Wait for output to be valid
        wait(m_valid);
    



         
         repeat(5)  @(posedge clk) #1;
           
          end




endmodule