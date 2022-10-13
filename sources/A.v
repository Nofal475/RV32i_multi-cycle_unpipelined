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


module A(
input rst,clk,[31:0]read_data_1,
output reg [31:0]Aread_data_1
    );
    
    always @ (posedge clk or negedge rst) begin
     if (!rst)
      Aread_data_1 <= 0;
      else
      Aread_data_1 <= read_data_1; 
    end
    
endmodule
