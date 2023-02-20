package rkv_pkg;
  `include "sv_include_import.svh"
endpackage

package test_pkg;
  import rkv_pkg::rkv_transaction;
  class rkv_test;
    rand rkv_transaction trans[];
    constraint cstr {trans.size inside {[4:6]};}
    function void post_randomize();
      foreach(trans[i]) begin
        trans[i] = new();
        void'(trans[i].randomize());
      end
    endfunction
  endclass
endpackage

module tb;
  import rkv_pkg::rkv_transaction;
  import test_pkg::rkv_test;

  rkv_transaction tr;
  rkv_test test;

  initial begin
    test = new();
    void'(test.randomize());
    foreach(test.trans[i]) begin
      tr = test.trans[i];
      $display("test.trans[%0d].pkts dynamic array size is %0d", i, tr.pkts.size());
    end
    $finish();
  end
endmodule

// simulation result:
// test.trans[0].pkts dynamic array size is 3
// test.trans[1].pkts dynamic array size is 5
// test.trans[2].pkts dynamic array size is 5
// test.trans[3].pkts dynamic array size is 5
