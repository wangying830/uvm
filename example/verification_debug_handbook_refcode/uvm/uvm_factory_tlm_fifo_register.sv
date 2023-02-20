package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class user_fifo_str extends uvm_tlm_fifo #(string);
    `uvm_component_utils(user_fifo_str)
    function new(string name = "user_fifo_str", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass

  class tlm_fifo_register_test extends uvm_test;
    user_fifo_str fifo0;
    `uvm_component_utils(tlm_fifo_register_test)
    function new(string name = "tlm_fifo_register_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      fifo0 = user_fifo_str::type_id::create("fifo0", this);
    endfunction
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("tlm_fifo_register_test");
endmodule

