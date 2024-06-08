module SSAccumulator #(parameter WIDTH=3, NO_OF_STEPS=10)(
    input logic clk,rstn,
    input logic [WIDTH-1:0] s_data,
    output logic [1:0][7-1:0] m_data

);

//counter
logic [$clog2(NO_OF_STEPS)-1:0] count,count_next;

assign count_next=(count== NO_OF_STEPS-1)?  0 : count+1; //Eqaul to always_comb (=)
    // always_ff @( posedge clk or negedge rstn )
    // if (~rstn) count <='0;
    // else if(count== NO_OF_STEPS-1) count <= '0;
    //         else count <= count + 1;

always_ff @( posedge clk or negedge rstn )
    if (~rstn)  count <='0;
    else        count <= count_next;
     

//Accumulator
localparam W_SUM =w+ $clog2(NO_OF_STEPS) ;
logic [W_SUM-1:0] sum;

// always_ff @( posedge clk or negedge rstn )
//     if (~rstn)          sum <=0;
//     else if (count ==0) sum <= s_data;
//     else                sum <= sum + s_data; //Both are same and correct

always_ff @( posedge clk  ) //when reset the count =0 then we do not need extra step to reset in both fliflpos
    if (count ==0) sum <= s_data;
    else                sum <= sum + s_data; //Unsigned addition


//Display parts
logic [$clog2(10)-1:0] ones,tens;
assign ones = sum %10;
assign tens = sum /10;

//seven segmnent display
//   size of each           No of values(arrays) or Number of rows in the table(Address)
logic [7-1:0] seven_segment_LUT [0:9] = '{
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
    7'b110_1111, //9
    
};



endmodule