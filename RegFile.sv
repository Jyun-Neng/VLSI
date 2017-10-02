/* 
    * File Name : RegFile.sv
    *
    * Purpose : A 32x32 bits register file with the data of the first register
    *           is always 0. While RegWrite port enable, it writes data from DIN
    *           into the register, according the Write_ADDR. It reads data 
    *           from the register, according the Read_ADDR, to
    *           OUT_1 and OUT_2.
    *           
    * Creation Date : 2017/09/29
    *
    * Last Modified : 2017/09/29
    *
    * Create By : Jyun-Neng Ji
    *
*/


module RegFile(OUT_1, OUT_2, RegWrite, Read_ADDR_1, Read_ADDR_2, Write_ADDR, DIN, clk, rst);
    parameter ADSize = 5;
    parameter REGSize = 32;
    parameter DASize = 32;   

    input clk, rst, RegWrite;
    input [DASize-1:0] DIN;
    input [ADSize-1:0] Read_ADDR_1, Read_ADDR_2, Write_ADDR;
    output logic [DASize-1:0] OUT_1, OUT_2;

    logic [DASize-1:0] mem [REGSize-1:0];
    integer i;

    always_ff @(negedge clk, posedge rst) begin
        if (rst)    // reset register file
            for (i = 0; i < REGSize; i = i + 1) mem[i] <= 'd0;
        else begin
            CHEK_WRITE_ADDR: assert (!(RegWrite && (Write_ADDR == 0) && (DIN != 'd0))) else $display ("Cannot write data to register x0."); // assertion
            if (RegWrite) 
                if (Write_ADDR != 0 ) mem[Write_ADDR] <= DIN;  // write enable
            OUT_1 <= mem[Read_ADDR_1];
            OUT_2 <= mem[Read_ADDR_2];
        end
    end
    
endmodule

