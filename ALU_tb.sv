`timescale 1ns/10ps

`include "ALU.sv"

`define	DataSize	32
`define	ALUopSize	4

module ALU_tb;

logic Overflow;
logic [`DataSize-1:0] 	alu_result;
logic [`ALUopSize-1:0] 	OP;
logic [`DataSize-1:0] 	src1;
logic [`DataSize-1:0] 	src2;
logic enable;

ALU alu (.Overflow(Overflow) , .alu_result(alu_result) , .src1(src1) , .src2(src2) , .OP(OP) , .enable(enable));
		 
//monitor
initial begin
	$monitor("enable = %b, src1 = %h, src2 = %h, OP = %b, alu_result = %h, Overflow = %b", enable, src1, src2, OP, alu_result, Overflow);
end

initial begin
    #0 enable = 1'b0; src1 = 32'h0; src2 = 32'h0; OP = 3'b000;
    #10 enable = 1'b1; src1 = 32'h3; src2 = 32'h9; OP = 3'b000;
    #10 enable = 1'b1; src1 = 32'hCC; src2 = 32'hAA; OP = 3'b001;
    #10 enable = 1'b1; src1 = 32'hE; src2 = 32'h7; OP = 3'b010;
    #10 enable = 1'b1; src1 = 32'h5; src2 = 32'h2; OP = 3'b011;
    #10 enable = 1'b1; src1 = 32'h1; src2 = 32'h1; OP = 3'b100;
    #10 enable = 1'b1; src1 = 32'h1; src2 = 32'h1; OP = 3'b101;
end

	initial begin // Generate the waveform file
		$fsdbDumpfile("ALU.fsdb");
		$fsdbDumpvars;
		#200 $finish;
	end
endmodule
