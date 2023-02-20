package rkv_pkg;
  class rkv_packet;
    int obj_id;
    static int _id = 0;
    function new(string tname = "rkv_packet");
      if(tname == "rkv_packet") begin
        obj_id = _id;
        _id++;
      end
    endfunction
    virtual function int get_id();
      return obj_id;
    endfunction
    virtual function string get_name();
      return "rkv_packet";
    endfunction
  endclass

  class user_packet extends rkv_packet;
    static int _id = 0;
    function new(string tname = "user_packet");
      super.new(tname);
      if(tname == "user_packet") begin
        obj_id = _id;
        _id++;
      end
    endfunction
    virtual function string get_name();
      return "user_packet";
    endfunction
  endclass
endpackage

module tb;
  import rkv_pkg::*;
  parameter RP_NUM = 3;
  parameter UP_NUM = 5;
  rkv_packet rp[RP_NUM], trp;
  user_packet up[UP_NUM], tup;
  initial begin
    foreach(rp[i]) rp[i] = new();
    foreach(up[i]) up[i] = new();
    tup = up[1];
    $display("tup -> up[1] with name [%s] id [%0d]", tup.get_name() ,tup.get_id());
    trp = up[2];
    $display("trp -> up[2] with name [%s] id [%0d]", trp.get_name() ,trp.get_id());
    assert($cast(tup, trp))
    else $error("type casting failure!");
    $display("tup -> up[2] with name [%s] id [%0d]", tup.get_name() ,tup.get_id());
    $finish();
  end
endmodule

// simulation result:
// tup -> up[1] with name [user_packet] id [1]
// trp -> up[2] with name [user_packet] id [2]
// tup -> up[2] with name [user_packet] id [2]
