`ifndef ROUTER_ENV__SV
`define ROUTER_ENV__SV

`include "input_agent.sv"
`include "reset_agent.sv"

// Lab 5 - Task 7, Step 2
//
// Include the scoreboard.sv and output_agent.sv files
//
// ToDo




// Lab 5 - Task 8, step 8
//
// Comment out the include statement above for the scoreboard.sv.
// Replace it with an include statement for ms_scoreboard.sv
//
// ToDo


class router_env extends uvm_env;

  // Lab 5 - Task 4, Step 2
  //
  // The environment need 16 individual input agents.  One for each DUT port.
  //
  // Change the following single instance of agent into an array of 16 agents: i_agent[16].
  //
  // ToDo
  input_agent i_agent;



  // Lab 5 - Task 7, Step 3
  //
  // Create an instance of scoreboard, call it sb.
  // Create an array of output_agent, call it o_agent[16].
  //
  // If you examine the output_agent code, you will find that the output_agent only contains
  // an instance of oMonitor.  This is because for the sake of lab simplicity, the DUT output
  // protocal was designed without the need of a responder (push mode).  Even though there are
  // no sequencer nor drivers in the output agent, the output agent should still be created and
  // instantiated in the environment.  For flexibility of environment maintenance, this will be
  // better in the longer run for unanticipated changes.
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

    // Lab 5 - Task 4, Step 3
    //
    // Change the following construction and configuration of a single instance of input agent into
    // construction and configuration of all agents in the agent array.
    //
    // First, construct each input agent via the factory create() method.
    // Then, for each agent, assign it to a dedicated port by setting the port_id field.
    // Finally, for each agent, set the sequencer's default_sequence to packet_sequence.
    //
    // foreach (i_agent[i]) begin
    //   i_agent[i] = input_agent::type_id::create($sformatf("i_agent[%0d]", i), this);
    //   uvm_config_db #(int)::set(this, i_agent[i].get_name(), "port_id", i);
    //   uvm_config_db #(uvm_object_wrapper)::set(this, {i_agent[i].get_name(), ".", "seqr.main_phase"}, "default_sequence", packet_sequence::get_type());
    // end
    //
    // ToDo
    i_agent = input_agent::type_id::create("i_agent", this);
    uvm_config_db #(uvm_object_wrapper)::set(this, "i_agent.seqr.main_phase", "default_sequence", packet_sequence::get_type());

    
    // Lab 5 - Task 7, Step 4
    //
    // Construct the scoreboard and the output_agent objects with factory create() method.
    //
    // For each output_agent object, also configure its port_id field to a designated port.
    //
    // foreach (o_agent[i]) begin
    //   o_agent[i] = output_agent::type_id::create($sformatf("o_agent[%0d]", i), this);
    //   uvm_config_db #(int)::set(this, o_agent[i].get_name(), "port_id", i);
    // end
    //
    // ToDo



    r_agent = reset_agent::type_id::create("r_agent", this);
    uvm_config_db #(uvm_object_wrapper)::set(this, "r_agent.seqr.reset_phase", "default_sequence", reset_sequence::get_type());
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // Lab 5 - Task 7, Step 5
    //
    // Connect the scoreboard's before and after TLM exports to each agent's TLM analysis port.
    //
    // ToDo





  endfunction

endclass

`endif
