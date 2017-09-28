/* 
    * File Name : ALU.sv
    *
    * Purpose : Make an ALU component with two 32 bits data input ports (sr1, sr2),
    *           one 4 bits control port (OP), one 1 bit enable port (enable),
    *           one 32 bits data output port (alu_result), and one 1 bit
    *           overflow detection port (Overflow). And it can do 6 operations.
    *           Addition, substraction, bitwise and, bitwise or, shift left,
    *           and rotate.
    *
    * Creation Date : 2017/09/27
    *
    * Last Modified : 2017/09/28
    *
    * Create By : Jyun-Neng Ji
    *
*/

`define ADD 4'b0000
`define SUB 4'b0001
`define AND 4'b0010
`define OR 4'b0011
`define SLL 4'b0100
`define ROTATE 4'b0101

module ALU(Overflow, alu_result, src1, src2, OP, enable);
    parameter DataSize = 32;
    parameter ALUopSize = 4;
       
    input [DataSize-1:0] src1, src2;
    input [ALUopSize-1:0] OP;
    input enable;
    output logic [DataSize-1:0] alu_result;
    output logic Overflow;
    
    logic [2*DataSize-1:0] temp;

    assign temp = {src1, src1} >> (src2 % 32);

    always_comb begin
        if (enable) begin
            case (OP)
                `ADD : begin  // ADD src1, src2
                    alu_result = src1 + src2;
                    if ((alu_result[31]==0 && src1[31]==1 && src2[31]==1)||(alu_result[31]==1 && src1[31]==0 && src2[31]==0))
                        Overflow = 1;
                    else Overflow = 0;
                end
                `SUB : begin  // SUB src1, src2
                    alu_result = src1 - src2;
                    if ((alu_result[31]==0 && src1[31]==1 && src2[31]==0)||(alu_result[31]==1 && src1[31]==0 && src2[31]==1))
                        Overflow = 1;
                    else Overflow = 0;
                end
                `AND : begin  // AND src1, src2
                    alu_result = src1 & src2;
                    Overflow = 0;
                end
                `OR : begin  // OR src1, src2
                    alu_result = src1 | src2;
                    Overflow = 0;
                end
                `SLL : begin  // SLL src1, src2
                    alu_result = src1 << src2;
                    Overflow = 0;
                end
                `ROTATE : begin  // Right rotate src1
                    alu_result = temp[31:0];
                    Overflow = 0;       
                end
                default : begin
                    alu_result = 0;
                    Overflow = 0;
                end
            endcase
        end
        else begin
            alu_result = 0;
            Overflow = 0;
        end
    end
    
endmodule
