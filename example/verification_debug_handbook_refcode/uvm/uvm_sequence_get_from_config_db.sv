package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_sequence extends uvm_sequence;
    int var1, var2, var3;
    `uvm_object_utils(rkv_sequence)
    function new(string name = "rkv_sequence");
      super.new(name);
    endfunction
    task body();
      if(!uvm_config_db#(int)::get(m_sequencer, "", "var1", var1))
        `uvm_error("CFGDB", "Cannot get var1")
      else
        `uvm_info("CFGDB", $sformatf("var1 is %0d", var1), UVM_LOW)
      if(!uvm_config_db#(int)::get(uvm_root::get(), "uvm_test_top.seq", "var2", var2))
        `uvm_error("CFGDB", "Cannot get var2")
      else
        `uvm_info("CFGDB", $sformatf("var2 is %0d", var2), UVM_LOW)
      if(!uvm_config_db#(int)::get(null, "", "var3", var3))
        `uvm_error("CFGDB", "Cannot get var3")
      else
        `uvm_info("CFGDB", $sformatf("var3 is %0d", var3), UVM_LOW)
    endtask
  endclass

  class rkv_sequencer extends uvm_sequencer;
    `uvm_component_utils(rkv_sequencer)
    function new(string name = "rkv_sequencer", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
  
  class sequence_get_from_config_db_test extends uvm_test;
    rkv_sequencer sqr;
    `uvm_component_utils(sequence_get_from_config_db_test)
    function new(string name = "sequence_get_from_config_db_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      uvm_config_db#(int)::set(this, "sqr","var1", 1); 
      uvm_config_db#(int)::set(this, "seq","var2", 2); 
      uvm_config_db#(int)::set(null, "","var3", 3); 
      sqr = rkv_sequencer::type_id::create("sqr", this);
    endfunction
    task run_phase(uvm_phase phase);
      rkv_sequence seq = rkv_sequence::type_id::create("seq", this);;
      phase.raise_objection(this);
      seq.start(sqr);
      phase.drop_objection(this);
    endtask
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("sequence_get_from_config_db_test");
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test sequence_get_from_config_db_test...
// UVM_INFO uvm_sequence_get_from_config_db.sv(14) @ 0: uvm_test_top.sqr@@seq [CFGDB] var1 is 1
// UVM_INFO uvm_sequence_get_from_config_db.sv(18) @ 0: uvm_test_top.sqr@@seq [CFGDB] var2 is 2
// UVM_INFO uvm_sequence_get_from_config_db.sv(22) @ 0: uvm_test_top.sqr@@seq [CFGDB] var3 is 3
