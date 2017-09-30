/* 
    * File Name : RegFile_tb.sv
    *
    * Purpose : RegFile testbench.
    *           
    * Creation Date : 2017/09/29
    *
    * Last Modified : 2017/09/29
    *
    * Create By : Jyun-Neng Ji
    *
*/
`timescale 1ns/10ps
`include "RegFile.sv"    
`define PERIOD 20

module Regfile_tb;
	parameter ADSize = 5;
	parameter REGSize = 32;
	parameter DASize = 32;

	logic clk, rst, Write;
	logic [ADSize-1:0] Read_ADDR_1, Read_ADDR_2, Write_ADDR;
	logic [DASize-1:0] DIN;
    
    logic [DASize-1:0] OUT_1, OUT_2;

	integer i;

	RegFile r0(.OUT_1(OUT_1), .OUT_2(OUT_2), .RegWrite(Write), .Read_ADDR_1(Read_ADDR_1), .Read_ADDR_2(Read_ADDR_2), 
        .Write_ADDR(Write_ADDR), .DIN(DIN), .clk(clk), .rst(rst));
	
	initial clk = 'b1;

	always #(`PERIOD/2) clk = ~clk;
	
    initial begin
        $monitor("Write = %b, Read_ADDR_1 = %d, Read_ADDR_2 = %d, Write_ADDR = %d, DIN = %d,OUT_1 = %d, OUT_2 = %d", Write, Read_ADDR_1, Read_ADDR_2, Write_ADDR, DIN, OUT_1, OUT_2);
    end
    
	initial begin
		rst = 'b1; Write = 'b0; Read_ADDR_1 = 'd0; Read_ADDR_2 = 'd0; Write_ADDR = 'd0; DIN = 'h0;
		#(`PERIOD) rst = 'b0;
		#(`PERIOD) Write = 'b1; Read_ADDR_1 = 'd1; Read_ADDR_2 = 'd2; Write_ADDR = 'd0; DIN = 'h1;
		#(`PERIOD) Write = 'b1; Read_ADDR_1 = 'd1; Read_ADDR_2 = 'd2; Write_ADDR = 'd1; DIN = 'h2;
        #(`PERIOD) Write = 'b1; Read_ADDR_1 = 'd1; Read_ADDR_2 = 'd2; Write_ADDR = 'd2; DIN = 'h3;
        #(`PERIOD) Write = 'b1; Read_ADDR_1 = 'd1; Read_ADDR_2 = 'd2; Write_ADDR = 'd3; DIN = 'h4;
        
		#(`PERIOD) Write = 'b0; Read_ADDR_1 = 'd1; Read_ADDR_2 = 'd4; Write_ADDR = 'd0; DIN = 'hF;
		#(`PERIOD) Write = 'b0; Read_ADDR_1 = 'd3; Read_ADDR_2 = 'd2; Write_ADDR = 'd1; DIN = 'hF;
		#(`PERIOD) Write = 'b0; Read_ADDR_1 = 'd2; Read_ADDR_2 = 'd3; Write_ADDR = 'd2; DIN = 'hF;
		#(`PERIOD) Write = 'b0; Read_ADDR_1 = 'd4; Read_ADDR_2 = 'd1; Write_ADDR = 'd3; DIN = 'hF;
 
        #(`PERIOD) for(i = 0; i<4; i=i+1)begin
			$display($time, " reg[%d]=%h, " , i, r0.mem[i]);
		end
		#(`PERIOD) $finish;
	end
	
	initial begin
		$fsdbDumpfile("Regfile.fsdb");
		$fsdbDumpvars;
		#10000 $finish;
	end

endmodule
		
		
