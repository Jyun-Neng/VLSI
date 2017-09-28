`timescale 1ns/10ps
`include "reg_32x32.sv"

`define PERIOD 20

module reg32x32_tb;
	parameter ADSize = 5;
	parameter REGSize = 32;
	parameter DASize = 32;

	logic clk, rst, enable, Write, Read;
	logic [ADSize-1:0] Read_ADDR_1, Read_ADDR_2, Write_ADDR;
	logic [DASize-1:0] DIN;
    
    logic [DASize-1:0] OUT_1, OUT_2;

	integer i;

	reg_32x32 r0(.OUT_1(OUT_1), .OUT_2(OUT_2), .Write(Write), .Read(Read), .Read_ADDR_1(Read_ADDR_1), .Read_ADDR_2(Read_ADDR_2), .Write_ADDR(Write_ADDR), .DIN(DIN), .enable(enable), .clk(clk), .rst(rst));
	
	initial clk = 'b1;

	always #(`PERIOD/2) clk = ~clk;
	
    initial begin
        $monitor("enable = %b, Write = %b, Read = %b, Read_ADDR_1 = %d, Read_ADDR_2 = %d, Write_ADDR = %d, DIN = %d,OUT_1 = %d, OUT_2 = %d", enable, Write, Read, Read_ADDR_1, Read_ADDR_2, Write_ADDR, DIN, OUT_1, OUT_2);
    end
    
	initial begin
		rst = 'b1; enable = 'b0; Write = 'b0; Read = 'b0; Read_ADDR_1 = 'd0; Read_ADDR_2 = 'b0; Write_ADDR = 'b0; DIN = 'h0;
		#(`PERIOD) rst = 'b0;
		#(`PERIOD) enable = 'b1; Write = 'b1; Read = 'b0; Read_ADDR_1 = 'd1; Read_ADDR_2 = 'd2; Write_ADDR = 'd0; DIN = 'h1;
		#(`PERIOD) enable = 'b1; Write = 'b1; Read = 'b0; Read_ADDR_1 = 'd1; Read_ADDR_2 = 'd2; Write_ADDR = 'd1; DIN = 'h2;
        #(`PERIOD) enable = 'b1; Write = 'b1; Read = 'b0; Read_ADDR_1 = 'd1; Read_ADDR_2 = 'd2; Write_ADDR = 'd2; DIN = 'h3;
        #(`PERIOD) enable = 'b1; Write = 'b1; Read = 'b0; Read_ADDR_1 = 'd1; Read_ADDR_2 = 'd2; Write_ADDR = 'd3; DIN = 'h4;
        
		#(`PERIOD) enable = 'b1; Write = 'b0; Read = 'b1; Read_ADDR_1 = 'd1; Read_ADDR_2 = 'd4; Write_ADDR = 'd0; DIN = 'hF;
		#(`PERIOD) enable = 'b1; Write = 'b0; Read = 'b1; Read_ADDR_1 = 'd3; Read_ADDR_2 = 'd2; Write_ADDR = 'd1; DIN = 'hF;
		#(`PERIOD) enable = 'b1; Write = 'b0; Read = 'b1; Read_ADDR_1 = 'd2; Read_ADDR_2 = 'd3; Write_ADDR = 'd2; DIN = 'hF;
		#(`PERIOD) enable = 'b1; Write = 'b0; Read = 'b1; Read_ADDR_1 = 'd4; Read_ADDR_2 = 'd1; Write_ADDR = 'd3; DIN = 'hF;
 
        #(`PERIOD) for(i = 0; i<4; i=i+1)begin
			$display($time, " reg[%d]=%h, " , i, r0.Regfile[i]);
		end
		#(`PERIOD) $finish;
	end
	
	initial begin
		$fsdbDumpfile("reg_32x32.fsdb");
		$fsdbDumpvars;
		#10000 $finish;
	end

endmodule
		
		
