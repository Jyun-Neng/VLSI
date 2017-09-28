// four_bit_fulladder.sv
`include "one_bit_fulladder.sv"

module four_bit_fulladder(S, C4, A, B, C0);
    input [3:0] A, B;
    input C0;
    output [3:0] S;
    output C4;

    one_bit_fulladder a0(.S(S[0]), .A(A[0]), .B(B[0]), .cin(C0), .cout(C1));
    one_bit_fulladder a1(.S(S[1]), .A(A[1]), .B(B[1]), .cin(C1), .cout(C2));
    one_bit_fulladder a2(.S(S[2]), .A(A[2]), .B(B[2]), .cin(C2), .cout(C3));
    one_bit_fulladder a3(.S(S[3]), .A(A[3]), .B(B[3]), .cin(C3), .cout(C4));
    
endmodule
