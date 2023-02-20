package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class seqfoo extends uvm_sequence;
    rand int data = -1;
    `uvm_object_utils(seqfoo)
    function new(string name = "seqfoo");
      super.new(name);
      set_automatic_phase_objection(1);
    endfunction
    task body();
      `uvm_info(get_type_name(), $sformatf("data is %0d", data), UVM_LOW)
      repeat(2) #1ns `uvm_do(req)
    endtask
  endclass

  class sequencer extends uvm_sequencer;
    `uvm_component_utils(sequencer)
    function new(string name = "sequencer", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass

  class driver extends uvm_driver;
    `uvm_component_utils(driver)
    function new(string name = "driver", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    task run_phase(uvm_phase phase);
      get_and_drive("run_phase");
    endtask
    task get_and_drive(string ph);
      forever begin
        seq_item_port.get_next_item(req);
        `uvm_info(get_type_name(), $sformatf("At [%s] got next item from sequence [%s]", 
                                             ph, req.get_parent_sequence().get_name()), UVM_LOW)
        seq_item_port.item_done();
      end
    endtask : get_and_drive
  endclass

  class sequence_start_vs_config_test extends uvm_test;
    driver drv;
    sequencer sqr;
    `uvm_component_utils(sequence_start_vs_config_test)
    function new(string name = "sequence_start_vs_config_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      seqfoo s0 = seqfoo::type_id::create("seq0");
      seqfoo s1 = seqfoo::type_id::create("seq1");
      sqr = sequencer::type_id::create("sqr", this);
      drv = driver::type_id::create("drv", this);
      s0.randomize() with {data == 10;};
      s0.do_not_randomize = 1; // prevents randomization as a default sequence
      s1.randomize() with {data == 20;};
      s1.do_not_randomize = 1; // prevents randomization as a default sequence
      uvm_config_db #(uvm_sequence_base)::set(this, "sqr.run_phase",
                                              "default_sequence",
                                              s0);
      uvm_config_db #(uvm_sequence_base)::set(this, "sqr.main_phase",
                                              "default_sequence",
                                              s1);
    endfunction
    function void connect_phase(uvm_phase phase);
      drv.seq_item_port.connect(sqr.seq_item_export);
    endfunction
    task run_phase(uvm_phase phase);
      seqfoo s2 = seqfoo::type_id::create("seq2");
      phase.raise_objection(this);
      s2.randomize() with {data == 30;};
      s2.start(sqr);
      phase.drop_objection(this);
    endtask
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("sequence_start_vs_config_test");
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test sequence_start_vs_config_test...
// UVM_INFO uvm_sequence_start_vs_config.sv(12) @ 0: uvm_test_top.sqr@@seq0 [seqfoo] data is 10
// UVM_INFO uvm_sequence_start_vs_config.sv(12) @ 0: uvm_test_top.sqr@@seq2 [seqfoo] data is 30
// UVM_INFO uvm_sequence_start_vs_config.sv(12) @ 0: uvm_test_top.sqr@@seq1 [seqfoo] data is 20
// UVM_INFO uvm_sequence_start_vs_config.sv(35) @ 1000: uvm_test_top.drv [driver] At [run_phase] got next item from sequence [seq0]
// UVM_INFO uvm_sequence_start_vs_config.sv(35) @ 1000: uvm_test_top.drv [driver] At [run_phase] got next item from sequence [seq2]
// UVM_INFO uvm_sequence_start_vs_config.sv(35) @ 1000: uvm_test_top.drv [driver] At [run_phase] got next item from sequence [seq1]
// UVM_INFO uvm_sequence_start_vs_config.sv(35) @ 2000: uvm_test_top.drv [driver] At [run_phase] got next item from sequence [seq0]
// UVM_INFO uvm_sequence_start_vs_config.sv(35) @ 2000: uvm_test_top.drv [driver] At [run_phase] got next item from sequence [seq2]
// UVM_INFO uvm_sequence_start_vs_config.sv(35) @ 2000: uvm_test_top.drv [driver] At [run_phase] got next item from sequence [seq1]

