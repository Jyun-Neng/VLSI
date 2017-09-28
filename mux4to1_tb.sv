`timescale 1ns/10ps

`include "mux4to1.sv"

module mux4to1_tb;

	logic Y, S0, S1, I0, I1, I2, I3;
	
	 mux4to1 M0(Y, S0, S1, I0, I1, I2, I3);
	
	initial begin
		$monitor($time , "S=%d,I0=%d,I1=%d,I2=%d,I3=%d,Y=%d" , {S1,S0} , I0 , I1 , I2 , I3 , Y);
	end
	
	initial begin
		#0  S1=0; S0=0; I0=0; I1=1; I2=1; I3=1;
		#10	S1=0; S0=1; I0=1; I1=0; I2=1; I3=1;
		#10	S1=0; S0=0; I0=1; I1=0; I2=0; I3=0;
		#10	S1=0; S0=1; I0=0; I1=1; I2=0; I3=0;
		#10 S1=1; S0=0; I0=1; I1=1; I2=0; I3=1;
		#10	S1=1; S0=1; I0=1; I1=1; I2=1; I3=0;
		#10	S1=1; S0=0; I0=0; I1=0; I2=1; I3=0;
		#10	S1=1; S0=1; I0=0; I1=0; I2=0; I3=1;
	end
	
	initial begin
		$fsdbDumpfile("mux4to1.fsdb");
		$fsdbDumpvars;
		#200 $finish;
	end
	
endmodule 


