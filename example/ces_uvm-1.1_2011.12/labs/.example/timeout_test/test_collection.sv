`ifndef TEST_COLLECTION__SV
`define TEST_COLLECTION__SV

`include "router_env.sv"

class my_packet extends packet;
  `uvm_object_utils(my_packet);

  function new(string name="my_packet");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    this.sa = 3;
    this.da = 7;
  endfunction: new
endclass

class test_base extends uvm_test;
  `uvm_component_utils(test_base)
  router_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    env = router_env::type_id::create("env", this);
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_top.print_topology();
    factory.print();
    set_inst_override("env.i_agent.drv.pkt", "packet", "my_packet");
//    set_type_override("packet", "my_packet");
//    uvm_top.set_timeout(.timeout(1us), .overridable(1));
  endfunction: start_of_simulation_phase

  virtual task main_phase(uvm_phase phase);
    super.main_phase(phase);
//    uvm_top.set_timeout(10us, .overridable(1));
  endtask

  virtual task post_main_phase(uvm_phase phase);
    super.post_main_phase(phase);
//    uvm_top.set_timeout(1ms, .overridable(1));
    phase.raise_objection(this);
    #1us;
//    phase.drop_objection(this);
  endtask

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    #1us;
//    phase.drop_objection(this);
  endtask

endclass: test_base
`endif

