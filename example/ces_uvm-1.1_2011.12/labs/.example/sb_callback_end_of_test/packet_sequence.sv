`ifndef PACKET_SEQUENCE__SV
`define PACKET_SEQUENCE__SV

`include "packet.sv"

class packet_sequence extends uvm_sequence #(packet);
  int       item_count = 10;
  int       port_id    = -1;
  bit[15:0] da_enable  = '1;
  int       valid_da[$];

  `uvm_object_utils_begin(packet_sequence)
    `uvm_field_int(item_count, UVM_ALL_ON)
    `uvm_field_int(port_id, UVM_ALL_ON)
    `uvm_field_int(da_enable, UVM_ALL_ON)
    `uvm_field_queue_int(valid_da, UVM_ALL_ON)
  `uvm_object_utils_end

  function void pre_randomize();
    uvm_config_db#(int)::get(m_sequencer, "", "item_count", item_count);
    uvm_config_db#(int)::get(m_sequencer, "", "port_id", port_id);
    uvm_config_db#(bit[15:0])::get(m_sequencer, "", "da_enable", da_enable);
    if (!(port_id inside {-1, [0:15]})) begin
      `uvm_fatal("CFGERR", $sformatf("Illegal port_id value of %0d", port_id));
    end

    valid_da.delete();
    for (int i=0; i<16; i++)
      if (da_enable[i])
        valid_da.push_back(i);
  endfunction

  function new(string name = "packet_sequence");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual task body();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_config_db#(int)::get(m_sequencer, "*", "item_count", item_count);

    if (starting_phase != null) begin
      starting_phase.raise_objection(this);
    end

    repeat(item_count) begin
      `uvm_do_with(req, {if (port_id == -1) sa inside {[0:15]}; else sa == port_id; da inside valid_da;});
    end

    if (starting_phase != null)
      starting_phase.drop_objection(this);
 endtask

endclass

`endif
