`timescale 1ns/10ps

`include "four_bit_fulladder.sv"

module four_bit_fulladder_tb;

	logic [3:0]A, B; //inputs
    logic cin;
	logic [3:0]S; //outputs
    logic cout; 

	four_bit_fulladder A0(.S(S), .C4(cout), .A(A), .B(B), .C0(cin));// Instantiate module

	initial $monitor($time," A=%d, B=%d, cin=%d, S=%d, cout=%d", A, B, cin, S, cout); // Monitoring Input & Output port

	initial begin // Declare Input patterns
		#0  A = 0; B = 1; cin= 0 ;
		#10 A = 1; B = 3; cin= 0 ;
		#10 A = 2; B = 2; cin= 0 ;
		#10 A = 3; B = 4; cin= 0 ;
		#10 A = 0; B = 1; cin= 1 ;
		#10 A = 1; B = 3; cin= 1 ;
		#10 A = 2; B = 2; cin= 1 ;
		#10 A = 3; B = 4; cin= 1 ;
		#10 A = 15; B = 1; cin= 0 ;
		#10 A = 13; B = 2; cin= 1 ;
		#10 A = 11; B = 4; cin= 1 ;
		#10 A = 9; B = 7; cin= 0 ;
		
	end


	initial begin // Generate the waveform file
		$fsdbDumpfile("four_bit_fulladder.fsdb");
		$fsdbDumpvars;
		#200 $finish;
	end
	
endmodule
