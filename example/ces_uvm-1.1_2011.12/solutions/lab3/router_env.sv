`ifndef ROUTER_ENV__SV
`define ROUTER_ENV__SV

`include "input_agent.sv"

// Lab 3 - Task 7, Step 2
//
// To save lab time, the reset agent with its sequencer, driver and monitor has been done
// for you.  You will need to add an instance of it in the environment.
//
// Include the reset_agent.sv file
//
// ToDo
`include "reset_agent.sv"


class router_env extends uvm_env;
  input_agent i_agent;

  // Lab 3 - Task 7, Step 3
  //
  // Create an instance of reset_agent, call it r_agent
  //
  // ToDo
  reset_agent r_agent;


  `uvm_component_utils(router_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    i_agent = input_agent::type_id::create("i_agent", this);
    uvm_config_db #(uvm_object_wrapper)::set(this, "i_agent.seqr.main_phase", "default_sequence", packet_sequence::get_type());
    
    // Lab 3 - Task 7, Step 4
    //
    // Construct the r_agent object with the proxy create() method.
    //
    // ToDo
    r_agent = reset_agent::type_id::create("r_agent", this);


    // Lab 3 - Task 7, Step 5
    //
    // Configure r_agent's seqr to execute reset_sequence at reset_phase:
    // uvm_config_db #(uvm_object_wrapper)::set(this, "r_agent.seqr.reset_phase", "default_sequence", reset_sequence::get_type());
    //
    // ToDo
    uvm_config_db #(uvm_object_wrapper)::set(this, "r_agent.seqr.reset_phase", "default_sequence", reset_sequence::get_type());


  endfunction

endclass

`endif
