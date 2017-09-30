/* 
    * File Name : control_tb.sv 
    *
    * Purpose : The control unit testbench.
    *           
    * Creation Date : 2017/09/30
    *
    * Last Modified : 2017/09/30
    *
    * Create By : Jyun-Neng Ji
    *
*/
`timescale 1ns/10ps

`include "control.sv"

module control_tb;
    logic [6:0] OP;
    logic DM_en, DM_write, RegWrite, branch, jump, ALUSrc;
    logic [1:0] MemtoReg, ALUOp;
    logic [2:0] ExtenSel;

    control c0 (.OP(OP), .DM_en(DM_en), .DM_write(DM_write), .RegWrite(RegWrite), .branch(branch), .jump(jump), .ALUSrc(ALUSrc),
                .MemtoReg(MemtoReg), .ALUOp(ALUOp), .ExtenSel(ExtenSel));

    initial $monitor($time, "OP=%b, DM_en=%b, DM_write=%b, branch=%b, jump=%b, ALUSrc=%b, MemtoReg=%b, RegWrite=%b, ALUOp=%d, ExtenSel=%d", 
                    OP, DM_en, DM_write, branch, jump, ALUSrc, MemtoReg, RegWrite, ALUOp, ExtenSel);

    initial begin
        #10 OP = 'b0110011;
        #10 OP = 'b0010011;
        #10 OP = 'b0000011;
        #10 OP = 'b0100011;
        #10 OP = 'b1100011;
        #10 OP = 'b0110111;
        #10 OP = 'b1101111;
    end                

    initial begin
        $fsdbDumpfile ("control.fsdb");
        $fsdbDumpvars;
        #200 $finish;
    end
                
endmodule
