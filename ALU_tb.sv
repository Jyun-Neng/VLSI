/* 
    * File Name : ALU_tb.sv
    *
    * Purpose : An ALU testbench. 
    *
    * Creation Date : 2017/09/27
    *
    * Last Modified : 2017/09/28
    *
    * Create By : Jyun-Neng Ji
    *
*/

`timescale 1ns/10ps

`include "ALU.sv"
`define ADD 'd0
`define SUB 'd1
`define SLL 'd2
`define SLT 'd3
`define XOR 'd4
`define SRL 'd5
`define OR  'd6
`define AND 'd7
`define NDEF 'd8
`define	DataSize	32
`define	ALUopSize	4

module ALU_tb;

logic Zero;
logic [`DataSize-1:0] 	alu_result;
logic [`ALUopSize-1:0] 	ALUType;
logic [`DataSize-1:0] 	src1;
logic [`DataSize-1:0] 	src2;
logic rst;

ALU alu (.Zero(Zero) , .alu_result(alu_result) , .src1(src1) , .src2(src2) , .ALUType(ALUType) , .rst(rst));
		 
//monitor
initial begin
	$monitor("reset = %b, src1 = %h, src2 = %h, ALUType = %d, alu_result = %h, Zero = %b", rst, src1, src2, ALUType, alu_result, Zero);
end

initial begin
    #10 rst = 1'b1; src1 = 32'h0; src2 = 32'h0; ALUType = `ADD;
    #10 rst = 1'b0; src1 = 32'h3; src2 = 32'h9; ALUType = `SLT;
    #10 rst = 1'b0; src1 = 32'hCC; src2 = 32'hAA; ALUType = `SLL;
    #10 rst = 1'b0; src1 = 32'hE; src2 = 32'h7; ALUType = `SLT;
    #10 rst = 1'b0; src1 = 32'hfffffff5; src2 = 32'h12; ALUType = `SRL;
    #10 rst = 1'b0; src1 = 32'h1; src2 = 32'h1; ALUType = `XOR;
    #10 rst = 1'b0; src1 = 32'h1; src2 = 32'h1; ALUType = `AND;
    #10 rst = 1'b0; src1 = 'd10; src2 = 'd20; ALUType = `SUB;
    #10 rst = 1'b0; src1 = 'd30; src2 = 'd20; ALUType = `ADD;
    #10 rst = 1'b0; src1 = 'd10; src2 = 'd20; ALUType = `NDEF;
    #10 rst = 1'b0; src1 = 'd10; src2 = 'd20; ALUType = `XOR;
end

	initial begin // Generate the waveform file
		$fsdbDumpfile("ALU.fsdb");
		$fsdbDumpvars;
		#200 $finish;
	end
endmodule
