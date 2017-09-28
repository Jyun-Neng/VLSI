module mux2to1(Y, S, I0, I1);
    input S;
    input [31:0] I0, I1;
    output [31:0] Y;
   
    assign Y = (S==0) ? I0 : I1;
    
endmodule
