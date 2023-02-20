package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_sequencer extends uvm_sequencer;
    bit ctrl;
    bit flag;
    `uvm_component_utils(rkv_sequencer)
    function new(string name = "rkv_sequencer", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
  class rkv_driver extends uvm_driver;
    `uvm_component_utils(rkv_driver)
    function new(string name = "rkv_driver", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
  class rkv_sequence extends uvm_sequence;
    `uvm_declare_p_sequencer(rkv_sequencer)
    `uvm_object_utils(rkv_sequence)
    function new(string name = "rkv_sequence");
      super.new(name);
    endfunction
    task body();
      // access sequencer member via m_sequencer
      m_sequencer.grab(this);
      m_sequencer.set_arbitration(UVM_SEQ_ARB_WEIGHTED);
      // access sequencer member via p_sequencer
      p_sequencer.ctrl = 1;
      p_sequencer.flag = 1;
      m_sequencer.ungrab(this);
    endtask
  endclass
  class sequencer_reference_test extends uvm_test;
    rkv_driver driver;
    rkv_sequencer sequencer;
    `uvm_component_utils(sequencer_reference_test)
    function new(string name = "sequencer_reference_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      driver = rkv_driver::type_id::create("driver", this);
      sequencer = rkv_sequencer::type_id::create("sequencer", this);
    endfunction
    function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
    task run_phase(uvm_phase phase);
      rkv_sequence seq = rkv_sequence::type_id::create("seq");
      phase.raise_objection(this);
      seq.start(sequencer);
      phase.drop_objection(this);
    endtask
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("sequencer_reference_test");
endmodule

