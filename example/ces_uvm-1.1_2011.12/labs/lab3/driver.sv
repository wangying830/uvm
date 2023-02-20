`ifndef DRIVER__SV
`define DRIVER__SV

class driver extends uvm_driver #(packet);
  `uvm_component_utils(driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    forever begin
      seq_item_port.get_next_item(req);

      // Lab 3 - Task 5, Step 4
      // Change the req.print() statement into a uvm_info message statement:
      //
      // ToDo
      req.print();

      seq_item_port.item_done();
    end
  endtask

endclass

`endif

