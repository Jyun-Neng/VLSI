//mux4to1.sv

module mux4to1(
    output logic [31:0] Y,
    input [1:0] S,
    input [31:0] I0, I1, I2, I3
);

    always_comb begin
        case (S)
            'd0 : Y = I0;
            'd1 : Y = I1;
            'd2 : Y = I2;
            'd3 : Y = I3;
        endcase
    end
endmodule
