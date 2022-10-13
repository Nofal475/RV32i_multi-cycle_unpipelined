`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2022 06:07:05 AM
// Design Name: 
// Module Name: registers
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


module Registers(
input rst,clk,reg_write,
input [4:0]read_reg1,read_reg2,write_address,
input [31:0]write_data,
output [31:0]read_data1,read_data2
);
reg [31:0]registers[0:31];

assign read_data1 = registers[read_reg1];
assign read_data2 = registers[read_reg2];

integer i;
always @ (posedge clk  or negedge rst)begin
if (!rst) begin
for (i=0;i<32;i=i+1)
  registers[i] <= 0;
end 
else if (reg_write)
 registers[write_address] <= write_data;
end 




endmodule