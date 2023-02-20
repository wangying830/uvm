package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class comp1 extends uvm_component;
    uvm_event glb_e0, glb_e1;
    uvm_event loc_e0;
    `uvm_component_utils(comp1)
    function new(string name = "comp1", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      uvm_event_pool ep = new("ep");
      glb_e0 = uvm_event_pool::get_global("glb_e0");
      glb_e1 = uvm_event_pool::get_global($sformatf("%s.glb_e1",get_full_name()));
      loc_e0 = ep.get("loc_e0");
    endfunction
  endclass
  class event_global_vs_local_test extends uvm_test;
    comp1 c0, c1;
    `uvm_component_utils(event_global_vs_local_test)
    function new(string name = "event_global_vs_local_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      c0 = comp1::type_id::create("c0", this);
      c1 = comp1::type_id::create("c1", this);
    endfunction
    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      if(c0.glb_e0 == c1.glb_e0)
        `uvm_info("HDLCMP", "c0.glb_e0 == c1.glb_e0", UVM_LOW)
      if(c0.glb_e1 == c1.glb_e1)
        `uvm_info("HDLCMP", "c0.glb_e1 == c1.glb_e1", UVM_LOW)
      if(c0.loc_e0 == c1.loc_e0)
        `uvm_info("HDLCMP", "c0.loc_e0 == c1.loc_e0", UVM_LOW)
      phase.drop_objection(this);
    endtask
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("event_global_vs_local_test");
endmodule

// simulation result
// UVM_INFO @ 0: reporter [RNTST] Running test event_global_vs_local_test...
// UVM_INFO uvm_event_global_vs_local.sv(31) @ 0: uvm_test_top [HDLCMP] c0.glb_e0 == c1.glb_e0
