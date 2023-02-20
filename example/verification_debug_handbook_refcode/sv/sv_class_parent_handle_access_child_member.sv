package rkv_pkg;
  class rkv_packet;
    int data = 'h10;
    int addr = 'h20;
  endclass

  class user_packet extends rkv_packet;
    int ufield = 'h30;
  endclass
endpackage

module tb;
  import rkv_pkg::*;
  rkv_packet trp;
  user_packet up, tup;
  initial begin
    up = new();
    trp = up;
    $display("trp -> up could access data 'h%0x, addr 'h%0x", trp.data, trp.addr);
    void'($cast(tup, trp));
    $display("tup -> up could access data 'h%0x, addr 'h%0x, ufield 'h%0x", tup.data, tup.addr, tup.ufield);
  end
endmodule

// simulation result:
// trp -> up could access data 'h10, addr 'h20
// tup -> up could access data 'h10, addr 'h20, ufield 'h30
