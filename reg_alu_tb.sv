`timescale 1ns/10ps
`include "reg_alu.sv"
`define PERIOD 20

module reg_alu_tb;
    parameter DASize = 32;
    parameter ADSize = 5;
    parameter OPSize = 3;

    logic clk, rst, Write, Read, Overflow, S;
    logic [ADSize-1:0] Read_ADDR_1, Read_ADDR_2, Write_ADDR;
    logic [DASize-1:0] alu_result, DIN;
    logic [OPSize-1:0] OP;

    integer i;

    reg_alu r0(.clk(clk), .rst(rst), .Write(Write), .Read(Read), .S(S), .alu_result(alu_result), .Overflow(Overflow), .DIN(DIN), .Write_ADDR(Write_ADDR), .Read_ADDR_1(Read_ADDR_1),
    .Read_ADDR_2(Read_ADDR_2), .OP(OP));

    initial clk = 'b0;

    always #(`PERIOD/2) clk = ~clk;

    initial
        $monitor("Write=%d, Read=%d, Write_ADDR=%d, Read_ADDR_1=%d, Read_ADDR_2=%d, OP=%d, Overflow=%d, S=%d, DIN=%d, alu_result=%d", Write, Read, Write_ADDR, Read_ADDR_1, 
        Read_ADDR_2, OP, Overflow, S, DIN, alu_result); 

    initial begin
        rst = 'b1; Write = 'b0; Read = 'b0; DIN = 'b0; Read_ADDR_1 = 'b0; Read_ADDR_2 = 'b0; Write_ADDR = 'b0;
        #(`PERIOD) rst = 'b0; 
        #(`PERIOD) Write = 'b1; Read = 'b0; S = 'b0; Write_ADDR = 'd0; DIN = 'hf;
        #(`PERIOD) Write = 'b1; Read = 'b0; S = 'b0; Write_ADDR = 'd1; DIN = 'h1; 
        #(`PERIOD) Write = 'b1; Read = 'b0; S = 'b0; Write_ADDR = 'd2; DIN = 'h2;
        #(`PERIOD) Write = 'b0; Read = 'b1; Read_ADDR_1 = 'd1; Read_ADDR_2 = 'd2; OP = 3'b000;
        #(`PERIOD) Read_ADDR_1 = 'd0; Read_ADDR_2 = 'd1; OP = 3'b100;
        #(`PERIOD) for (i = 0; i < 32; i = i + 1) begin
            $display($time, "reg[%d]=%h", i, r0.reg0.Regfile[i]);
        end
        #(`PERIOD) $finish;
    end

    initial begin
        $fsdbDumpfile("reg_alu.fsdb");
        $fsdbDumpvars;
        #200 $finish;
    end
endmodule
