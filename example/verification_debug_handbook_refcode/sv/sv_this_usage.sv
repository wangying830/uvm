package rkv_pkg;
  class rkv_packet;
    rand int unsigned data;
    rand int unsigned addr;
    function new();
      this.data = 0;
      this.addr = 0;
    endfunction
  endclass

  class user_packet extends rkv_packet;
    function int unsigned set_data(int unsigned data);
      this.data = data;
    endfunction
    function int unsigned get_data();
      return this.data;
    endfunction
  endclass
endpackage

module tb;
  import rkv_pkg::*;
  user_packet up;
  initial begin
    int unsigned data = 100;
    int unsigned addr = 'h10;
    up = new();
    assert(up.randomize() with {this.data == local::data; this.addr == local::addr;})
    else $error("user_packet randomization failure");
    $display("up.data = %0d, up.addr = 'h%0x", up.data, up.addr);
    $finish();
  end
endmodule

// simulation result:
// up.data = 100, up.addr = 'h10
