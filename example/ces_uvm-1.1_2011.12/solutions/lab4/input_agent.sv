`ifndef INPUT_AGENT__SV
`define INPUT_AGENT__SV

// The files content needed by the agent must be included

`include "packet_sequence.sv"
`include "driver.sv"

typedef uvm_sequencer #(packet) packet_sequencer;

class input_agent extends uvm_agent;

  // For this lab, the input agent has been modified to have port_id and virtual interface also.
  virtual router_io sigs;          // DUT virtual interface
  int               port_id = -1;  // Agent's designated port
  packet_sequencer seqr;
  driver drv;

  // For this lab, the input agent has been modified to have port_id.
  `uvm_component_utils_begin(input_agent)
    `uvm_field_int(port_id, UVM_DEFAULT | UVM_DEC)
  `uvm_component_utils_end

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // For this lab, the input agent has been modified to retrieve port_id and virtual interface.
    // The agent then configures its child components to use the same port_id and virtual interface.
    uvm_config_db#(int)::get(this, "", "port_id", port_id);
    uvm_config_db#(virtual router_io)::get(this, "", "router_io", sigs);

    seqr = packet_sequencer::type_id::create("seqr", this);
    drv  = driver::type_id::create("drv", this);

    uvm_config_db#(int)::set(this, "drv", "port_id", port_id);
    uvm_config_db#(int)::set(this, "seqr", "port_id", port_id);
    uvm_config_db#(virtual router_io)::set(this, "drv", "router_io", sigs);
    uvm_config_db#(virtual router_io)::set(this, "seqr", "router_io", sigs);
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction: connect_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    `uvm_info("AGNTCFG", $sformatf("Using port_id of %0d", port_id), UVM_MEDIUM);
  endfunction: start_of_simulation_phase
endclass

`endif
