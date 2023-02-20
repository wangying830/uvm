`ifndef TEST_COLLECTION__SV
`define TEST_COLLECTION__SV

`include "router_env.sv"

class test_base extends uvm_test;
  `uvm_component_utils(test_base)

  router_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    env = router_env::type_id::create("env", this);

    // Lab 5 - Task 4, Step 6
    //
    // In the environment, the input agent has changed from a single instance to an array of 16
    // agents.  Within the test, the corresponding change also must take place.
    //
    // Change the configuration for the input agent objects to the following:
    //
    // uvm_config_db#(virtual router_io)::set(this, "env.i_agent[*]", "router_io", router_test_top.sigs);
    //
    // ToDo
    uvm_config_db#(virtual router_io)::set(this, "env.i_agent", "router_io", router_test_top.sigs);



    // Lab 5 - Task 7, Step 8
    //
    // Since the environment also has an array of 16 output agents, the configuration must also be done.
    //
    // uvm_config_db#(virtual router_io)::set(this, "env.o_agent[*]", "router_io", router_test_top.sigs);
    //
    // ToDo



    uvm_config_db#(virtual router_io)::set(this, "env.r_agent", "router_io", router_test_top.sigs);
  endfunction

  virtual function void final_phase(uvm_phase phase);
    super.final_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_top.print_topology();

    factory.print();
  endfunction
endclass

`include "packet_da_3.sv"

class test_da_3_inst extends test_base;
  `uvm_component_utils(test_da_3_inst)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    set_inst_override_by_type("env.i_agent*.seqr.*", packet::get_type(), packet_da_3::get_type());
  endfunction
endclass

class test_da_3_type extends test_base;
  `uvm_component_utils(test_da_3_type)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    set_type_override_by_type(packet::get_type(), packet_da_3::get_type());
  endfunction
endclass

class test_da_3_seq extends test_base;
  `uvm_component_utils(test_da_3_seq)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_config_db#(bit[15:0])::set(this, "env.i_agent*.seqr", "da_enable", 16'h0008);
    uvm_config_db#(int)::set(this, "env.i_agent*.seqr", "item_count", 20);
  endfunction
endclass

`endif

