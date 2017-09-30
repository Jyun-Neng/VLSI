/* 
    * File Name : ALU_control_tb.sv 
    *
    * Purpose : The ALU control unit testbench.
    *           
    * Creation Date : 2017/09/30
    *
    * Last Modified : 2017/09/30
    *
    * Create By : Jyun-Neng Ji
    *
*/
`timescale  1ns/10ps

`include "ALU_control.sv"

module ALU_control_tb;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [1:0] ALUOp;
    logic [3:0] ALUType;

    ALU_control A1 (.funct3(funct3), .funct7(funct7), .ALUOp(ALUOp), .ALUType(ALUType));    

    initial $monitor($time, "ALUOp=%d, funct3=%d, funct7=%b, ALUType=%d", ALUOp, funct3, funct7, ALUType);

    initial begin
        #10 ALUOp = 'b01; funct3 = 'b010;
        #10 ALUOp = 'b10; funct3 = 'b000;
        #10 ALUOp = 'b11; funct3 = 'b010;
        #10 ALUOp = 'b00; funct3 = 'b010;
        #10 ALUOp = 'b00; funct3 = 'b111;
        #10 ALUOp = 'b00; funct3 = 'b000; funct7 = 'b0000000;
        #10 ALUOp = 'b00; funct3 = 'b000; funct7 = 'b0100000;
    end

    initial begin
        $fsdbDumpfile ("ALU_control.fsdb");
        $fsdbDumpvars;
        #100 $finish;
    end

endmodule
