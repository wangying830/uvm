`ifndef PACKET_DA_3__SV
`define PACKET_DA_3__SV

class packet_da_3 extends packet;
  `uvm_object_utils(packet_da_3)

  // Lab 2 - set the constraint for destination address (da) to 3
  //
  // ToDo
  constraint da_3 {

  }

  function new(string name = "packet_da_3");
    super.new(name);
   `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction
endclass

`endif

