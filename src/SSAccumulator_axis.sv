module SSAccumulator_axis #(parameter WIDTH=3, NO_OF_STEPS=10)(
    input logic clk,rstn,
    input logic s_valid,
    output logic s_ready,
    input logic [WIDTH-1:0] s_data,
    input logic m_ready,
    output logic m_valid,
    output logic [1:0][7-1:0] m_data

);

//counter
logic [$clog2(NO_OF_STEPS)-1:0] count,count_next;

assign count_next=(count== NO_OF_STEPS-1)?  0 : count+1; //Eqaul to always_comb (=)
    // always_ff @( posedge clk or negedge rstn )
    // if (~rstn) count <='0;
    // else if(count== NO_OF_STEPS-1) count <= '0;
    //         else count <= count + 1;
logic stop,en;
assign stop= (m_valid && !m_ready)? 1:0;
assign en = ~stop;

always_ff @( posedge clk or negedge rstn )
    if (~rstn)                  count <='0;
    else if (en && s_valid)     count <= count_next;
     

//Accumulator
localparam W_SUM =WIDTH + $clog2(NO_OF_STEPS) ;
logic [W_SUM-1:0] sum;

// always_ff @( posedge clk or negedge rstn )
//     if (~rstn)          sum <=0;
//     else if (count ==0) sum <= s_data;
//     else                sum <= sum + s_data; //Both are same and correct

always_ff @( posedge clk  ) //when reset the count =0 then we do not need extra step to reset in both fliflpos
if (en)
    if      (count ==0)   sum <= s_data;
    else if (s_valid)     sum <= sum + s_data; //Unsigned addition


//Display parts
logic [$clog2(10)-1:0] ones,tens;
assign ones = sum %10;
assign tens = sum /10;

//seven segmnent display
//   size of each           No of values(arrays) or Number of rows in the table(Address)
logic [7-1:0] seven_segment_LUT [0:9] = {
    //gfe_dcba
    7'b011_1111, //0
    7'b010_0110, //1
    7'b101_1011, //2
    7'b100_1111, //3
    7'b110_0110, //4
    7'b110_1101, //5
    7'b111_1101, //6
    7'b000_0111, //7
    7'b111_1111, //8
    7'b110_1111 //9
    
};

assign m_data ={ seven_segment_LUT[tens],seven_segment_LUT[ones]};

/*
count next  :   1,  2,  3,  0,  1
count       :   0,  1,  2,  3,  0
s_data      :   2,  1,  7,  2,
sum         :   x,  2,  3,  10, 12
m_valid     :                   1  //when count ==3 then next clock cycle m_valid should be high
m_ready     :   1,  1,  1,  1,  0

*/


//In axis we have 2 outputs. m_valid and s_ready

// 1. m_valid 
always_ff @(posedge clk or negedge rstn) begin
    if      (~rstn              )   m_valid <= 0;
    else if (m_ready || !m_valid)   m_valid <= (count == NO_OF_STEPS -1);

end

// 2. s_ready
assign s_ready = en;






endmodule