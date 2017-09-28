`timescale 1ns/10ps
`include "RAM.sv"

`define PERIOD 20

module RAM_tb;
	parameter ADSize = 4;
	parameter DASize = 16;
	parameter RAMSize = 16;

	logic clk, rst, en_read, en_write;
	logic [ADSize-1:0] addr;
	logic [DASize-1:0] DMin, DMout;

	integer i;

	RAM r1(.clk(clk), .rst(rst), .en_read(en_read), .en_write(en_write), .addr(addr), .DMin(DMin), .DMout(DMout));
	
	initial clk = 'b0;
	

	always #(`PERIOD/2) clk = ~clk;
	
	initial begin
		rst = 'b1; en_read = 'b0; en_write = 'b0; addr = 4'd0; DMin = 16'd0;
		#(`PERIOD) rst = 'b0; en_read = 'b0; en_write = 'b1; addr = 4'd0; DMin = 16'd1;
		#(`PERIOD) en_read = 'b0; en_write = 'b1; addr = 4'd1; DMin = 16'd2;
		#(`PERIOD) en_read = 'b0; en_write = 'b1; addr = 4'd2; DMin = 16'd3;
		#(`PERIOD) en_read = 'b0; en_write = 'b1; addr = 4'd3; DMin = 16'd4;
		#(`PERIOD) en_read = 'b0; en_write = 'b1; addr = 4'd4; DMin = 16'd5;
		#(`PERIOD) en_read = 'b0; en_write = 'b1; addr = 4'd5; DMin = 16'd6;
		#(`PERIOD) en_read = 'b0; en_write = 'b1; addr = 4'd6; DMin = 16'd7;

		#(`PERIOD) en_read = 'b1; en_write = 'b0; addr = 4'd1; DMin = 16'd1;
		#(`PERIOD) en_read = 'b1; en_write = 'b0; addr = 4'd2; DMin = 16'd2;
		#(`PERIOD) en_read = 'b1; en_write = 'b0; addr = 4'd3; DMin = 16'd3;
		#(`PERIOD) en_read = 'b1; en_write = 'b0; addr = 4'd4; DMin = 16'd4;
		#(`PERIOD) en_read = 'b1; en_write = 'b0; addr = 4'd5; DMin = 16'd5;
		#(`PERIOD) en_read = 'b1; en_write = 'b0; addr = 4'd6; DMin = 16'd6;
		#(`PERIOD) en_read = 'b1; en_write = 'b0; addr = 4'd7; DMin = 16'd7;

		
		#(`PERIOD) for(i = 0; i<RAMSize; i=i+1)begin
			$display($time, " RAM[%d]=%h, " , i, r1.RAM_Data[i]);
		end
		#(`PERIOD) $finish;
	end
	
	initial begin
		$fsdbDumpfile("RAM.fsdb");
		$fsdbDumpvars;
		#10000 $finish;
	end

endmodule
		
		
