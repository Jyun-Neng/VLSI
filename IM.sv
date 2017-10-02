/* 
    * File Name : IM.sv
    *
    * Purpose : A 64Kx32 instruction memory with IM_write ports to enable read (0) or write (1)
    *           data from(to) memory, according the input IM_address port, and the
    *           RAM works only when IM_enable port is enable. All of the data in memory will
    *           reset to 0 if rst port are enable.
    *           
    * Creation Date : 2017/09/29
    *
    * Last Modified : 2017/10/01
    *
    * Create By : Jyun-Neng Ji
    *
*/


module IM(clk, rst, IM_enable, IM_write, IM_address, IM_in, IM_out);
    parameter ADSize = 16;
    parameter DASize = 32;
    parameter IMSize = 17'h10000;

    input clk, rst, IM_write, IM_enable;
    input [ADSize-1:0] IM_address;
    input [DASize-1:0] IM_in;
    output logic [DASize-1:0] IM_out;

    logic [DASize-1:0] mem_data [IMSize-1:0];

    integer i;
    
    always_ff @(negedge clk) begin
        if (rst)   
            for (i=0; i<IMSize; i=i+1)  
                mem_data[i] <= 0;
        else begin
            if (IM_write) mem_data[IM_address] <= IM_in;   // write data
            else  IM_out <= mem_data[IM_address];  // read data
        end
    end
endmodule
