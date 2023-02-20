package rkv_pkg;
  class rkv_data;
    int data = 10;
    function new(int val = 1);
      data = val;
    endfunction
  endclass

  class rkv_trans extends rkv_data;
    int num = 5;
    int darr[];
    function new(int val = 2);
      super.new(val);
      num = 3;
      darr = new[num];
      foreach(darr[i]) darr[i] = data;
    endfunction
  endclass
endpackage

module tb;
  import rkv_pkg::*;
  rkv_trans t;
  initial begin
    t = new(3);
    $display("rkv_trans t.num = %0d", t.num);
    $display("rkv_trans t.data = %0d", t.data);
    $display("rkv_trans t.darr = %p", t.darr);
    $finish();
  end
endmodule

// simulation result:
// rkv_trans t.num = 3
// rkv_trans t.data = 3
// rkv_trans t.darr = '{3, 3, 3}
