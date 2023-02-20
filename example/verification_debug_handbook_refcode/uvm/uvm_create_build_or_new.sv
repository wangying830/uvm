package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_comp extends uvm_component;
    `uvm_component_utils(rkv_comp)
    function new(string name = "rkv_comp", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void end_of_elaboration_phase(uvm_phase phase);
      `uvm_info("TYPE", $sformatf("[%s] type name is [%s]", get_name(), get_type_name()), UVM_LOW)
    endfunction
  endclass
  class user_comp extends rkv_comp;
    `uvm_component_utils(user_comp)
    function new(string name = "user_comp", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
  class create_build_or_new_test extends uvm_test;
    rkv_comp comp0, comp1;
    `uvm_component_utils(create_build_or_new_test)
    function new(string name = "create_build_or_new_test", uvm_component parent = null);
      super.new(name, parent);
      comp0 = rkv_comp::type_id::create("comp0", this);
    endfunction
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // available to override
      set_type_override("rkv_comp", "user_comp");
      comp1 = rkv_comp::type_id::create("comp1", this);
    endfunction
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("create_build_or_new_test");
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test create_build_or_new_test...
// UVM_INFO uvm_create_build_or_new.sv(10) @ 0: uvm_test_top.comp0 [TYPE] [comp0] type name is [rkv_comp]
// UVM_INFO uvm_create_build_or_new.sv(10) @ 0: uvm_test_top.comp1 [TYPE] [comp1] type name is [user_comp]
