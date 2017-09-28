/* 
    * File Name : RAM.sv
    *
    * Purpose : A 16x16 RAM with read and write enable ports to enable read or write
    *           data from(to) RAM, according the input address port.
    *           
    * Creation Date : 2017/09/28
    *
    * Last Modified : 2017/09/28
    *
    * Create By : Jyun-Neng Ji
    *
*/


module RAM(clk, rst, en_read, en_write, addr, DMin, DMout);
    parameter ADSize = 4;
    parameter DASize = 16;
    parameter RAMSize = 16;

    input clk, rst, en_read, en_write;
    input [ADSize-1:0] addr;
    input [DASize-1:0] DMin;
    output logic [DASize-1:0] DMout;

    logic [DASize-1:0] RAM_Data [RAMSize-1:0];

    integer i;
    
    always_ff @(posedge clk) begin
        if (rst) 
            for (i=0; i<RAMSize; i=i+1) RAM_Data[i] <= 0;
        else begin
            CHECK_READ_WRITE: assert (!(en_read && en_write)) else $display ("Read and Write should not be enable at the same time.");  // assertion
            
            if (en_write) RAM_Data[addr] <= DMin;
            else if (en_read) DMout <= RAM_Data[addr];
            else DMout <= 'bZ;
        end
    end
endmodule
