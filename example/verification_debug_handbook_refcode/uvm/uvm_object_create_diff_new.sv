package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_comp extends uvm_component;
    `uvm_component_utils(rkv_comp)
    function new(string name = "rkv_comp", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void end_of_elaboration_phase(uvm_phase phase);
      `uvm_info("TYPE", $sformatf("%s is created by type %s", get_name(), get_type_name()), UVM_LOW)
    endfunction
  endclass
  class user_comp extends rkv_comp;
    `uvm_component_utils(user_comp)
    function new(string name = "user_comp", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
  class object_create_diff_new_test extends uvm_test;
    rkv_comp c0, c1;
    `uvm_component_utils(object_create_diff_new_test)
    function new(string name = "object_create_diff_new_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      set_type_override("rkv_comp", "user_comp");
      c0 = new("c0", this);
      c1 = rkv_comp::type_id::create("c1", this);
    endfunction
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("object_create_diff_new_test");
endmodule

// simulation result:

