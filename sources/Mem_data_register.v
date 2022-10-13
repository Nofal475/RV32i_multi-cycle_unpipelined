`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2022 05:31:08 AM
// Design Name: 
// Module Name: Memory
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


module Mem_data_register(
input rst,clk,[31:0]mem_data,
output reg [31:0]mem_data_out
    );
    
    always @ (posedge clk or negedge rst) begin
     if (!rst)
      mem_data_out <= 0;
      else
      mem_data_out <= mem_data; 
    end
    
endmodule
