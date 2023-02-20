package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_comp extends uvm_component;
    `uvm_component_utils(rkv_comp)
    function new(string name = "rkv_comp", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
  class rkv_comp_x extends rkv_comp;
    `uvm_component_utils(rkv_comp_x)
    function new(string name = "rkv_comp_x", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
  class rkv_comp_y extends rkv_comp;
    `uvm_component_utils(rkv_comp_y)
    function new(string name = "rkv_comp_y", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
  class factory_create_override_test extends uvm_test;
    rkv_comp comp;
    `uvm_component_utils(factory_create_override_test)
    function new(string name = "factory_create_override_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // available to override
      set_type_override("rkv_comp", "rkv_comp_x");
      comp = rkv_comp::type_id::create("comp", this);
      // too late after instance created
      set_type_override("rkv_comp", "rkv_comp_y");
      `uvm_info("TYPE", $sformatf("comp type name is %s", comp.get_type_name()), UVM_LOW)
    endfunction
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("factory_create_override_test");
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test factory_create_override_test...
// UVM_INFO @ 0: reporter [TPREGR] Original object type 'rkv_comp' already registered to produce 'rkv_comp_x'.  Replacing with override to produce type 'rkv_comp_y'.
// UVM_INFO uvm_factory_create_override.sv(35) @ 0: uvm_test_top [TYPE] comp type name is rkv_comp_x
