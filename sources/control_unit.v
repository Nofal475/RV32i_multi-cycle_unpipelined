`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2022 02:56:54 AM
// Design Name: 
// Module Name: control_unit
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


module control_unit(
input clk,rst,eof,zero,[6:0]opcode,
output reg IorD,mem_write,mem_read,IRwrite,MemtoReg,reg_write,ALUSrcA,PCSource,PCwrite,PCwriteCondition,
output reg [1:0]ALUSrcB,
output reg [1:0]ALU_op
    );
     
reg [4:0]current_state;
reg [4:0]next_state;
parameter idle = 4'b1010,state_0 = 4'b0000,state_1 = 4'b0001,state_2 = 4'b0010,state_3 = 4'b0011,
       state_4 = 4'b0100,state_5 = 4'b0101,state_6 = 4'b0110,state_7 = 4'b0111,state_8 = 4'b1000,state_9 = 4'b1001;

 always @ (posedge clk or negedge rst) begin  //state register
  if (!rst || eof)
     current_state <= idle;
  else
     current_state <= next_state;  
 end
 
 always @ (posedge clk or negedge rst) begin //state transition block   using clock_cycle for transitioning rather than current_state and input
   if (!rst || eof)
    next_state <= idle;
    else begin
    case (current_state)
     idle : next_state <= state_0;
     state_0 : begin next_state <= state_1; end
     state_1 :  case(opcode)
                7'b0100011 :// (Op = 'Load') or (Op = 'Store') || 7'b0010011 || 7'b0110111: // or (Op = 'I-imm')or (Op = 'LUI')
                next_state <= state_2;
                7'b0000011 : next_state <= state_2;
                7'b0010011 : next_state <= state_9;   // for i immediate
                7'b0110011 : next_state <= state_6;  //(Op = 'R')
                7'b1100011 : next_state <= state_8;  // (Op = 'Branch SB')
                default : next_state <= next_state;            
                endcase
     state_2 : case(opcode)   
               7'b0000011 : next_state <= state_3;// load
               7'b0100011 : next_state <= state_5;// store
               default : next_state <= next_state; 
               endcase 
     state_3 :  next_state <= state_4;
     state_4 :  next_state <= state_0;         
     state_5 :  next_state <= state_0;         
     state_6 :  next_state <= state_7;         
     state_7 :  next_state <= state_0;         
     state_8 :  next_state <= state_0;
     state_9 :  next_state <= state_7;         
    endcase     
    end 
 end
 
 always @ (current_state,zero) //output block
  begin
   case (zero)
       1'b1 :PCwriteCondition <= 1;
       1'b0 :PCwriteCondition <= 0;    
   endcase
   case (current_state)
   idle : begin IorD <= 0;mem_write <= 0;mem_read <= 0;IRwrite <= 0;MemtoReg <= 0;reg_write <= 0;ALUSrcA <= 0;PCSource <= 0;ALUSrcB <= 2'b00; end
   state_0 : begin ALU_op<=2'bxx;PCwrite <= 1;IorD <= 0;mem_write <= 0;mem_read <= 1;IRwrite <= 1;MemtoReg <= 0;reg_write <= 0;ALUSrcA <= 0;PCSource <= 0;ALUSrcB <= 2'b01; end
   state_1 : begin ALU_op<=2'bxx;PCwrite <= 0;IorD <= 0;mem_write <= 0;mem_read <= 1;IRwrite <= 1;MemtoReg <= 0;reg_write <= 0;ALUSrcA <= 0;PCSource <= 0;ALUSrcB <= 2'b01; end
   state_2 : begin ALU_op<=2'bxx;PCwrite <= 0;IorD <= 0;mem_write <= 0;mem_read <= 0;IRwrite <= 0;MemtoReg <= 0;reg_write <= 0;ALUSrcA <= 1;PCSource <= 0;ALUSrcB <= 2'b00; end
   state_3 : begin ALU_op<=2'b11;PCwrite <= 0;IorD <= 0;mem_write <= 0;mem_read <= 1;IRwrite <= 0;MemtoReg <= 1;reg_write <= 0;ALUSrcA <= 0;PCSource <= 0;ALUSrcB <= 0; end
   state_4 : begin ALU_op<=2'bxx;PCwrite <= 0;IorD <= 0;mem_write <= 0;mem_read <= 0;IRwrite <= 0;MemtoReg <= 1;reg_write <= 1;ALUSrcA <= 0;PCSource <= 0;ALUSrcB <= 0; end
   state_5 : begin ALU_op<=2'b10;PCwrite <= 0;IorD <= 0;mem_write <= 1;mem_read <= 0;IRwrite <= 0;MemtoReg <= 0;reg_write <= 0;ALUSrcA <= 0;PCSource <= 0;ALUSrcB <= 0; end
   state_6 : begin ALU_op<=2'b01;PCwrite <= 0;IorD <= 0;mem_write <= 0;mem_read <= 0;IRwrite <= 0;MemtoReg <= 0;reg_write <= 0;ALUSrcA <= 1;PCSource <= 0;ALUSrcB <= 0; end
   state_7 : begin ALU_op<=2'b01;PCwrite <= 0;IorD <= 0;mem_write <= 0;mem_read <= 0;IRwrite <= 0;MemtoReg <= 0;reg_write <= 1;ALUSrcA <= 1;PCSource <= 0;ALUSrcB <= 0; end
   state_8 : begin ALU_op<=2'b00;PCwrite <= 0;IorD <= 0;mem_write <= 0;mem_read <= 0;IRwrite <= 0;MemtoReg <= 0;reg_write <= 0;ALUSrcA <= 1;PCSource <= 1;ALUSrcB <= 2'b10; end
   state_9 : begin ALU_op<=2'b01;PCwrite <= 0;IorD <= 0;mem_write <= 0;mem_read <= 0;IRwrite <= 0;MemtoReg <= 0;reg_write <= 0;ALUSrcA <= 1;PCSource <= 0;ALUSrcB <= 2'b00; end
   endcase  
  end
     
     
   /* always @ (posedge clk)
    if (eof || rst) begin
     ALU_op<=4'bxxxx; branch<=1'b0;mem_read<=1'b0;mem_write<=1'b0;memto_reg<=1'bx;ALU_src<=1'bx;reg_write<=1'b0;
    end
     else begin
    case (opcode)
    7'b0110011 : begin ALU_op<=4'b0000; branch<=1'b0;mem_read<=1'b0;mem_write<=1'b0;memto_reg<=1'b0;ALU_src<=1'b0;reg_write<=1'b1;end //R Format REGISTERS
    7'b0000011 : begin ALU_op<=4'b0001; branch<=1'b0;mem_read<=1'b1;mem_write<=1'b0;memto_reg<=1'b1;ALU_src<=1'b1;reg_write<=1'b1;end //I Format LOAD
    7'b0010011 : begin ALU_op<=4'b0010; branch<=1'b0;mem_read<=1'b0;mem_write<=1'b0;memto_reg<=1'b0;ALU_src<=1'b1;reg_write<=1'b1;end // I Format ADDI ORI XORI ANDI SRI SLI
 // 7'b1100111 : begin ALU_op<=4'b0011; branch<=1'b1;mem_read<=1'b0;mem_write<=1'b0;memto_reg<=1'b0;ALU_src<=1'b1;reg_write<=1'b1;end // I Format JALR not incorporated in my design
 // 7'b1110011 : begin ALU_op<=4'b0100; branch<=1'b0;mem_read<=1'b0;mem_write<=1'b0;memto_reg<=1'b0;ALU_src<=1'b1;reg_write<=1'b1;end // I Format CRR not incorporated in my design
    7'b0100011 : begin ALU_op<=4'b0101; branch<=1'b0;mem_read<=1'b0;mem_write<=1'b1;memto_reg<=1'b0;ALU_src<=1'b1;reg_write<=1'b0;end // S FormaT STORE
    7'b1100011 : begin ALU_op<=4'b0110; branch<=1'b1;mem_read<=1'b0;mem_write<=1'b0;memto_reg<=1'b0;ALU_src<=1'b0;reg_write<=1'b0;end // SB FormaT BRANCH
    7'b0110111 : begin ALU_op<=4'b0111; branch<=1'b0;mem_read<=1'b0;mem_write<=1'b0;memto_reg<=1'b0;ALU_src<=1'b1;reg_write<=1'b1;end // U FormaT LUI
    7'b0010111 : begin ALU_op<=4'b1000; branch<=1'b0;mem_read<=1'b1;mem_write<=1'b0;memto_reg<=1'b0;ALU_src<=1'b1;reg_write<=1'b1;end // U FormaT AUIPC
    7'b1101111 : begin ALU_op<=4'b1001; branch<=1'b1;mem_read<=1'b0;mem_write<=1'b0;memto_reg<=1'b0;ALU_src<=1'b1;reg_write<=1'b1;end  // UJ FormaT JAL
    default : begin ALU_op<=ALU_op; branch<=branch;mem_read<=mem_read;mem_write<=mem_write;memto_reg<=memto_reg;ALU_src<=ALU_src;reg_write<=reg_write; end
     endcase  
     end
    */
endmodule
