`timescale 1ns/10ps

`include "one_bit_fulladder.sv"

module one_bit_fulladder_tb;

	logic A, B, cin; // input
	logic S, cout; // outputs

	one_bit_fulladder FA0( .S(S) , .cout(cout) , .A(A) , .B(B) , .cin(cin) ) ; // Instantiate module

	initial $monitor($time," A=%d, B=%d, cin=%d, S=%d, cout=%d",A, B, cin, S, cout) ; // Monitoring Input & Output port

	initial begin // Declare Input patterns
		A = 1; B = 0; cin= 0 ;
		#10 cin= 1 ;
		#10 A = 0 ;
		#10 B = 1 ;
		#10 cin= 0 ;
		#10 A = 1 ;
		
	end


	initial begin // Generate the waveform file
		$fsdbDumpfile("one_bit_fulladder.fsdb");
		$fsdbDumpvars;
		#200 $finish;
	end
	
endmodule
