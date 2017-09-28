// one_bit_fulladder.sv

module one_bit_fulladder(S, cout, A, B, cin);
    input A, B, cin;
    output S, cout;

    assign {cout, S} = A + B + cin;

endmodule
