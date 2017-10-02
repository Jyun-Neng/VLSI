/* 
    * File Name : DM.sv
    *
    * Purpose : A 64Kx32 data memory with DM_write ports to enable read (0) or write (1)
    *           data from(to) memory, according the input DM_address port, and the
    *           RAM works only when DM_enable port is enable. All of the data in memory will
    *           reset to 0 if rst port are enable.
    *           
    * Creation Date : 2017/09/28
    *
    * Last Modified : 2017/10/01
    *
    * Create By : Jyun-Neng Ji
    *
*/


module DM(clk, rst, DM_enable, DM_write, DM_address, DM_in, DM_out);
    parameter ADSize = 16;
    parameter DASize = 32;
    parameter DMSize = 17'h10000;

    input clk, rst, DM_write, DM_enable;
    input [ADSize-1:0] DM_address;
    input [DASize-1:0] DM_in;
    output logic [DASize-1:0] DM_out;

    logic [DASize-1:0] mem_data [DMSize-1:0];

    integer i;
    
    always_ff @(negedge clk) begin
        if (rst) 
            for (i=0; i<DMSize; i=i+1)  
                mem_data[i] <= 0;
        else begin
            if (DM_enable) begin
                if (DM_write) mem_data[DM_address] <= DM_in;   // write data
                else  DM_out <= mem_data[DM_address];  // read data
            end 
        end
    end
    endmodule
