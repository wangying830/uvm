module tb;
  bit[7:0] q[$];
  initial begin
    q = {8'hF, 8'h7, 8'hF, 8'h7};
    // compilation error:
    // type of source expression is incompatible with type of target expression
    // q = 32'h0F070F07;
  end
endmodule
