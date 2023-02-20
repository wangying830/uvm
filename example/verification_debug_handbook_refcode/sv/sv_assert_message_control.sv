interface intf;
  bit flag = 0;
  initial begin 
    #1ns;
    ast0: assert(flag)
    else $error("flag not true");
  end
endinterface
module tb;
  intf ifi0();
  intf ifi1();
  bit flag = 0;
  initial begin 
    #1ns;
    ast0: assert(flag)
    else $error("flag not true");
  end
  initial begin
    $assertoff(0);
    $asserton(0, ifi0);
    $asserton(0, ifi1.ast0);
  end
endmodule

// simulation result:
// Stopping new assertion attempts at time 0ps: level = 0 arg = * (from inst tb (sv_assert_message_control.sv:19))
// Starting assertion attempts at time 0ps: level = 0 arg = tb.ifi0 (from inst tb (sv_assert_message_control.sv:20))
// Starting assertion attempts at time 0ps: level = 0 arg = ifi1.ast0 (from inst tb (sv_assert_message_control.sv:21))
// "sv_assert_message_control.sv", 5: tb.ifi0.ast0: started at 1000ps failed at 1000ps
// 	Offending 'flag'
// Error: "sv_assert_message_control.sv", 5: tb.ifi0.ast0: at time 1000 ps
// flag not true
// "sv_assert_message_control.sv", 5: tb.ifi1.ast0: started at 1000ps failed at 1000ps
// 	Offending 'flag'
// Error: "sv_assert_message_control.sv", 5: tb.ifi1.ast0: at time 1000 ps
// flag not true
