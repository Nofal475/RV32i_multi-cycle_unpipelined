`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2022 01:42:40 AM
// Design Name: 
// Module Name: Imm_gen
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


module Imm_gen(
input rst,clk,[31:0]instruction,
output reg [31:0]imm_gen
);

always @ (posedge clk  or negedge rst)
begin
 if (!rst)
   imm_gen <= {32{1'b0}}; 
 else begin
  case (instruction[6:0])
   7'b0110011 : imm_gen <= {32{1'bx}};  // R Format REGISTERS
   7'b0000011 : begin imm_gen[31:11] <= {21{instruction[31]}}; // I Format LOAD
                      imm_gen[10:5] <= instruction[30:25];
                      imm_gen[4:1] <= instruction[24:21];
                      imm_gen[0] <= instruction[20];
                  end 
   7'b0010011 : begin imm_gen[31:11] <= {21{instruction[31]}}; // I Format ADDI ORI XORI ANDI SRI SLI
                      imm_gen[10:5] <= instruction[30:25];
                      imm_gen[4:1] <= instruction[24:21];
                      imm_gen[0] <= instruction[20];
                  end    
 /*  7'b1100111 : begin imm_gen[31:11] <= {21{instruction[31]}}; // I Format JALR
                      imm_gen[10:5] <= instruction[30:25];
                      imm_gen[4:1] <= instruction[24:21];
                      imm_gen[0] <= instruction[20];
                  end    
   7'b1110011 : begin imm_gen[31:11] <= {21{instruction[31]}}; // I Format CRR
                      imm_gen[10:5] <= instruction[30:25];
                      imm_gen[4:1] <= instruction[24:21];
                      imm_gen[0] <= instruction[20];
                  end */   
   7'b0100011 : begin imm_gen[31:11] <= {21{instruction[31]}}; // S FormaT STORE
                      imm_gen[10:5] <= instruction[30:25];
                      imm_gen[4:1] <= instruction[11:8];
                      imm_gen[0] <= instruction[7];
                  end 
   7'b1100011 : begin imm_gen[31:12] <= {20{instruction[31]}}; // SB FormaT BRANCH
                      imm_gen[11] <= instruction[7];
                      imm_gen[10:5] <= instruction[30:25];
                      imm_gen[4:1] <= instruction[11:8];
                      imm_gen[0] <= instruction[0];
                  end
    7'b0110111 : begin imm_gen[31] <= instruction[31]; // U FormaT LUI
                       imm_gen[30:20] <= instruction[30:20];
                       imm_gen[19:12] <= instruction[19:12];
                       imm_gen[11:0] <= 0;
                  end 
    7'b0010111 : begin imm_gen[31] <= instruction[31]; // U FormaT AUIPC
                       imm_gen[30:20] <= instruction[30:20];
                       imm_gen[19:12] <= instruction[19:12];
                       imm_gen[11:0] <= 0;
                  end
    7'b1101111 : begin imm_gen[31:20] <= {12{instruction[31]}}; // UJ FormaT JAL
                       imm_gen[19:12] <= instruction[19:12];
                       imm_gen[10:5] <= instruction[30:25];
                       imm_gen[4:1] <= instruction[24:21];
                       imm_gen[11:0] <= 0;
                  end        
    default : imm_gen[31:0] = imm_gen[31:20];                                                                           
  endcase
  end
end

endmodule