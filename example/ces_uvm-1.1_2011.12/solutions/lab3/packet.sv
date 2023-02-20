`ifndef PACKET__SV
`define PACKET__SV

// Lab 1 - Declare the class packet that extends uvm_sequence_item
//
// ToDo
class packet extends uvm_sequence_item;

  // Lab 1 - Declare the random 4-bit sa and da fields
  //
  // ToDo
  rand bit [3:0] sa, da;

  // Lab 1 - Declare the random 8-bit payload queue
  //
  // ToDo
  rand bit[7:0] payload[$];

  `uvm_object_utils_begin(packet)
    `uvm_field_int(sa, UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(da, UVM_ALL_ON)
    `uvm_field_queue_int(payload, UVM_ALL_ON)
  `uvm_object_utils_end

  constraint valid {
    payload.size inside {[1:10]};
  }

  // Lab 1 - Create the constructor with one argument: string name="packet"
  // Lab 1 - Call super.new() with this argument
  // Lab 1 - Lastly, print a message with:
  // Lab 1 - `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  //
  // ToDo
  function new(string name = "packet");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new


endclass: packet
`endif

