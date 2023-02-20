module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  initial begin
    int count;
    uvm_resource_db#(int)::set("tb","count",10);
    uvm_resource_db#(int)::set("tb","count",20);
    uvm_resource_db#(int)::read_by_name("tb","count",count);
    $display("set-read:: count is %0d", count);
    uvm_resource_db#(int)::set_override("tb","count",30);
    uvm_resource_db#(int)::read_by_name("tb","count",count);
    $display("set_override-read:: count is %0d", count);
  end
endmodule

// simulation result:
// set-read:: count is 10
// set_override-read:: count is 30




