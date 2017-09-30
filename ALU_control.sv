/* 
    * File Name : ALU_control.sv 
    *
    * Purpose : An ALU control unit. Control ALU operation type. 
    *           
    * Creation Date : 2017/09/30
    *
    * Last Modified : 2017/09/30
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

module ALU_control(
    input [6:0] funct7,
    input [2:0] funct3,
    input [1:0] ALUOp,
    output logic [3:0] ALUType
);
    logic [3:0] _funct, funct;

    always_comb begin   // While funct3 is 'b000, doing this case.
        case (funct7)
            'b0000000 : _funct = `ADD;
            'b0100000 : _funct = `SUB;
            default : _funct = `NDEF;
        endcase
    end

    always_comb begin   // While ALUOp is 'b00, doing this case.
        case (funct3)
            'b000 : funct = _funct;
            'b001 : funct = `SLL;
            'b010 : funct = `SLT;
            'b100 : funct = `XOR;
            'b101 : funct = `SRL;
            'b110 : funct = `OR;
            'b111 : funct = `AND;
            default : funct = `NDEF;
        endcase
    end    

    always_comb begin
        case (ALUOp)
            'b00 : ALUType = funct;
            'b01 : ALUType = `ADD;
            'b10 : ALUType = `XOR;
            'b11 : ALUType = `NDEF;
        endcase        
    end

endmodule
