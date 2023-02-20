module mod;
  int data1;
  int data2;
  int addr;
  int cmd;
endmodule
module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  //`include "uvm_force_hdl_test.sv"
  mod m();
  initial run_test("force_hdl_test");
  initial #1ns $display("m.data1 = %0d, m.data2 = %0d, m.addr = %0d, m.cmd = %0d",
                         m.data1, m.data2, m.addr, m.cmd);
  int cmd;
  initial $hdl_xmr("tb.m.cmd", "cmd");
endmodule

// simulation result:
// m.data1 = 10, m.data2 = 11, m.addr = 20, m.cmd = 30
