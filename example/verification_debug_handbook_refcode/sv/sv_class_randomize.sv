package rkv_pkg;
  class packet;
    rand bit [31:0] src;
    rand logic [31:0] dst;
    rand int unsigned data [8];
    randc byte unsigned kind;
    byte unsigned addr;
    constraint cstr {
      src inside {[10:15]};
    }
  endclass
endpackage

module tb;
  import rkv_pkg::*;
  packet p;
  initial begin
    p = new();
    p.cstr.constraint_mode(0);
    assert(p.randomize(addr) with {addr[1:0] == 0; addr inside{['h4:'h10]};})
    else
      $error("packet randomization failure!");
    $finish();
  end
endmodule
