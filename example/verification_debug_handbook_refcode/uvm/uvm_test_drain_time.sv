package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_comp extends uvm_component;
    `uvm_component_utils(rkv_comp)
    function new(string name = "rkv_comp", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    task reset_phase(uvm_phase phase);
      `uvm_info("PHASE", "reset phase entered", UVM_LOW)
      phase.raise_objection(this);
      phase.phase_done.set_drain_time(this, 40us);
      #30us;
      phase.drop_objection(this);
      `uvm_info("PHASE", "reset phase exited", UVM_LOW)
    endtask
    task main_phase(uvm_phase phase);
      `uvm_info("PHASE", "main phase entered", UVM_LOW)
      phase.raise_objection(this);
      phase.phase_done.set_drain_time(this, 40us);
      #30us;
      phase.drop_objection(this);
      `uvm_info("PHASE", "main phase exited", UVM_LOW)
    endtask
  endclass

  class drain_time_test extends uvm_test;
    rkv_comp c1;
    `uvm_component_utils(drain_time_test)
    function new(string name = "drain_time_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      c1 = rkv_comp::type_id::create("c1", this);
      //uvm_root::get().set_timeout(10us);
    endfunction
    task reset_phase(uvm_phase phase);
      `uvm_info("PHASE", "reset phase entered", UVM_LOW)
      phase.raise_objection(this);
      phase.phase_done.set_drain_time(this, 20us);
      #10us;
      phase.drop_objection(this);
      `uvm_info("PHASE", "reset phase exited", UVM_LOW)
    endtask
    task main_phase(uvm_phase phase);
      `uvm_info("PHASE", "main phase entered", UVM_LOW)
      phase.raise_objection(this);
      phase.phase_done.set_drain_time(this, 20us);
      #10us;
      phase.drop_objection(this);
      `uvm_info("PHASE", "main phase exited" , UVM_LOW)
    endtask
    function void report_phase(uvm_phase phase);
      `uvm_info("REPORT", "Test finished", UVM_LOW)
    endfunction
  endclass 
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("drain_time_test"); 
endmodule

// simulation result:

