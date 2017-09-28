`timescale 1ns/10ps

`include "mux2to1.sv"

module mux2to1_tb;

	logic S , I0 , I1 , Y;
	
	mux2to1 M0(.Y(Y) , .S(S) , .I0(I0) , .I1(I1));
	
	initial begin
		$monitor($time , "S=%d,I0=%d,I1=%d,Y=%d" , S , I0 , I1 , Y);
	end
	
	initial begin
		#0  S=0;I0=0;I1=0;
		#10	I0=0;I1=1;
		#10	I0=1;I1=0;
		#10	I0=1;I1=1;
		#10 S=1;I0=0;I1=0;
		#10	I0=0;I1=1;
		#10	I0=1;I1=0;
		#10	I0=1;I1=1;
	end
	
	initial begin
		$fsdbDumpfile("mux2to1.fsdb");
		$fsdbDumpvars;
		#200 $finish;
	end
	
endmodule 
