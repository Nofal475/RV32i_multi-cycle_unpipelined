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


module B(
input rst,clk,[31:0]read_data_2,
output reg [31:0]Bread_data_2
    );
    
    always @ (posedge clk or negedge rst) begin
     if (!rst)
      Bread_data_2 <= 0;
      else
      Bread_data_2 <= read_data_2; 
    end
    
endmodule
