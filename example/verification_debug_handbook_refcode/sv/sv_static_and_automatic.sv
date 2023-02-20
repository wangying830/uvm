package rkv_pkg;
  class rkv_packet;
    int data[];
    static local int _id;
    function new();
      _id++;
    endfunction
    static function int get_id();
      return _id;
    endfunction
  endclass

endpackage

module tb;
  import rkv_pkg::*;
  rkv_packet pkts[];
  function int static_increment(int n = 1);
    static int value = 0;
    value += n;
    $display("static_increment result is %0d with n = %0d", value, n);
    return value;
  endfunction

  function automatic int auto_increment(int n = 1);
    int value = 0;
    value += n;
    $display("auto_increment result is %0d with n = %0d", value, n);
    return value;
  endfunction

  initial begin 
    pkts = new[3];
    foreach(pkts[i]) begin
      if(i>0)
        $display("pkts[%0d] id is %0d", i-1, rkv_packet::get_id());
      pkts[i] = new();
      $display("pkts[%0d] id is %0d", i, pkts[i].get_id());
    end
    repeat(3) begin
      static_increment($urandom_range(1, 4));
      auto_increment($urandom_range(1, 4));
    end
  end
endmodule

// simulation result:
// pkts[0] id is 1
// pkts[0] id is 1
// pkts[1] id is 2
// pkts[1] id is 2
// pkts[2] id is 3
// static_increment result is 3 with n = 3
// auto_increment result is 1 with n = 1
// static_increment result is 5 with n = 2
// auto_increment result is 3 with n = 3
// static_increment result is 9 with n = 4
// auto_increment result is 4 with n = 4

