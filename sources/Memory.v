`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2022 06:06:09 AM
// Design Name: 
// Module Name: data_memory
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


module Memory(
input clk,rst,mem_write,mem_read,
input [31:0]address,[31:0]data_in,
output reg [31:0]data_out
);

 reg [7:0]data_mem[0:512];   
initial $readmemh("RV32imem.mem", data_mem); 
   
   
    always @ (*) begin  //read block
    if (mem_read)
    data_out <= {data_mem[address],data_mem[address+1],data_mem[address+2],data_mem[address+3]};
    end
    
    always @ (posedge clk) begin  //write block
    if (mem_write)
    data_mem[address] <= data_in; 
    else
     data_mem[address] <=  data_mem[address];  // 9 down zero as only 512 rows in mem
    end
    
endmodule
