package rkv_pkg;
  class rkv_packet;
    virtual function string get_name();
      return "rkv_packet";
    endfunction
  endclass

  class user_packet extends rkv_packet;
    function string get_name();
      return "user_packet";
    endfunction
  endclass
endpackage

module tb;
  import rkv_pkg::*;
  rkv_packet rp;
  user_packet up;
  initial begin
    up = new();
    rp = up;
    $display("up -> user_packet instance and got name [%s]", up.get_name());
    $display("rp -> user_packet instance and got name [%s]", rp.get_name());
    $finish();
  end
endmodule

// simulation result:
// up -> user_packet instance and got name [user_packet]
// rp -> user_packet instance and got name [user_packet]
