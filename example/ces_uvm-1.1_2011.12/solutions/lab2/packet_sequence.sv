`ifndef PACKET_SEQUENCE__SV
`define PACKET_SEQUENCE__SV

`include "packet.sv"

// Lab 1 - Declare the class packet_sequence that extends uvm_sequence typed to packet
//
// ToDo
class packet_sequence extends uvm_sequence #(packet);


  // Since the factory registration and the constructor are the same as what
  // you have already done.  There is no learning benefit in re-typing them.
  // These are entered for you in all subsequence tasks and labs.

  `uvm_object_utils(packet_sequence)

  function new(string name = "packet_sequence");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  // Lab 1 - Create the body task with no argument
  // Lab 1 - Add trace statement: `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  // Lab 1 - Check to see if there is a starting phase
  // Lab 1 - If yes, raise the phase objection
  // Lab 1 - Then, generate 10 random packets
  // Lab 1 - When done, drop the phase objection
  // Lab 1 - Reference the lecture slides for exact syntax
  //
  // ToDo
  task body();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (starting_phase != null)
      starting_phase.raise_objection(this);
    repeat(10) begin
      `uvm_do(req);
    end
    if (starting_phase != null)
      starting_phase.drop_objection(this);
  endtask: body

endclass: packet_sequence

`endif
