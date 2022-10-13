`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2022 07:17:02 PM
// Design Name: 
// Module Name: Datapath
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


module Datapath(
input clk,rst,next_instruct,IorD,mem_write,mem_read,IRwrite,MemtoReg,reg_write,ALUSrcA,PCSource,
input [1:0]ALUSrcB,
input [5:0]alu_cnt,no_instruct,
output eof,zero,
output [31:0]instruction31_0 
);

wire [31:0]address_new,address,Bread_data_2,Aread_data_1,mux_address,alu_out,mem_data;
program_counter pc(
.clk(clk),.rst(rst),.next_instruct(next_instruct),
.address_new(address_new),.no_instruct(no_instruct),
.eof(eof),
.address(address)
    );
    
mux_2X1 mux1(
.A(alu_out),.B(address),
.Sel(IorD),
.mux(mux_address)
    );
    
 Memory mem(
.clk(clk),.rst(rst),.mem_write(mem_write),.mem_read(mem_read),
.address(mux_address),.data_in(Bread_data_2),
.data_out(mem_data)
);   

wire [6:0]instruction6_0;
wire [4:0]instruction19_15,instruction24_20,instruction11_7;
   
    
 Instruction_register IR(
.rst(rst),.clk(clk),.IRwrite(IRwrite),.mem_data(mem_data),
.instruction6_0(instruction6_0),
.instruction19_15(instruction19_15),
.instruction24_20(instruction24_20),
.instruction11_7(instruction11_7),
.instruction31_0(instruction31_0)
    );
  
 wire [31:0]mem_data_out,write_data;  
Mem_data_register Mem_data_register(
.rst(rst),.clk(clk),.mem_data(mem_data),
.mem_data_out(mem_data_out)
 );
        
mux_2X1 mux2(
.A(mem_data_out),.B(alu_out),
.Sel(MemtoReg),
.mux(write_data)
    );
        

 
 wire [31:0] read_data1,read_data2,imm_gen;   
Registers R(
.rst(rst),.clk(clk),.reg_write(reg_write),
.read_reg1(instruction19_15),.read_reg2(instruction24_20),.write_address(instruction11_7),
.write_data(write_data),
.read_data1(read_data1),.read_data2(read_data2)
);    
        
Imm_gen IG(
.rst(rst),.clk(clk),.instruction(instruction31_0),
.imm_gen(imm_gen)
);

A A(
.rst(rst),.clk(clk),.read_data_1(read_data1),
.Aread_data_1(Aread_data_1)
    );
    
B B(
.rst(rst),.clk(clk),.read_data_2(read_data2),
.Bread_data_2(Bread_data_2)
    );    


wire [31:0]mux3_out;               
mux_2X1 mux3(
.A(Aread_data_1),.B(address),
.Sel(ALUSrcA),
.mux(mux3_out)
    );
    
// 3X1 mux ALUSrcB
reg [31:0]mux4_out;
always @ (*) begin //mux4
case (ALUSrcB)
2'b00 : mux4_out <= Bread_data_2;
2'b01 : mux4_out <= 4;
2'b10 : mux4_out <= imm_gen;
default : mux4_out <= mux4_out;
endcase
end

wire [31:0]result_alu;
ALU ALU(
.clk(clk),.rst(rst),.alu_cnt(alu_cnt),.a(mux3_out),.b(mux4_out),
.zero(zero),
.result_alu(result_alu) 
    );
    
    
ALU_out Alu_reg(
.rst(rst),
.clk(clk),
.result_alu(result_alu),
.alu_out(alu_out)
    );        

mux_2X1 mux5(
.A(alu_out),.B(result_alu),
.Sel(PCSource),
.mux(address_new)
    );

endmodule
