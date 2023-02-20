module tb;
  bit [31:0] v1 = 32'h11223344;
  int idx1 = 31, idx2 = 24;
  initial begin
      // Error slice
      //$display("v1 high 1st byte is 8'h%0x", v1[idx1 : idx2]);
      // Error slice
      //$display("v1 high 1st byte is 8'h%0x", v1[idx1 : idx1-7]);
      // Correct slice
      $display("v1 high 1st byte is 8'h%0x", v1[idx1 -: 8]);
      // Correct slice
      $display("v1 high 1st byte is 8'h%0x", v1 >> idx2);
  end
endmodule

// simulation result:
// v1 high 1st byte is 8'h11
// v1 high 1st byte is 8'h11
