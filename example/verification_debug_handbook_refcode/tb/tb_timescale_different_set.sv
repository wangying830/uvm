module rkv_mod1;
  timeunit 1ps;
  timeprecision 1ps;
  initial begin
    $printtimescale();
    #5;
    $display("Current time is %0t", $time);
  end
endmodule

module rkv_mod2;
  timeunit 1ns;
  timeprecision 1ps;
  initial begin
    $printtimescale();
    #5;
    $display("Current time is %0t", $time);
  end
endmodule

module rkv_mod3;
  initial begin
    // timescale is achieved from default or configured while compiling
    $printtimescale();
    #5;
    $display("Current time is %0t", $time);
  end
endmodule

`timescale 100ps/1ps
module tb;
  rkv_mod1 m1();
  rkv_mod2 m2();
  rkv_mod3 m3();
  initial begin
    // specify time display format
    $timeformat(-12, 2, "ps", 10);
    #5;
    $display("Current time is %0t", $time);
  end
endmodule

// simulation result (compiled timescale option -timescale=10ps/1ps): 
// TimeScale of rkv_mod1 is 1 ps / 1 ps 
// TimeScale of rkv_mod2 is 1 ns / 1 ps 
// TimeScale of rkv_mod3 is 10 ps / 1 ps 
// Current time is 5.00ps
// Current time is 50.00ps
// Current time is 500.00ps
// Current time is 5000.00ps
