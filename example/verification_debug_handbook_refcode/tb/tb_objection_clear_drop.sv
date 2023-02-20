package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_component extends uvm_component;
    `uvm_component_utils(rkv_component)
    function new(string name = "rkv_component", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      phase.raise_objection(this);
      #5ns;
      `uvm_info("RUN", "phase running", UVM_LOW)
      phase.drop_objection(this);
    endtask
  endclass
  class objection_clear_drop_test extends uvm_test;
    rkv_component comp[2];
    `uvm_component_utils(objection_clear_drop_test)
    function new(string name = "objection_clear_drop_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      foreach(comp[i]) comp[i] = rkv_component::type_id::create($sformatf("comp[%0d]",i), this);
    endfunction
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      phase.raise_objection(this);
      `uvm_info("RUN", "phase running", UVM_LOW)
      #3ns;
      `uvm_info("OBJECTION", $sformatf("RUN phase objection totally raised count = %0d before phase clear",phase.phase_done.get_objection_total()), UVM_LOW)
      // objection clear recursively
      phase.clear();
      `uvm_info("OBJECTION", $sformatf("RUN phase objection totally raised count = %0d after phase clear",phase.phase_done.get_objection_total()), UVM_LOW)
      phase.drop_objection(this);
    endtask
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("objection_clear_drop_test");
endmodule

// simulation result
// UVM_INFO @ 0: reporter [RNTST] Running test objection_clear_drop_test...
// UVM_INFO tb_objection_clear_drop.sv(30) @ 0: uvm_test_top [RUN] phase running
// UVM_INFO tb_objection_clear_drop.sv(32) @ 3000: uvm_test_top [OBJECTION] RUN phase objection totally raised count = 3 before phase clear
// UVM_WARNING @ 3000: run [OBJTN_CLEAR] Object 'common.run' cleared objection counts for run
// UVM_INFO tb_objection_clear_drop.sv(35) @ 3000: uvm_test_top [OBJECTION] RUN phase objection totally raised count = 0 after phase clear

