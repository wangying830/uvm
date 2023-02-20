package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_sequencer extends uvm_sequencer;
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
  class rkv_sequence_lib extends uvm_sequence_library;
    `uvm_object_utils(rkv_sequence_lib)
    `uvm_sequence_library_utils(rkv_sequence_lib)
    function new(string name = "rkv_sequence_lib");
      super.new(name);
      init_sequence_library();
    endfunction
  endclass
  class rkv_sequence1 extends uvm_sequence;
    `uvm_object_utils(rkv_sequence1)
    `uvm_add_to_seq_lib(rkv_sequence1, rkv_sequence_lib)
    function new(string name = "rkv_sequence1");
      super.new(name);
    endfunction
    task body();
      `uvm_info("SEQ", $sformatf("%s started now", get_type_name()), UVM_LOW)
    endtask
  endclass
  class rkv_sequence2 extends rkv_sequence1;
    `uvm_object_utils(rkv_sequence2)
    `uvm_add_to_seq_lib(rkv_sequence2, rkv_sequence_lib)
    function new(string name = "rkv_sequence2");
      super.new(name);
    endfunction
  endclass
  class rkv_sequence3 extends rkv_sequence1;
    `uvm_object_utils(rkv_sequence3)
    `uvm_add_to_seq_lib(rkv_sequence3, rkv_sequence_lib)
    function new(string name = "rkv_sequence3");
      super.new(name);
    endfunction
  endclass

  class sequence_library_usage_test extends uvm_test;
    rkv_driver driver;
    rkv_sequencer sequencer;
    uvm_sequence_library_cfg lib_cfg;
    `uvm_component_utils(sequence_library_usage_test)
    function new(string name = "sequence_library_usage_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      driver = rkv_driver::type_id::create("driver", this);
      sequencer = rkv_sequencer::type_id::create("sequencer", this);
      lib_cfg = new("lib_cfg", UVM_SEQ_LIB_RANDC, 2, 5);
      uvm_config_db #(uvm_object_wrapper)::set(this, "sequencer.run_phase",
                                               "default_sequence",
                                               rkv_sequence_lib::get_type());
      uvm_config_db #(uvm_sequence_library_cfg)::set(this, "sequencer.run_phase",
                                                     "default_sequence.config",
                                                     lib_cfg);
    endfunction
    function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("sequence_library_usage_test");
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test sequence_library_usage_test...
// UVM_INFO /$UVM_HOME/seq/uvm_sequence_library.svh(660) @ 0: uvm_test_top.sequencer@@rkv_sequence_lib [SEQLIB/START] Starting sequence library rkv_sequence_lib in run phase: 4 iterations in mode UVM_SEQ_LIB_RANDC
// UVM_INFO uvm_sequence_library_usage.sv(31) @ 0: uvm_test_top.sequencer@@rkv_sequence_lib.rkv_sequence3:1 [SEQ] rkv_sequence3 started now
// UVM_INFO uvm_sequence_library_usage.sv(31) @ 0: uvm_test_top.sequencer@@rkv_sequence_lib.rkv_sequence1:2 [SEQ] rkv_sequence1 started now
// UVM_INFO uvm_sequence_library_usage.sv(31) @ 0: uvm_test_top.sequencer@@rkv_sequence_lib.rkv_sequence2:3 [SEQ] rkv_sequence2 started now
// UVM_INFO uvm_sequence_library_usage.sv(31) @ 0: uvm_test_top.sequencer@@rkv_sequence_lib.rkv_sequence3:4 [SEQ] rkv_sequence3 started now

