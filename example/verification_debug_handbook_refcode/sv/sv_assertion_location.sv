package pkg;
  property prop2;
    1;
  endproperty
  //ast_prop2: assert property(prop2); // ERROR location

  class chk;
    // ast_prop2: assert property(pkg::prop2); // ERROR location
    task check();
      //ast_prop2: assert property(pkg::prop2); // ERROR location
      ast_imm2: assert(1);
    endtask
  endclass
endpackage

interface intf;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  property prop1;
    1;
  endproperty
  ast_prop1: assert property(prop1) else `uvm_error("ASSERT", "ERROR")
  ast_prop2: assert property(pkg::prop2) else `uvm_error("ASSERT", "ERROR")
  initial begin
    ast_imm1: assert(1);
  end
endinterface
