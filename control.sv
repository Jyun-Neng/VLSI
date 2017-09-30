/* 
    * File Name :control.sv 
    *
    * Purpose : A control unit to control CPU.
    *           DM_en: enable data memory,
    *           DM_Write: 1: write data, 0: read data,
    *           branch: enable branch operation,
    *           jump: enable jump operation,
    *           ALUSrc: choose data from sign-exten unit (0) or register file (1),
    *           MemtoReg: choose which data to register file.
    *                     00: data from data memory,
    *                     01: data from ALU result,
    *                     10: data from sign-exten unit,
    *                     11: data from pc+4
    *           RegWrite: enable write data to register file,
    *           ALUOp: 00: operation type according to funct3,
    *                  01: do addition,
    *                  10: do xor operation,
    *                  11: not define,
    *           ExtenSel: choose which bits to do sign extension.
    *                  000: [31:20] 12 bits sign extension,
    *                  001: [31:25|11:7] 12 bits sign extension,
    *                  010: [31|7|30:25|11:8] 12 bits sign extension,
    *                  011: [31:12] 20 bits sign extension,
    *                  100: [31|19:12|20|30:21] 20 bits sign extension,
    *           
    * Creation Date : 2017/09/30
    *
    * Last Modified : 2017/09/30
    *
    * Create By : Jyun-Neng Ji
    *
*/

`define RTYPE 'b0110011
`define ITYPE 'b0010011
`define BTYPE 'b1100011
`define UTYPE 'b0110111
`define JTYPE 'b1101111
`define STYPE 'b0100011
`define ITYPE_LW 'b0000011

module control(
    input [6:0]OP,
    output logic DM_write, DM_en, RegWrite, branch, jump, ALUSrc,
    output logic [1:0] MemtoReg, ALUOp,
    output logic [2:0] ExtenSel
);

    always_comb begin
        case (OP)
            `RTYPE : begin
                DM_en <= 'b0; branch <= 'b0; jump <= 'b0; ALUSrc <= 'b0; MemtoReg <= 'b1; RegWrite <= 'b01; ALUOp <= 'b00;
            end
            `ITYPE : begin 
                DM_en <= 'b0; branch <= 'b0; jump <= 'b0; ALUSrc <= 'b1; MemtoReg <= 'b1; RegWrite <= 'b01; ALUOp <= 'b00; ExtenSel <= 'b000;
            end
            `ITYPE_LW : begin
                DM_en <= 'b1; DM_write <= 'b0; branch <= 'b0; jump <= 'b0; ALUSrc <= 'b1; MemtoReg <= 'b00; RegWrite <= 'b1; ALUOp <= 'b01; ExtenSel <= 'b000;
            end
            `STYPE : begin
                DM_en <= 'b1; DM_write <= 'b1; branch <= 'b0; jump <= 'b0; ALUSrc <= 'b1; RegWrite <= 'b0; ALUOp <= 'b01; ExtenSel <= 'b001;
            end
            `BTYPE : begin
                DM_en <= 'b0; branch <= 'b1; jump <= 'b0; ALUSrc <= 'b0; RegWrite <= 'b0; ALUOp <= 'b10; ExtenSel <= 'b010;
            end
            `UTYPE : begin
                DM_en <= 'b0; branch <= 'b0; jump <= 'b0; MemtoReg <= 'b10; RegWrite <= 'b1; ExtenSel <= 'b011;
            end
            `JTYPE : begin
                DM_en <= 'b0; branch <= 'b0; jump <= 'b1; MemtoReg <= 'b11; RegWrite <= 'b1;  ExtenSel <= 'b100;
            end
        endcase
    end
    
    endmodule
