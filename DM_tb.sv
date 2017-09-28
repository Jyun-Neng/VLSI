/* 
    * File Name : DM_tb.sv
    *
    * Purpose : test DM.sv
    *           
    * Creation Date : 2017/09/28
    *
    * Last Modified : 2017/09/28
    *
    * Create By : Jyun-Neng Ji
    *
*/

`timescale 1ns/10ps

`define PERIOD 20

`include "DM.sv"    

module DM_tb;
    parameter ADSize = 16;
    parameter DASize = 32;
    parameter DMSize = 17'h10000;

    logic clk, rst, DM_write, DM_enable;
    logic [ADSize-1:0] DM_address;
    logic [DASize-1:0] DM_in, DM_out;

    integer i;

    DM DM1(.clk(clk), .rst(rst), .DM_write(DM_write), .DM_enable(DM_enable), .DM_in(DM_in), .DM_out(DM_out), .DM_address(DM_address));
    
    initial clk = 0;

    always #(`PERIOD/2) clk = ~clk;

    initial $monitor ("rst=%d, DM_enable=%d, DM_write=%d, DM_in=%d, DM_address=%d, DM_out=%d", rst, DM_enable, DM_write, DM_in, DM_address, DM_out);

    initial begin
        rst = 1;
        #(`PERIOD) rst = 0; DM_enable = 1; DM_write = 1; DM_address = 0; DM_in = 10;
        #(`PERIOD) rst = 0; DM_enable = 1; DM_write = 1; DM_address = 0; DM_in = 20;
        #(`PERIOD) rst = 0; DM_enable = 1; DM_write = 1; DM_address = 1; DM_in = 11;
        #(`PERIOD) rst = 0; DM_enable = 1; DM_write = 1; DM_address = 2; DM_in = 12;
        #(`PERIOD) rst = 0; DM_enable = 1; DM_write = 0; DM_address = 0;
        #(`PERIOD) rst = 0; DM_enable = 1; DM_write = 0; DM_address = 1; DM_in = 10;
        #(`PERIOD) for (i=0; i<10; i=i+1) $display ($time, "DM[%d]=%d", i, DM1.mem_data[i]);
        #(`PERIOD) $finish;
    end

    initial begin
        $fsdbDumpfile("DM.fsdb");
        $fsdbDumpvars;
        #200 $finish;
    end

endmodule
