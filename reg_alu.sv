// reg_alu.sv

`include "reg_32x32.sv"    
`include "mux2to1.sv"
`include "ALU.sv"

module reg_alu(clk, rst, Write, Read, S, alu_result, Overflow, DIN, Write_ADDR, Read_ADDR_1, Read_ADDR_2, OP);
    parameter ADSize = 5;
    parameter DASize = 32;
    parameter REGSize = 32;
    parameter OPSize = 3;

    input clk, rst, Write, Read, S;
    input [DASize-1:0] DIN;
    input [ADSize-1:0] Write_ADDR, Read_ADDR_1, Read_ADDR_2;
    input [OPSize-1:0] OP;
    output logic Overflow;
    output logic [DASize-1:0] alu_result;

    logic [DASize-1:0] din, src1, src2, alu_reg = alu_result;
    logic enable = 1;    

    mux2to1 mux0(.Y(din), .S(S), .I0(DIN), .I1(alu_reg));
    reg_32x32 reg0(.clk(clk), .rst(rst), .enable(enable), .Write(Write), .Read(Read), .Read_ADDR_1(Read_ADDR_1), .Read_ADDR_2(Read_ADDR_2), 
        .Write_ADDR(Write_ADDR), .DIN(din), .OUT_1(src1), .OUT_2(src2));
    ALU alu0(.Overflow(Overflow), .alu_result(alu_result), .src1(src1), .src2(src2), .OP(OP), .enable(enable));


endmodule
