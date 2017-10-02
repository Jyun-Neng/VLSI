/* 
    * File Name : CPU.sv 
    *
    * Purpose : A RISC-V pipeline CPU.
    *           
    * Creation Date : 2017/10/01
    *
    * Last Modified : 2017/10/02
    *
    * Create By : Jyun-Neng Ji
    *
*/

`include "RegFile.sv"
`include "control.sv"
`include "ALU_control.sv"
`include "SignExten.sv"    
`include "ALU.sv"    
`include "mux2to1.sv" 
`include "mux4to1.sv"

module CPU(
    input rst, clk,
    input [31:0] IM_out, DM_out,
    output logic IM_en, DM_en, DM_write,
    output logic [31:0] DM_in, DM_address, IM_address
);
    
    logic [31:0] PC, instr, ID_PC, ID_PC4, EXE_OUT_1, EXE_OUT_2, EXE_imm_out, EXE_PC4, EXE_PC,
                 MEM_alu_result, MEM_OUT_2, MEM_imm_out, MEM_PC4, MEM_PC_jb,
                 WB_DM_out, WB_alu_result, WB_imm_out, WB_PC4;
    logic [1:0] EXE_ALUOp, EXE_MemtoReg, MEM_MemtoReg, WB_MemtoReg;
    logic [2:0] EXE_funct3;
    logic [6:0] EXE_funct7;
    logic [4:0] EXE_Write_ADDR, MEM_Write_ADDR, WB_Write_ADDR;
    logic EXE_ALUSrc, EXE_branch, EXE_jump, EXE_DM_write, EXE_DM_en, EXE_RegWrite,
          MEM_branch, MEM_jump, MEM_DM_write, MEM_DM_en, MEM_RegWrite, MEM_Zero,
          WB_RegWrite;

    wire [31:0] PC4, next_PC, ID_imm_out, ID_OUT_1, ID_OUT_2, src2, EXE_alu_result, WB_DIN;
    wire [6:0] OP;
    wire [4:0] ID_Read_ADDR_1, ID_Read_ADDR_2;
    wire [24:0] ID_imm_in;
    wire [2:0] ID_ExtenSel;
    wire [3:0] ALUType;
    wire [1:0] ID_ALUOp, ID_MemtoReg, ALUOp;
    wire ID_jump, ID_branch, ID_RegWrite, ID_DM_write, ID_DM_en, ID_ALUSrc, EXE_Zero, MEM_branch_con, MEM_PC_MUX;
    
    // IF Stage
    assign IM_address = PC;
    assign PC4 = PC + 4;

    always_ff @(posedge clk) begin
        if (rst) begin
            ID_PC <= 0; PC <= 0; ID_PC4 <= 0; instr <= 0;    
        end 
        else  begin 
            PC <= next_PC;
            ID_PC4 <= PC4;
            ID_PC <= PC;
            instr <= IM_out;
        end 
    end
    // ID Stage
    RegFile RF1 (.OUT_1(ID_OUT_1), .OUT_2(ID_OUT_2), .RegWrite(WB_RegWrite), .Read_ADDR_1(ID_Read_ADDR_1), .Read_ADDR_2(ID_Read_ADDR_2),
                .Write_ADDR(WB_Write_ADDR), .DIN(WB_DIN), .clk(clk), .rst(rst));

    control C1 (.OP(OP), .DM_write(ID_DM_write), .DM_en(ID_DM_en), .RegWrite(ID_RegWrite), .branch(ID_branch), .jump(ID_jump), .ALUSrc(ID_ALUSrc), 
                .MemtoReg(ID_MemtoReg), .ALUOp(ID_ALUOp), .ExtenSel(ID_ExtenSel), .rst(rst));

    SignExten S1 (.ExtenSel(ID_ExtenSel), .imm_in(ID_imm_in), .imm_out(ID_imm_out));

    assign OP = instr[6:0];
    assign ID_Read_ADDR_1 = instr[19:15];
    assign ID_Read_ADDR_2 = instr[24:20];
    assign ID_imm_in = instr[31:7];

    always_ff @(posedge clk) begin
        if (rst) begin
            EXE_DM_en <= 0; EXE_jump <= 0; EXE_branch <= 0; EXE_RegWrite <= 0;
        end
        else begin 
            // control
            EXE_ALUSrc <= ID_ALUSrc;
            EXE_ALUOp <= ID_ALUOp;
            EXE_branch <= ID_branch;
            EXE_jump <= ID_jump;
            EXE_DM_write <= ID_DM_write;
            EXE_DM_en <= ID_DM_en;
            EXE_MemtoReg <= ID_MemtoReg;
            EXE_RegWrite <= ID_RegWrite;
            EXE_funct3 <= instr[14:12];
            EXE_funct7 <= instr[31:25];
            // data
            EXE_PC4 <= ID_PC4;
            EXE_PC <= ID_PC;
            EXE_OUT_1 <= ID_OUT_1;
            EXE_OUT_2 <= ID_OUT_2;
            EXE_imm_out <= ID_imm_out;
            EXE_Write_ADDR <= instr[11:7];
        end 
    end
    // EXE Stage
    mux2to1 M0 (.Y(src2), .S(EXE_ALUSrc), .I0(EXE_OUT_2), .I1(EXE_imm_out));

    ALU_control AC1 (.funct7(EXE_funct7), .funct3(EXE_funct3), .ALUOp(EXE_ALUOp), .ALUType(ALUType));

    ALU A1 (.Zero(EXE_Zero), .alu_result(EXE_alu_result), .src1(EXE_OUT_1), .src2(src2), .ALUType(ALUType), .rst(rst));

    always_ff @(posedge clk) begin
        if (rst) begin
            MEM_DM_en <= 0; MEM_jump <= 0; MEM_branch <= 0; MEM_RegWrite <= 0;
        end
        else begin 
            // control
            MEM_branch <= EXE_branch;
            MEM_jump <= EXE_jump;
            MEM_DM_write <= EXE_DM_write;
            MEM_DM_en <= EXE_DM_en;
            MEM_MemtoReg <= EXE_MemtoReg;
            MEM_RegWrite <= EXE_RegWrite;
            // data
            MEM_alu_result <= EXE_alu_result;
            MEM_OUT_2 <= EXE_OUT_2;
            MEM_PC4 <= EXE_PC4;
            MEM_PC_jb <= EXE_imm_out + EXE_PC;
            MEM_Zero <= EXE_Zero ^ EXE_funct3[0];
            MEM_imm_out <= EXE_imm_out;
            MEM_Write_ADDR <= EXE_Write_ADDR; 
        end 
    end
    // MEM Stage
    mux2to1 M1 (.Y(next_PC), .S(MEM_PC_MUX), .I0(PC4), .I1(MEM_PC_jb));

    assign DM_address = MEM_alu_result;
    assign DM_in = MEM_OUT_2;
    assign DM_write = MEM_DM_write;
    assign DM_en = MEM_DM_en;
    assign MEM_branch_con = MEM_Zero & MEM_branch;
    assign MEM_PC_MUX = MEM_jump ^ MEM_branch_con;
    
    always_ff @(posedge clk) begin
        if (rst) WB_RegWrite <= 0;
        else begin 
            // control
            WB_MemtoReg <= MEM_MemtoReg;
            WB_RegWrite <= MEM_RegWrite;
            // data
            WB_DM_out <= DM_out;
            WB_alu_result <= MEM_alu_result;
            WB_imm_out <= MEM_imm_out;
            WB_PC4 <= MEM_PC4;
            WB_Write_ADDR <= MEM_Write_ADDR;
        end 
    end
    // WB Stage
    mux4to1 M2 (.Y(WB_DIN), .S(WB_MemtoReg), .I0(WB_DM_out), .I1(WB_alu_result), .I2(WB_imm_out), .I3(WB_PC4));

endmodule
