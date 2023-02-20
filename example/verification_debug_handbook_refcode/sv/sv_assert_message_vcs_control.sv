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
endmodule

// simulation result
// "sv_assert_message_vcs_control.sv", 5: tb.ifi0.ast0: started at 0s failed at 0s
// 	Offending 'flag'
// Error: "sv_assert_message_vcs_control.sv", 5: tb.ifi0.ast0: at time 0
// flag not true
// "sv_assert_message_vcs_control.sv", 5: tb.ifi1.ast0: started at 0s failed at 0s
// 	Offending 'flag'
// Error: "sv_assert_message_vcs_control.sv", 5: tb.ifi1.ast0: at time 0
// flag not true




