/* 
    * File Name : SignExten.sv
    *
    * Purpose : A sign extension unit
    *           
    * Creation Date : 2017/10/01
    *
    * Last Modified : 2017/10/01
    *
    * Create By : Jyun-Neng Ji
    *
*/

`define I_TYPE 'b000
`define S_TYPE 'b001
`define B_TYPE 'b010
`define U_TYPE 'b011
`define J_TYPE 'b100

module SignExten(
    input [2:0] ExtenSel,
    input [24:0] imm_in,
    output logic [31:0] imm_out
);
    always_comb begin
        case (ExtenSel)
           `I_TYPE : imm_out = (imm_in[24]) ? {20'hfffff, imm_in[24:13]} : {20'h00000, imm_in[24:13]};
           `S_TYPE : imm_out = (imm_in[24]) ? {20'hfffff, imm_in[24:18], imm_in[4:0]} : {20'h00000, imm_in[24:18], imm_in[4:0]};
           `B_TYPE : imm_out = (imm_in[24]) ? {19'b1111111111111111111, imm_in[24], imm_in[0], imm_in[23:18], imm_in[4:1], 1'b0}
                                           : {19'b0000000000000000000, imm_in[24], imm_in[0], imm_in[23:18], imm_in[4:1], 1'b0};
           `U_TYPE : imm_out = {imm_in[24:5], 12'h000};
           `J_TYPE : imm_out = (imm_in[24]) ? {11'b11111111111, imm_in[24], imm_in[12:5], imm_in[13], imm_in[23:14], 1'b0} 
                                           : {11'b00000000000, imm_in[24], imm_in[12:5], imm_in[13], imm_in[23:14], 1'b0};
            default : imm_out = 0;
        endcase
    end
endmodule
