module tb;
  typedef enum {WRITE, READ, IDLE} op_t;
  class rkv_packet;
    rand int unsigned data [];
    rand byte unsigned addr;
    rand op_t op;
    constraint cstr {
      data.size() inside {[3:5]};
    }
    covergroup cg;
      CP_ADDR: coverpoint addr[1:0] {
        bins addr_00 = {2'b00};
        bins addr_01 = {2'b01};
        bins addr_10 = {2'b10};
        bins addr_11 = {2'b11};
      }
    endgroup
    function new();
      cg = new();
    endfunction
  endclass

  int unsigned darr[];
  rkv_packet pkt;
  initial begin
    darr = new[2];
    darr = '{2{32'h11}};
    darr = {darr, darr};
    pkt = new();
    if(!pkt.randomize() with {data.size == darr.size; foreach(data[i]) data[i] == darr[i]; addr == {6'h30, 2'h0};})
      $error("rkv_packet randomization failure with specific constraint!");
    $finish();
  end
endmodule
