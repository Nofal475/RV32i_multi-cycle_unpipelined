`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2022 03:24:53 AM
// Design Name: 
// Module Name: RV32i_multi
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


module RV32i_multi(
input clk,rst,[5:0]no_instruct,
output eof
);

wire IorD,mem_write,mem_read,IRwrite,MemtoReg,reg_write,ALUSrcA,PCSource,PCwrite,PCwriteCondition,zero,next_instruct;
wire [1:0]ALUSrcB,ALU_op;
wire [31:0]instruction31_0; 
wire [5:0]alu_cnt;

ALU_control a1(
.fuct7(instruction31_0[31:25]),.fuct3(instruction31_0[14:12]),.ALU_op(ALU_op),
.alu_cnt(alu_cnt)
    );

control_unit c1(
.clk(clk),.rst(rst),.eof(eof),.zero(zero),.opcode(instruction31_0[6:0]),
.IorD(IorD),.mem_write(mem_write),.mem_read(mem_read),.IRwrite(IRwrite),
.MemtoReg(MemtoReg),.reg_write(reg_write),.ALUSrcA(ALUSrcA),.PCSource(PCSource),
.PCwrite(PCwrite),.PCwriteCondition(PCwriteCondition),
.ALUSrcB(ALUSrcB),.ALU_op(ALU_op)
    );
    
Datapath d1(
.clk(clk),.rst(rst),.next_instruct(next_instruct),.IorD(IorD),.mem_write(mem_write),
.mem_read(mem_read),.IRwrite(IRwrite),.MemtoReg(MemtoReg),.reg_write(reg_write),.ALUSrcA(ALUSrcA),.PCSource(PCSource),
.ALUSrcB(ALUSrcB),
.alu_cnt(alu_cnt),.no_instruct(no_instruct),
.eof(eof),.zero(zero),.instruction31_0(instruction31_0)
);

wire a;
assign a = PCwriteCondition & zero;
assign next_instruct = a | PCwrite;        
endmodule
