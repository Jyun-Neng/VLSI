`timescale 1ns/10ps
`include "reg_sipo_32x8.sv"

`define PERIOD 20

module reg_sipo_32x8_tb;
	parameter ADSize = 5;
	parameter STP_REGSize = 32;
	parameter DASize = 8;

	logic clk, rst, enable, Write, Read;
	logic [ADSize-1:0] Read_ADDR, Write_ADDR;
	logic [DASize-1:0] DIN;
    
    logic [DASize-1:0] OUT_1, OUT_2, OUT_3;

	integer i;

	reg_sipo_32x8 r0(.clk(clk), .rst(rst), .enable(enable),.Write(Write), .Read(Read), .DIN(DIN), .Read_ADDR(Read_ADDR), .Write_ADDR(Write_ADDR), .
    OUT_1(OUT_1), .OUT_2(OUT_2), .OUT_3(OUT_3));
	
	initial clk = 'b1;

	always #(`PERIOD/2) clk = ~clk;
    
    initial begin
        $monitor("enable = %b, Write = %b, Read = %b, Read_ADDR = %d, Write_ADDR = %d, DIN = %d,OUT_1 = %d, OUT_2 = %d, OUT_3 = %d", enable, Write, Read, Read_ADDR, Write_ADDR, DIN, OUT_1, OUT_2, OUT_3);
    end
	
	initial begin
		rst = 'b1; enable = 'b0; Write = 'b0; Read = 'b0; DIN = 'h0; Read_ADDR = 'd0; Write_ADDR = 'd0;
		#(`PERIOD) rst = 'b0;
		#(`PERIOD) enable = 'b1; Write = 'b1; Read = 'b0; DIN = 'h1; Read_ADDR = 'd0; Write_ADDR = 'd0;
        #(`PERIOD) enable = 'b1; Write = 'b1; Read = 'b0; DIN = 'h2; Read_ADDR = 'd0; Write_ADDR = 'd1;
        #(`PERIOD) enable = 'b1; Write = 'b1; Read = 'b0; DIN = 'h3; Read_ADDR = 'd0; Write_ADDR = 'd2;
        #(`PERIOD) enable = 'b1; Write = 'b1; Read = 'b0; DIN = 'h4; Read_ADDR = 'd0; Write_ADDR = 'd3;


        #(`PERIOD) enable = 'b1; Write = 'b0; Read = 'b1; DIN = 'h9; Read_ADDR = 'd0; Write_ADDR = 'd0;
        #(`PERIOD) enable = 'b1; Write = 'b0; Read = 'b1; DIN = 'h9; Read_ADDR = 'd1; Write_ADDR = 'd1;
        #(`PERIOD) enable = 'b1; Write = 'b0; Read = 'b1; DIN = 'h9; Read_ADDR = 'd2; Write_ADDR = 'd2;
        #(`PERIOD) enable = 'b1; Write = 'b0; Read = 'b1; DIN = 'h9; Read_ADDR = 'd3; Write_ADDR = 'd3;
        
        #(`PERIOD) for(i = 0; i<4; i=i+1)begin
			$display($time, " reg[%d]=%h, " , i, r0.Regfile[i]);
		end
		#(`PERIOD) $finish;
	end
	
	initial begin
		$fsdbDumpfile("reg_sipo_32x8.fsdb");
		$fsdbDumpvars;
		#10000 $finish;
	end

endmodule
		
		
