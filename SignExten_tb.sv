/* 
    * File Name : SignExten_tb.sv 
    *
    * Purpose : The sign extension unit testbench.
    *           
    * Creation Date : 2017/10/01
    *
    * Last Modified : 2017/10/01
    *
    * Create By : Jyun-Neng Ji
    *
*/
`timescale 1ns/10ps

`include "SignExten.sv"    

`define ITYPE 'b000
`define STYPE 'b001
`define BTYPE 'b010
`define UTYPE 'b011
`define JTYPE 'b100

module SignExten_tb;
    logic [2:0] ExtenSel;
    logic [24:0] imm_in;
    logic [31:0] imm_out;

    SignExten S1 (.ExtenSel(ExtenSel), .imm_in(imm_in), .imm_out(imm_out));

    initial $monitor("ExtenSel=%d, input=%b, output=%h", ExtenSel, imm_in, imm_out);

    initial begin
        #10 ExtenSel = `ITYPE; imm_in = 'h1;
        #10 ExtenSel = `ITYPE; imm_in = 25'b1111111110111111111100111;
        #10 ExtenSel = `UTYPE; imm_in = 25'b1111111110111101111111111;
        #10 ExtenSel = `JTYPE; imm_in = 25'b0000010010000000000010101;;
    end

    initial begin
        $fsdbDumpfile ("SignExten.sv");
        $fsdbDumpvars;
        #100 $finish;
    end

endmodule
