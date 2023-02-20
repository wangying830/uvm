`ifndef ROUTER_ENV__SV
`define ROUTER_ENV__SV

`include "input_agent.sv"
`include "reset_agent.sv"
`include "output_agent.sv"
`include "ms_scoreboard.sv"

// Lab 7 - Task 3, Step 2
// Include the host_agent.sv file.
//
// ToDo


class router_env extends uvm_env;
  input_agent  i_agent[16];
  scoreboard   sb;
  output_agent o_agent[16];
  reset_agent  r_agent;

  // Lab 7 - Task 3, Step 3
  // Create an instance of host_agent.  Call it h_agent.
  //
  // ToDo


  // Lab 7 - Task 10, Step 2
  // Create an instance of ral_block_host_regmodel call it regmodel.
  //
  // ToDo


  `uvm_component_utils(router_env)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    foreach (i_agent[i]) begin
      i_agent[i] = input_agent::type_id::create($sformatf("i_agent[%0d]", i), this);
      uvm_config_db #(int)::set(this, i_agent[i].get_name(), "port_id", i);
      uvm_config_db #(uvm_object_wrapper)::set(this, {i_agent[i].get_name(), ".", "seqr.main_phase"}, "default_sequence", packet_sequence::get_type());
    end

    sb = scoreboard::type_id::create("sb", this);
    foreach (o_agent[i]) begin
      o_agent[i] = output_agent::type_id::create($sformatf("o_agent[%0d]",i),this);
      uvm_config_db #(int)::set(this, o_agent[i].get_name(), "port_id", i);
    end

    r_agent = reset_agent::type_id::create("r_agent", this);
    uvm_config_db #(uvm_object_wrapper)::set(this, {r_agent.get_name(), ".", "seqr.reset_phase"}, "default_sequence", reset_sequence::get_type());

    // Lab 7 - Task 3, Step 4 & 5
    // Construct the host agent object with the factory create() method.
    // Configure the host agent's sequencer to execute host_bfm_sequence at the configure_phase.
    //
    // ToDo




    // If you want the regmodel to be configurable at the test or parent environment level,
    // uncomment the following.  (Not needed for this lab)
    //
    // uvm_config_db #(ral_block_host_regmodel)::get(this, "", "regmodel", regmodel);


    // Lab 7 - Task 10, Step 3
    // Check to see if regmodel is null.  If yes do the following:
    //
    // 1. Add a string field call it hdl_path.
    //
    // 2. Retrieve the hdl_path string with uvm_config_db.
    //
    // 3. Contruct the regmodel object
    //
    // 4. Call the regmodel's build() method to build the RAL representation.
    //
    // 5. Call the regmodel's lock_model() method to lock the RAL representation and create address map.
    //
    // 6. Set the hdl root path by calling the regmodel's set_hdl_path_root() method.
    //
    //
    // if (regmodel == null) begin
    //   string hdl_path;
    //   if (!uvm_config_db #(string)::get(this, "", "hdl_path", hdl_path)) begin
    //     `uvm_warning("HOSTCFG", "HDL path for backdoor not set!");
    //   end
    //   regmodel = ral_block_host_regmodel::type_id::create("regmodel", this);
    //   regmodel.build();
    //   regmodel.lock_model();
    //   regmodel.set_hdl_path_root(hdl_path);
    // end
    //
    // ToDo



  endfunction

  virtual function void connect_phase(uvm_phase phase);

    // Lab 7 - Task 10, Step 4
    // Create and construct an instance of reg_adapter call it adapter.
    //
    // reg_adapter adapter = reg_adapter::type_id::create("adapter", this);
    //
    // ToDo



    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // Lab 7 - Task 10, Step 5
    // Tie the regmodel to a sequencer by calling the set_sequencer() method in regmodel's default_map member.
    // In the argument of set_sequencer() method, pass in h_agent.seqr and adapter.
    //
    // regmodel.default_map.set_sequencer(h_agent.seqr, adapter);
    //
    // ToDo



    foreach (i_agent[i]) begin
      i_agent[i].analysis_port.connect(sb.before_export);
    end
    foreach (o_agent[i]) begin
      o_agent[i].analysis_port.connect(sb.after_export);
    end
  endfunction
endclass

`endif
