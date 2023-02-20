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
    uvm_config_db#(virtual router_io)::set(this, "env.i_agent[*]", "router_io", router_test_top.sigs);
    uvm_config_db#(virtual router_io)::set(this, "env.o_agent[*]", "router_io", router_test_top.sigs);
    uvm_config_db#(virtual router_io)::set(this, "env.r_agent", "router_io", router_test_top.sigs);

    // Lab 6 - Task 5, Step 2
    // There are three ways to register sequences into a sequence library:
    //
    // 1 - Use `uvm_add_to_seq_lib() macro
    // 2 - Use the sequence library class's add_typewide_sequence() method
    // 3 - Use the sequence library object's add_sequence() method
    //
    // There are different consequences with each of these mechanisms.
    //
    // The `uvm_add_to_seq_lib() macro will add the sequence to the sequence library for all tests.
    //
    // The add_typewide_sequence() method will add the sequence to the sequence library only
    // for the test that called the method.
    //
    // The add_sequence() method, requires that an instance of the sequence library be constructed.
    // Then, the add_sequence() method called via this sequence library handle will only affect
    // the sequencer that's configured to use this particular sequence library object.
    //
    // For this lab, use the add_typewide_sequence() method in the test_base class to add the
    // packet_sequence to the packet_seq_lib.
    //
    // ToDo


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


// Lab 6 - Task 7, Step 2
// Create a test class called test_seq_lib_cfg extended from test_base.
//
// Within the class, create an instance of uvm_sequence_library_cfg, call it seq_cfg.
//
// ToDo




// Lab 6 - Task 7, Step 3
//
// Define a build phase in which the seq_cfg object is constructed with UVM_SEQ_LIB_RAND mode
// and the max_random_count and the min_random_count to 1.
//
// Then, configure all the agent sequencer's sequence library to use this configuration.
//
// ToDo


`endif

