`ifndef RESET_AGENT__SV
`define RESET_AGENT__SV

`include "reset_sequence.sv"

typedef uvm_sequencer#(reset_tr) reset_sequencer;

class reset_agent extends uvm_agent;
  reset_sequencer seqr;
  
  `uvm_component_utils(reset_agent)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    seqr = reset_sequencer::type_id::create("seqr", this);
  endfunction: build_phase
endclass

`endif
