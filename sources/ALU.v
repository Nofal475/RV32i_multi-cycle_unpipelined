`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2022 05:38:19 AM
// Design Name: 
// Module Name: RISCV_ALU
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


module ALU(
input clk,rst,[5:0]alu_cnt,[31:0]a,b,
output reg zero,
output reg [31:0]result_alu 
    );
   
   reg msb,zeros; 

   always @ (posedge clk  or negedge rst)
    begin
    if (!rst)begin
    result_alu <= 0;
    zero<=0;
    msb<=0; zeros<=0; end
     else begin
     case (alu_cnt)
     6'b000000 : begin  result_alu <= a + b; msb<=0; zeros<=0; end // R format start
     6'b000001 : begin result_alu <= a - b;  msb<=0; zeros<=0; end  
     6'b000010 : begin result_alu <= a << b;   msb<=0; zeros<=0; end    
     6'b000011 : if (a < b) result_alu <= 1; else result_alu <= 0;    
      6'b000100 :  if (a < b) begin
                     result_alu <= 1;msb<=0; zeros<=1; end 
                   else begin
                     result_alu <= 0;msb<=0; zeros<=1;
                     end    
     6'b000101 : begin result_alu <= a ^ b; msb<=0; zeros<=0;end     
     6'b000110 : begin result_alu <= a >> b; msb<=0; zeros<=0; end     
     6'b000111 : begin result_alu <= a >> b; msb<=1; zeros<=0;end//  msb extend           R format complete     
     6'b001000 : begin result_alu <= a + b; msb<=0; zeros<=0; end      // I format load Start
     6'b001001 :  begin result_alu <= a + b; msb<=0; zeros<=0; end       
     6'b001010 : begin result_alu <= a + b; msb<=0; zeros<=0; end       
     //6'b001011 : begin result_alu[7:0] <= a + b; result_alu[31:8] <= a + b;   end // zer0 extend     
    // 6'b001100 :  begin result_alu[15:0] <= a + b; result_alu[31:16] <= a + b;   end     // I format load complete  
     6'b001101 : begin result_alu <= a + b; msb<=0; zeros<=0;end   // I Format ADDI ORI XORI ANDI SRI SLI start
     6'b001110 : begin result_alu <= a << b[4:0];msb<=0; zeros<=0; end     
     6'b001111 : if (a < b)begin
      result_alu <= 32'b1;msb<=0; zeros<=0;
      end 
      else begin 
      result_alu <= 0;msb<=0; zeros<=0;
      end 
     6'b010000 : if (a < b)  begin 
     result_alu <= 32'b1;msb<=0; zeros<=1; end  
     else  begin 
     result_alu <= 0;msb<=0; zeros<=1;
     end     
     6'b010001 : begin result_alu <= a ^ b;msb<=0; zeros<=0;end     
     6'b010010 : begin result_alu <= a >> b[4:0]; msb<=0; zeros<=0;end    
     6'b010011 : begin result_alu <= a | b;msb<=0; zeros<=0;end     
     6'b010100 : begin result_alu <= a & b;msb<=0; zeros<=0; end   // I Format ADDI ORI XORI ANDI SRI SLI  complete    
     6'b010101 : begin result_alu <= a + b; msb<=0; zeros<=0; end   // S format store Store 
     6'b010110 : begin result_alu <= a + b; msb<=0; zeros<=0; end    
     6'b010111 : begin result_alu <= a + b;msb<=0; zeros<=0;end // S format complete     
     6'b011000 : if (a == b) zero <= 0; else zero <= 1;   // SB format start    
     6'b011001 : if (a != b) zero <= 0; else zero <= 1;       
     6'b011010 : if (a < b) zero <= 0; else zero <= 1;       
     6'b011011 : if (a >= b) zero <= 0; else zero <= 1;       
     6'b011100 : if (a < b) begin zero <= 1; msb<=0; zeros<=1; end else begin zero <= 0; msb<=0; zeros<=1;end //zero extentds       
     6'b011101 : if (a >= b) begin zero <= 1;msb<=0; zeros<=1; end else begin zero <= 0;msb<=0; zeros<=0; end  // zero extends       
     6'b011110 : begin result_alu <= b << 12; msb<=0; zeros<=0; end//lui     
  //  default : result_alu <= 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
     default : result_alu <= result_alu; 
     endcase  // end 
    end 
    end
    
endmodule
