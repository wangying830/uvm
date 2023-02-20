import uvm_pkg::*;
`include "uvm_macros.svh"

class rkv_sequence extends uvm_sequence;
    `uvm_object_utils(rkv_sequence)
    function new(string name = "rkv_sequence");
      super.new(name);
    endfunction
    task body();
      force tb.m.data1 = 10; // SV force
    endtask
  endclass
class force_hdl_test extends uvm_test;
  `uvm_component_utils(force_hdl_test)
  function new(string name = "force_hdl_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  task run_phase(uvm_phase phase);
    rkv_sequence seq = rkv_sequence::type_id::create("seq", this);
    phase.raise_objection(this);
    super.run_phase(phase);
    seq.start(null);
    force tb.m.data2 = 11; // SV force
    $hdl_xmr_force("tb.m.addr", "20"); // VCS supplied system function
    uvm_hdl_force("tb.m.cmd", 30);
    #10ns;
    phase.drop_objection(this);
  endtask
endclass
