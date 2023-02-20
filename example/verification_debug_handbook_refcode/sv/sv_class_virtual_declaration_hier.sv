package rkv_pkg;
  class rkv_packet;
    rand int data[];
    constraint cstr{data.size() inside {[2:4]};}
    virtual function string get_name();
      return "rkv_packet";
    endfunction
    function extends_data();
      print_data_size();
      // extend size + 1
      data = new[data.size()+1] (data);
      $display("%s::extends_data() method-1 is called", get_name());
      print_data_size();
    endfunction
    function print_data_size();
      $display("%s::data size is %0d", get_name(), data.size());
    endfunction
  endclass

  class user_packet extends rkv_packet;
    function string get_name();
      return "user_packet";
    endfunction
    virtual function extends_data();
      print_data_size();
      // extend size + 2
      data = new[data.size()+2] (data);
      $display("%s::extends_data() method-2 is called", get_name());
      print_data_size();
    endfunction
  endclass

  class test_packet extends user_packet;
    function string get_name();
      return "test_packet";
    endfunction
    function extends_data();
      // extend size + 3
      super.extends_data();
      data = new[data.size()+1] (data);
      $display("%s::extends_data() method-3 is called", get_name());
      print_data_size();
    endfunction
  endclass
endpackage

module tb;
  import rkv_pkg::*;
  rkv_packet trp;
  user_packet up, tup;
  test_packet tp;
  initial begin
    up = new(); void'(up.randomize());
    tp = new(); void'(tp.randomize());
    trp = up;
    trp.extends_data();
    trp = tp;
    trp.extends_data();
    tup = tp;
    tup.extends_data();
    $finish();
  end
endmodule

// simulation result:
// user_packet::data size is 2
// user_packet::extends_data() method-1 is called
// user_packet::data size is 3
// test_packet::data size is 2
// test_packet::extends_data() method-1 is called
// test_packet::data size is 3
// test_packet::data size is 3
// test_packet::extends_data() method-2 is called
// test_packet::data size is 5
// test_packet::extends_data() method-3 is called
// test_packet::data size is 6
