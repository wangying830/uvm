package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_object extends uvm_object;
    `uvm_object_utils(rkv_object)
    function new(string name = "rkv_object");
      super.new(name);
    endfunction
  endclass
  class rkv_config extends uvm_object;
    rkv_object obj;
    `uvm_object_utils(rkv_config)
    function new(string name = "rkv_config");
      super.new(name);
    endfunction
  endclass
  class rkv_comp extends uvm_component;
    rkv_config cfg;
    `uvm_component_utils(rkv_comp)
    function new(string name = "rkv_comp", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      // cfg is attached under current component and 
      // available for config_db set/get pair
      cfg = rkv_config::type_id::create("cfg", this);
      if(!uvm_config_db#(rkv_object)::get(this, "cfg", "obj", cfg.obj)) 
        `uvm_error("GETCFG","cannot get rkv_object handle from config DB")
      else
        `uvm_info("GETCFG","got rkv_object handle from config DB", UVM_LOW)
    endfunction
  endclass
  class object_create_under_parent_test extends uvm_test;
    rkv_object obj;
    rkv_comp comp;
    `uvm_component_utils(object_create_under_parent_test)
    function new(string name = "object_create_under_parent_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      obj = rkv_object::type_id::create("obj", this);
      uvm_config_db#(rkv_object)::set(this, "comp.cfg","obj", obj); 
      comp = rkv_comp::type_id::create("comp", this);
    endfunction
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("object_create_under_parent_test");
endmodule

// simulation result
// UVM_INFO @ 0: reporter [RNTST] Running test object_create_under_parent_test...
// UVM_INFO uvm_object_create_under_parent.sv(30) @ 0: uvm_test_top.comp [GETCFG] got rkv_object handle from config DB
