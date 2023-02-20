`ifndef INPUT_AGENT__SV
`define INPUT_AGENT__SV

// The files content needed by the agent must be included
`include "packet_sequence.sv"
`include "driver.sv"

// Lab 5 - Task 3, Step 2
// include the iMonitor.sv file
//
// ToDo
`include "iMonitor.sv"


typedef uvm_sequencer #(packet) packet_sequencer;

class input_agent extends uvm_agent;
  // The input agent already contains the following properties from the previous lab:
  virtual router_io sigs;          // DUT virtual interface
  int               port_id = -1;  // Agent's designated port
  packet_sequencer seqr;
  driver drv;

  // Lab 5 - Task 3, Step 3
  // Add an instance of iMonitor.  Call it mon.
  // And an instance of uvm_analysis_port #(packet).  Call it analysis_port.
  //
  // This analysis port is just a pass-through port for the iMonitor's analysis port
  // for the convinience of connection at the environment level.
  //
  // ToDo
  iMonitor mon;
  uvm_analysis_port #(packet) analysis_port;


  `uvm_component_utils_begin(input_agent)
    `uvm_field_int(port_id, UVM_DEFAULT | UVM_DEC)
  `uvm_component_utils_end

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // The agent retrieves port_id and virtual interface.
    uvm_config_db#(int)::get(this, "", "port_id", port_id);
    uvm_config_db#(virtual router_io)::get(this, "", "router_io", sigs);

    // Lab 5 - Task 3, Step 4
    //
    // Change the following construction and configure statements to obey the requirements
    // of the is_active flag.
    //
    // Check the state of the is_active flag.  If the is_active flag is UVM_ACTIVE,
    // use the existing statements to construct and configure the sequencer and driver objects.
    //
    // ToDo
    if (is_active == UVM_ACTIVE) begin
      seqr = packet_sequencer::type_id::create("seqr", this);
      drv  = driver::type_id::create("drv", this);

      uvm_config_db#(int)::set(this, "drv", "port_id", port_id);
      uvm_config_db#(int)::set(this, "seqr", "port_id", port_id);
      uvm_config_db#(virtual router_io)::set(this, "drv", "router_io", sigs);
      uvm_config_db#(virtual router_io)::set(this, "seqr", "router_io", sigs);
    end


    // Lab 5 - Task 3, Step 5
    //
    // Regardless of the state of the is_active flag, construct and configure the iMonitor (mon)
    // object.
    //
    // ToDo
    mon  = iMonitor::type_id::create("mon", this);
    uvm_config_db#(int)::set(this, "mon", "port_id", port_id);
    uvm_config_db#(virtual router_io)::set(this, "mon", "router_io", sigs);


  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // Lab 5 - Task 3, Step 6
    // Change the following connect statement to obey the requirement of the is_active flag.
    //
    // If the is_active flag is UVM_ACTIVE, connect drv's seq_item_port to seqr's seq_item_export
    //
    // ToDo
    if (is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end


    // Lab 5 - Task 3, Step 7
    // Set the agent's pass-through analyais port (analysis_port) to reference the analysis port
    // in iMonitor (mon).
    //
    // ToDo
    this.analysis_port = mon.analysis_port;


  endfunction

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    `uvm_info("AGNTCFG", $sformatf("Using port_id of %0d", port_id), UVM_MEDIUM);
  endfunction: start_of_simulation_phase

endclass

`endif
