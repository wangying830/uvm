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
  
  class sequence_kill_test extends uvm_test;
    rkv_sequence seq1, seq2;
    rkv_sequencer sqr;
    `uvm_component_utils(sequence_kill_test)
    function new(string name = "sequence_kill_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      seq1 = rkv_sequence::type_id::create("seq1", this);
      seq2 = rkv_sequence::type_id::create("seq2", this);
      sqr  = rkv_sequencer::type_id::create("sqr", this);
    endfunction

    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      phase.raise_objection(this);
      `uvm_info("PHASE", "run phase entered", UVM_LOW)
      fork
        #5ns seq1.kill();
      join_none
      seq1.start(sqr);
      seq2.start(sqr);
      `uvm_info("PHASE", "run phase exited", UVM_LOW)
      phase.drop_objection(this);
    endtask
  endclass 
endpackage 

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("sequence_kill_test"); 
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test sequence_kill_test...
// UVM_INFO uvm_sequence_kill.sv(40) @ 0: uvm_test_top [PHASE] run phase entered
// UVM_INFO uvm_sequence_kill.sv(10) @ 0: uvm_test_top.sqr@@seq1 [PHASE] sequence body entered
// UVM_INFO uvm_sequence_kill.sv(10) @ 5000: uvm_test_top.sqr@@seq2 [PHASE] sequence body entered
// UVM_INFO uvm_sequence_kill.sv(12) @ 15000: uvm_test_top.sqr@@seq2 [PHASE] sequence body exited
// UVM_INFO uvm_sequence_kill.sv(46) @ 15000: uvm_test_top [PHASE] run phase exited
