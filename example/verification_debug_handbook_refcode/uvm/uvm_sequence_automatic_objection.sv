package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_sequence extends uvm_sequence;
    `uvm_object_utils(rkv_sequence)
    function new(string name = "rkv_sequence");
      super.new(name);
    endfunction
    task body();
      `uvm_info("PHASE", "sequence body entered", UVM_LOW)
      #10ns;
      `uvm_info("PHASE", "sequence body exited", UVM_LOW)
    endtask
  endclass
  
  class rkv_sequencer extends uvm_sequencer;
    `uvm_component_utils(rkv_sequencer)
    function new(string name = "rkv_sequencer", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass

  class sequence_top_objection_test extends uvm_test;
    rkv_sequence seq1;
    rkv_sequencer sqr1;
    `uvm_component_utils(sequence_top_objection_test)
    function new(string name = "sequence_top_objection_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      seq1 = rkv_sequence::type_id::create("seq1", this);
      sqr1 = rkv_sequencer::type_id::create("sqr1", this);
    endfunction

    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("PHASE", "run phase entered", UVM_LOW)
      // sequence automatic phase objection also works
      seq1.set_starting_phase(phase);
      seq1.set_automatic_phase_objection(1);
      seq1.start(sqr1);
      `uvm_info("PHASE", "run phase exited", UVM_LOW)
    endtask
  endclass 
endpackage 

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial  run_test("sequence_top_objection_test"); 
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test sequence_top_objection_test...
// UVM_INFO uvm_sequence_automatic_objection.sv(38) @ 0: uvm_test_top [PHASE] run phase entered
// UVM_INFO uvm_sequence_automatic_objection.sv(10) @ 0: uvm_test_top.sqr1@@seq1 [PHASE] sequence body entered
// UVM_INFO uvm_sequence_automatic_objection.sv(12) @ 10000: uvm_test_top.sqr1@@seq1 [PHASE] sequence body exited
// UVM_INFO uvm_sequence_automatic_objection.sv(43) @ 10000: uvm_test_top [PHASE] run phase exited
