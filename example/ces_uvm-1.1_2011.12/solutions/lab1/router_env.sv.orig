`ifndef ROUTER_ENV__SV
`define ROUTER_ENV__SV

// The files content needed by the environment must be included

`include "input_agent.sv"


// Lab 1 - Declare the router_env class, extended from uvm_env
//
// ToDo


  // Lab 1 - Create an input_agent handle called i_agent
  //
  // ToDo


  `uvm_component_utils(router_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // Lab 1 - Construct the i_agent object using the proxy create() method
    //
    // ToDo


    // Lab 1 - Set the input sequencer to execute packet_sequence as the default_sequence in main_phase
    //         Use uvm_config_db #(uvm_object_wrapper)::set(this, "i_agent.seqr.main_phase", "default_sequence", packet_sequence::get_type());
    //
    // ToDo


  endfunction: build_phase

endclass: router_env

`endif
