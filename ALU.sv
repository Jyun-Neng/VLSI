// ALU.sv

module ALU(Overflow, alu_result, src1, src2, OP, enable);
    parameter DataSize = 32;
    parameter ALUopSize = 3;
       
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
                3'b000 : begin  // ADD src1, src2
                    alu_result = src1 + src2;
                    if ((alu_result[31]==0 && src1[31]==1 && src2[31]==1)||(alu_result[31]==1 && src1[31]==0 && src2[31]==0))
                        Overflow = 1;
                    else Overflow = 0;
                end
                3'b001 : begin  // SUB src1, src2
                    alu_result = src1 - src2;
                    if ((alu_result[31]==0 && src1[31]==1 && src2[31]==0)||(alu_result[31]==1 && src1[31]==0 && src2[31]==1))
                        Overflow = 1;
                    else Overflow = 0;
                end
                3'b010 : begin  // AND src1, src2
                    alu_result = src1 & src2;
                    Overflow = 0;
                end
                3'b011 : begin  // OR src1, src2
                    alu_result = src1 | src2;
                    Overflow = 0;
                end
                3'b100 : begin  // SLL src1, src2
                    alu_result = src1 << src2;
                    Overflow = 0;
                end
                3'b101 : begin  // Right rotate
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
