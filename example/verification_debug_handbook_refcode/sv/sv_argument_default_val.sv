module tb;
  class rkv_packet;
    local int _data;
    function void set_data(input int val, input bit reverse = 0);
      _data = reverse ? val : (0 - val);
      $display("rkv_packet::set_data(.val(%0d), .reverse(%0d)) is called", val, reverse);
    endfunction
    function int get_data();
      return _data;
    endfunction
  endclass
  class user_packet extends rkv_packet;
    function void set_data(input int val, input bit reverse = 0, input bit double = 0);
      if(double) val = 2 * val;
      super.set_data(val, reverse);
      $display("user_packet::set_data(.val(%0d), .reverse(%0d), .double(%0d)) is called", val, reverse, double);
    endfunction
  endclass

  rkv_packet rp;
  user_packet up;
  initial begin
    rp = new();
    rp.set_data(100, -1);
    $display("rp.data is %0d", rp.get_data());
    up = new();
    up.set_data(200, -1);
    $display("up.data is %0d", up.get_data());
    $finish();
  end
endmodule

// simulation result:
// rkv_packet::set_data(.val(100), .reverse(1)) is called
// rp.data is 100
// rkv_packet::set_data(.val(200), .reverse(1)) is called
// user_packet::set_data(.val(200), .reverse(1), .double(0)) is called
// up.data is 200
