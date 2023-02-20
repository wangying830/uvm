module tb;
  wire w1;
  logic r1; // logic (var)
  assign w1 = 1'b1;
  assign r1 = 1'b0;

  wire logic w2; 
  var logic r2;
  assign w2 = 1'b1;
  assign r2 = 1'b0;
  initial begin
    #0;
    $display("w1 = %b, r1 = %b", w1, r1);
    $display("w2 = %b, r2 = %b", w2, r2);
  end
endmodule

// simulation result:
// w1 = 1, r1 = 0
// w2 = 1, r2 = 0
