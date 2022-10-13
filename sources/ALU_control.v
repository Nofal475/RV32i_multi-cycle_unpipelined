`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/02/2022 12:48:52 AM
// Design Name: 
// Module Name: ALU_control
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


module ALU_control(
input [6:0]fuct7,[2:0]fuct3,[1:0]ALU_op,
output reg [5:0]alu_cnt
    );
    
  //  reg [2:0] fuct3_1;
  //  reg [3:0]ALU_op_1;
    
    always @ (*) begin
    //fuct3_1 <= fuct3;
    //ALU_op_1 <= ALU_op; 
    case (ALU_op)
    2'b01 : case (fuct3) // R type instruct state 8
              4'b0000 : if (fuct7 ==7'h00)  alu_cnt <= 6'b000000; //add rd = rs1 + rs2
                        else if (fuct7 ==7'h20) alu_cnt <= 6'b000001; //sub rd = rs1 - rs2
              4'b0001 :  alu_cnt <= 6'b000010;   //  shift left logical rd = rs1 << rs2 
              4'b0010 :  alu_cnt <= 6'b000011;   //  set less than rd = (rs1 < rs2)?1:0
              //4'b0011 :  alu_cnt <= 6'b000100;   //  set less than u rd = (rs1 < rs2)?1:0 zero extends
              4'b0100 :  alu_cnt <= 6'b000101;   //  xor rd = rs1 ^ rs2
              4'b0101 : if (fuct7 ==7'h00)  alu_cnt <= 6'b000110; //shift right logical rd = rs1 >> rs2
                        else if (fuct7 ==7'h20) alu_cnt <= 6'b000111; //shift right logical rd = rs1 >> rs2 msb extends       
               default : alu_cnt <= alu_cnt;           
              endcase
    2'b11 : case (fuct3)   //I Format LOAD  state 3
              4'b0000 : alu_cnt <= 6'b001000; // load byte rd = M[rs1+imm][0:7]
              4'b0001 : alu_cnt <= 6'b001001; // load half rd = M[rs1+imm][0:15]
              4'b0010 : alu_cnt <= 6'b001010; // load word rd = M[rs1+imm][0:31]
              4'b0100 : alu_cnt <= 6'b001011; // load byte u rd = M[rs1+imm][0:7] zero extends
              4'b0101 : alu_cnt <= 6'b001100; // load half rd = M[rs1+imm][0:15]  zero extends
              default : alu_cnt <= alu_cnt;
              endcase      
   /* 4'b10 : case (fuct3) // I Format ADDI ORI XORI ANDI SRI SLI
              4'b0000 : alu_cnt <= 6'b001101; // add immeditate rd = rs1 + imm
              4'b0001 : alu_cnt <= 6'b001110; // shift left logical immediate rd = rs1 << imm[0:4]
              4'b0010 : alu_cnt <= 6'b001111; // shift less than immediate rd = (rs1 < imm)?1:0
              4'b0011 : alu_cnt <= 6'b010000; // shift less than immediate u rd = (rs1 < imm)?1:0 zero extends
              4'b0100 : alu_cnt <= 6'b010001; // xor immediate rd = rs1 ˆ imm
              4'b0101 : alu_cnt <= 6'b010010; // shift right immediate rd = rs1 >> imm[0:4]
              4'b0110 : alu_cnt <= 6'b010011; // or immediate rd = rs1 | imm
              4'b0111 : alu_cnt <= 6'b010100; // and immediate rd = rs1 & imm
              default : alu_cnt <= alu_cnt;
              endcase  */
  /*  2'b10 : case (fuct3) // S format store  state 5
              4'b0000 : alu_cnt <= 6'b010101; // store byte M[rs1+imm][0:7] = rs2[0:7]
              4'b0001 : alu_cnt <= 6'b010110; //store have M[rs1+imm][0:15] = rs2[0:15]
              4'b0010 : alu_cnt <= 6'b010111; //store word  M[rs1+imm][0:31] = rs2[0:31]
              default : alu_cnt <= alu_cnt;
              endcase    */     
    2'b00 :  case (fuct3) // SB format branch
               4'b0000 : alu_cnt <= 6'b011000; // beq if(rs1 == rs2) PC += imm
               4'b0001 : alu_cnt <= 6'b011001; // bneq if(rs1 != rs2) PC += imm
               4'b0100 : alu_cnt <= 6'b011010; // branch < if(rs1 <rs2) PC += imm
               4'b0101 : alu_cnt <= 6'b011011; // branch >=  if(rs1 >= rs2) PC += imm
               4'b0110 : alu_cnt <= 6'b011100; //branch less u   if(rs1 <rs2) PC += imm zero extends
               4'b0111 : alu_cnt <= 6'b011101; //branch >= u   if(rs1 >= rs2) PC += imm zero extends
               default : alu_cnt <= alu_cnt;
               endcase         
   // 4'b0111 : alu_cnt <= 6'b011110; //u format lui  rd = imm << 12       
  //  4'b1000 : alu_cnt <= 6'b011111;  //u format auipc rd = PC + (imm << 12)    
    //4'b1001 : alu_cnt <= 6'b100000; // uj format juump and link  rd = PC+4; PC += imm
    default : alu_cnt <= alu_cnt;
    endcase
    end
    
endmodule
