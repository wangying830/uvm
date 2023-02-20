package rkv_pkg;
  class packet;
    int data[];
    function new(int size);
      data = new[size];
    endfunction
  endclass
  class user_packet extends packet;
    // subclass needs to define newe() and call super.new
    function new(int size);
      super.new(size);
    endfunction
  endclass
endpackage

module tb;
  import rkv_pkg::*;
  user_packet up;
  initial begin
    up = new(3);
  end
endmodule
