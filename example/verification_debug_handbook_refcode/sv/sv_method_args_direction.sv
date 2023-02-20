module tb;
  function automatic void foo_a(input a, input b, output c);
    c = a + b;
  endfunction

  function automatic void foo_b(int a, int b, output int c, int d);
    c = a + b;
    d = c + 1;
  endfunction

  initial begin
    int val1, val2;
    foo_a(3, 2, val1);
    $display("foo_a(3, 2, val1) -> val1 = %0d", val1);
    foo_b(3, 2, val1, val2);
    $display("foo_b(3, 2, val1, val2) -> val1 = %0d, val2 = %0d", val1, val2);
  end
endmodule

// simulation result:
// foo_a(3, 2, val1) -> val1 = 1
// foo_b(3, 2, val1, val2) -> val1 = 5, val2 = 6
