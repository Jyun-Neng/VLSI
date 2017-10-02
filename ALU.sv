/* 
    * File Name : ALU.sv
    *
    * Purpose : Make an ALU component with two 32 bits data input ports (sr1, sr2),
    *           one 4 bits control port (ALUType), one 1 bit reset port (rst),
    *           one 32 bits data output port (alu_result), and one 1 bit
    *           Zero detect port (Zero), detect if src1 is equal to src2. And it can do 8 operations.
    *           Addition, substraction, and, or, shift left, shift right, xor, and set less than.
    *
    * Creation Date : 2017/09/27
    *
    * Last Modified : 2017/10/02
    *
    * Create By : Jyun-Neng Ji
    *
*/

`define ADD 'd0
`define SUB 'd1
`define SLL 'd2
`define SLT 'd3
`define XOR 'd4
`define SRL 'd5
`define OR  'd6
`define AND 'd7
`define NDEF 'd8

module ALU(Overflow, Zero, alu_result, src1, src2, ALUType, rst);
    parameter DataSize = 32;
    parameter ALUopSize = 4;
       
    input [DataSize-1:0] src1, src2;
    input [ALUopSize-1:0] ALUType;
    input rst;
    output logic [DataSize-1:0] alu_result;
    output logic Zero, Overflow;

    logic [DataSize-1:0] one = 32'hffffffff;
    
    always_comb begin
        if (!rst) begin
            case (ALUType)
                `ADD : begin 
                    alu_result <= src1 + src2;
                    if ((alu_result[31]==0 && src1[31]==1 && src2[31]==1)||(alu_result[31]==1 && src1[31]==0 && src2[31]==0))
                          Overflow <= 1;
                    else Overflow <= 0;
                end 
                `SUB : begin  
                    alu_result <= src1 - src2;
                    if ((alu_result[31]==0 && src1[31]==1 && src2[31]==0)||(alu_result[31]==1 && src1[31]==0 && src2[31]==1))
                          Overflow <= 1;
                    else Overflow <= 0;
                end 
                `AND : alu_result <= src1 & src2;
                `OR : alu_result <= src1 | src2;
                `SLL : alu_result <= src1 << (src2 % 32);
                `SRL : begin
                    if (src1[DataSize-1]) alu_result <= {one, src1} >> (src2 % 32);
                    else alu_result <= src1 >> (src2 % 32);
                end
                `SLT : alu_result <= (src1 < src2) ? 1 : 0;
                `XOR : begin
                    alu_result <= src1 ^ src2;
                    if (src1 == src2) Zero <= 1;
                    else Zero <= 0;
                end
                default : begin
                    alu_result <= 0;
                    Zero <= 0;
                    Overflow <= 0;
                end
            endcase
        end
        else begin
            alu_result = 0;
            Zero = 0;
        end
    end
    
endmodule
