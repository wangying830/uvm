`ifndef INPUT_AGENT__SV
`define INPUT_AGENT__SV

// The files content needed by the agent must be included

`include "packet_sequence.sv"
`include "driver.sv"

// Lab 1 - Use typedef to create a class called packet_sequencer from the uvm_sequencer class parameterized with packet type
//
// ToDo


// Lab 1 - Declare the input_agent class, extended from uvm_agent
//
// ToDo


  // Lab 1 - Create a packet_sequencer handle, call it seqr
  //
  // ToDo


  // Lab 1 - Create a driver handle, call it drv
  //
  // ToDo


  `uvm_component_utils(input_agent)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // Lab 1 - Construct the packet_sequencer and driver objects using the proxy create() method
    //
    // ToDo


  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // Lab 1 - Connect the seq_item_port in drv to the seqr's seq_item_export
    //
    //  ToDo


  endfunction: connect_phase

endclass: input_agent

`endif
