package rkv_pkg;
  typedef class packet2;
  class packet1;
    packet2 pkt2;
  endclass
  class packet2;
    packet1 pkt1;
  endclass
endpackage

module tb;
  rkv_pkg::packet1 pkt1;
  rkv_pkg::packet2 pkt2;
  initial begin
    pkt1 = new();
    pkt2 = new();
  end
endmodule
