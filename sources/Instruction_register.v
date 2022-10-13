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


module Instruction_register(
input rst,clk,IRwrite,[31:0]mem_data,
output reg [6:0]instruction6_0,
output reg [4:0]instruction19_15,
output reg [4:0]instruction24_20,
output reg [4:0]instruction11_7,
output reg [31:0]instruction31_0
    );
    
    always @ (posedge clk or negedge rst) begin
     if (!rst) begin
      instruction6_0 <= 0;
      instruction19_15 <= 0;
      instruction24_20 <= 0;
      instruction11_7 <= 0;
      instruction31_0 <= 0;
      end 
      else if (IRwrite) begin
      instruction6_0 <= mem_data[6:0];
      instruction19_15 <= mem_data[19:15];
      instruction24_20 <= mem_data[24:20];
      instruction11_7 <= mem_data[11:7];
      instruction31_0 <= mem_data[31:0];
    end
    end
     
endmodule
