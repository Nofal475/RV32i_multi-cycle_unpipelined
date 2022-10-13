`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2022 06:06:39 AM
// Design Name: 
// Module Name: program_counter
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


module program_counter(
input clk,rst,next_instruct,[31:0]address_new,
input [5:0]no_instruct,
output reg eof,
output reg [31:0]address
    );
    reg [5:0]c;
    
    always @ (posedge next_instruct or negedge rst)
    begin
    if (!rst) c<=0;
    else 
    c <= c+1;
    end
    
     always @ (posedge clk  or negedge rst) //next instruction
    begin
    if(!rst)begin
    address <= 0;   eof<=0;  
    end
    else if (c  == (no_instruct + 1)) begin
    eof<=1; end
    else if (next_instruct) 
     begin
   address <= address_new; eof<=0; 
    end
    else 
     begin
    address <= address; eof<=0;end
    end
endmodule
