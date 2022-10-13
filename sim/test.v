`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2022 04:04:50 AM
// Design Name: 
// Module Name: test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test();

reg clk,rst;
reg [5:0]no_instruct;
wire eof;
RV32i_multi t1(clk,rst,no_instruct,eof
);

initial begin
clk=1;
forever
#10 clk=~clk;
end
    
initial begin
     rst = 1;
#10 rst =0; no_instruct=5;
#10 rst = 1;
end

endmodule

