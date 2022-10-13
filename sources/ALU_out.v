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


module ALU_out(
input rst,clk,[31:0]result_alu,
output reg [31:0]alu_out
    );
    
    always @ (posedge clk or negedge rst) begin
     if (!rst)
      alu_out <= 0;
      else
      alu_out <= result_alu; 
    end
    
endmodule
