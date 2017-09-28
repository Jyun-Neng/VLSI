//mux4to1.sv
`include "mux2to1.sv"

module mux4to1(Y, S, I);
    output Y;
    input [1:0] S;
    input [3:0] I;
    logic y0, y1;

    mux2to1 M0(.Y(y0), .S(S[0]), .I0(I[0]), .I1(I[1]));
    mux2to1 M1(.Y(y1), .S(S[0]), .I0(I[2]), .I1(I[3]));
    mux2to1 M2(.Y(Y), .S(S[1]), .I0(y0), .I1(y1));
    
endmodule
