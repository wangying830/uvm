program automatic test;
import uvm_pkg::*;

class test_base extends uvm_test;
  `uvm_component_utils(test_base)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  virtual task configure_phase(uvm_phase phase);
    super.configure_phase(phase);
    uvm_top.set_timeout(4.3us, .overridable(1));
    phase.raise_objection(this);
    #7us;
  endtask

  virtual task pre_main_phase(uvm_phase phase);
    super.pre_main_phase(phase);
    phase.raise_objection(this);
    #3us;
  endtask

  virtual task main_phase(uvm_phase phase);
    super.main_phase(phase);
    uvm_top.set_timeout(1us, .overridable(1));
    phase.raise_objection(this);
    #1.2us;
  endtask

  virtual task post_main_phase(uvm_phase phase);
    super.post_main_phase(phase);
    uvm_top.set_timeout(100ns, .overridable(1));
    phase.raise_objection(this);
    #2.1us;
  endtask

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    #9us;
  endtask

endclass: test_base

initial begin
  $timeformat(-9, 1, "ns", 10);
  run_test();
end

endprogram

