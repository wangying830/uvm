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

    // Lab 7 - Task 4, Step 2
    // Configure the host agent to use the host_io virtual interface.
    //
    // uvm_config_db#(virtual host_io)::set(this, "env.h_agent", "host_io", router_test_top.host);
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

class test_seq_lib_cfg extends test_base;
  uvm_sequence_library_cfg seq_cfg;
  `uvm_component_utils(test_seq_lib_cfg)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seq_cfg = new("seq_cfg", UVM_SEQ_LIB_RAND, 1, 1);
    uvm_config_db #(uvm_sequence_library_cfg)::set(this, "env.i_agent*.seqr.main_phase", "default_sequence.config", seq_cfg);
  endfunction
endclass



//
// The following test class contains the test code that configures the DUT PORT_LOCK register to
// enable all ports using RAL.
//
// The reason that it is extended from test_seq_lib_cfg is to keep the total number of packets to 160.
//
class test_ral_seq extends test_seq_lib_cfg;

  `uvm_component_utils(test_ral_seq)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Lab 7 - Task 11, Step 2
    // Disable the host sequencer (h_agent.seqr) by setting its default_sequence to null.
    //
    // uvm_config_db #(uvm_object_wrapper)::set(this, "env.h_agent.seqr.configure_phase", "default_sequence", null);
    //
    // ToDo


    // Lab 7 - Task 11, Step 3
    // Set the environment's hdl_path to point to router_test_top.dut.
    //
    // uvm_config_db #(string)::set(this, "env", "hdl_path", "router_test_top.dut");
    //
    // ToDo


  endfunction

  virtual task configure_phase(uvm_phase phase);

    // Lab 7 - Task 11, Step 4
    // Instantiate and construct a host_ral_sequence object call it host_seq.
    //
    // ToDo


    super.configure_phase(phase); 

    // Lab 7 - Task 11, Step 5
    // Set the host_seq's regmodel to environment's regmodel (env.regmodel)
    //
    // ToDo


    phase.raise_objection(this);

    // Lab 7 - Task 11, Step 6
    // Call host_seq's start(null) method to execute the RAL sequence
    //
    // ToDo



    phase.drop_objection(this);
  endtask
endclass

`endif

