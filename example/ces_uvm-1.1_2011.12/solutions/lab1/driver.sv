`ifndef DRIVER__SV
`define DRIVER__SV

// Lab 1 - Declare a class driver that extends uvm_driver processing packet type
//
// ToDo
class driver extends uvm_driver #(packet);

  // Since the factory registration and the constructor are the same as what
  // you have already done.  There is no learning benefit in re-typing them.
  // These are entered for you in all subsequence tasks and labs.
  `uvm_component_utils(driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual task run_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    forever begin
      // seq_item_port is built into the uvm_driver base class
      // It is typically used to pull a sequence_item from the sequencer connected to the driver
      // You will be doing the driver to sequencer connection in the environment
      seq_item_port.get_next_item(req);

      // Lab 1 - Call the req object's print() method to display content
      //
      // ToDo
      req.print();

      // Once the driver finishes processing the requested sequence item, the driver must call item_done()
      // to indicate to the sequencer that the sequence item has completed processing
      seq_item_port.item_done();
    end
  endtask: run_phase

endclass: driver

`endif

