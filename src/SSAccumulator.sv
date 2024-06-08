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


endmodule