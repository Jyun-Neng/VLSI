// reg_sipo_32x8.sv

module reg_sipo_32x8(clk, rst, enable, Write, Read, DIN, Read_ADDR, Write_ADDR, OUT_1, OUT_2, OUT_3);
    parameter ADSize = 5;
    parameter REGSize = 32;
    parameter DASize = 8;

    input clk, rst, enable, Write, Read;
    input [DASize-1:0] DIN;
    input [ADSize-1:0] Read_ADDR, Write_ADDR;
    output logic [DASize-1:0] OUT_1, OUT_2, OUT_3;

    logic [DASize-1:0] Regfile [REGSize-1:0];
    integer i;

    always_ff @(posedge clk, posedge rst) begin
        if (rst)    // reset register file
            for (i = 0; i < REGSize; i = i + 1) Regfile[i] <= 'd0;
        else begin
            CHECK_READ_WRITE: assert(!(Write && Read && enable)) else $display ("Read and Write should not be enable at the same time.");   // assertion

            if (enable) begin
                if (Write) Regfile[Write_ADDR] <= DIN;  // write enable
                else if (Read) begin    // read enable
                    OUT_1 <= Regfile[Read_ADDR];
                    OUT_2 <= Regfile[Read_ADDR+1];
                    OUT_3 <= Regfile[Read_ADDR+2];
                end
            end
        end
    end
 
endmodule
