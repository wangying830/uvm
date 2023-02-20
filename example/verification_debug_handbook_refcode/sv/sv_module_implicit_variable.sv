module mod(
  input logic [3:0] in0
  ,input logic [3:0] in1
  ,output logic [3:0] out
  );
  assign out = in0 + in1;
endmodule

module tb;
  logic [3:0] val1;
  logic [3:0] val2;
  // imlicit 1-bit variable declared 
  mod m0(val1, val2, out);
  // 4-bit variable explicitly declared but too late (no effect)
  logic [3:0] out; 
  initial begin
    #1ns val1 = 'h1; val2 = 'h1;
    #1ns val1 = 'h2; val2 = 'h1;
    #1ns val1 = 'h3; val2 = 'h2;
    #1ns $finish();
  end
  always_comb begin
    $display("val1 = 'h%0x, val2 = 'h%0x, out = 'h%0x", val1, val2, out);
  end
endmodule

// compilation log:
// Warning-[PCWM-W] Port connection width mismatch
// The following 1-bit expression is connected to 4-bit port "out" of module "mod", instance "m0".

// simulation result:
// val1 = 'hx, val2 = 'hx, out = 'hx
// val1 = 'h1, val2 = 'h1, out = 'h0
// val1 = 'h2, val2 = 'h1, out = 'h1
// val1 = 'h3, val2 = 'h2, out = 'h1

