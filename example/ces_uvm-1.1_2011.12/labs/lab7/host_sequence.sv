`ifndef HOST_SEQUENCE__SV
`define HOST_SEQUENCE__SV

// Host data class access is required.
`include "host_data.sv"


// Lab 7 - Task 8, Step 2
// Include the ral_host_regmodel.sv file
//
// ToDo



//
// The host_bfm_sequence class is designed to clear the DUT PORT_LOCK register
// using the host_driver without using RAL.
//
class host_bfm_sequence extends uvm_sequence #(host_data);
  `uvm_object_utils(host_bfm_sequence)

  function new(string name = "host_bfm_sequence");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  // Lab 7 - Task 2
  // Develop a body() method that reads and writes the DUT configuration fields
  // with the `uvm_do_with macro by manually specifying the address, data and operation.
  //
  // For this specific task, do the following:
  //
  // First read and print the content of the PORT_LOCK register at address 16'h0100.
  // Then, write all one's to the register to enable all ports.  Finally, read the
  // content of the register back to verify it is correctly configured.
  //
  // virtual task body();
  //   `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  //   if (starting_phase != null)
  //     starting_phase.raise_objection(this);
  //   `uvm_do_with(req, {addr == 'h100; kind == host_data::READ;});
  //   `uvm_info("HOST BFM READ", {"\n", req.sprint()}, UVM_MEDIUM);
  //   `uvm_do_with(req, {addr == 'h100; data == '1; kind == host_data::WRITE;});
  //   `uvm_info("HOST BFM WRITE", {"\n", req.sprint()}, UVM_MEDIUM);
  //   `uvm_do_with(req, {addr == 'h100; kind == host_data::READ;});
  //   `uvm_info("HOST BFM READ", {"\n", req.sprint()}, UVM_MEDIUM);
  //   if (starting_phase != null)
  //     starting_phase.drop_objection(this);
  // endtask
  //
  // ToDo







endclass

//
// This is the RAL configuration sequence.
//
// Because it is a RAL sequence class, it must extend from the uvm_reg_sequence base class.
//

class host_ral_sequence extends uvm_reg_sequence #(uvm_sequence #(host_data));

  // Lab 7 - Task 8, Steps 4
  // Create an instance of ral_block_host_regmodel called regmodel.
  //
  // ToDo

  
  `uvm_object_utils(host_ral_sequence)

  function new(string name = "host_ral_sequence");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  // Lab 7 - Task 8, Steps 5
  //
  // Define a body() task that configures the DUT register with the exact same information
  // as host_bfm_sequence above.  Except use UVM register representation rather than direct access.
  //
  // virtual task body();
  //   uvm_status_e status;
  //   uvm_reg_data_t data;
  //   `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  //   if (starting_phase != null)
  //     starting_phase.raise_objection(this);
  //   regmodel.PORT_LOCK.read(.status(status), .value(data), .path(UVM_FRONTDOOR), .parent(this));
  //   `uvm_info("RAL READ", $sformatf("PORT_LOCK= %2h", data), UVM_MEDIUM);
  //   regmodel.PORT_LOCK.write(.status(status), .value('1), .path(UVM_FRONTDOOR), .parent(this));
  //   `uvm_info("RAL WRITE", $sformatf("PORT_LOCK= %2h", '1), UVM_MEDIUM);
  //   regmodel.PORT_LOCK.read(.status(status), .value(data), .path(UVM_FRONTDOOR), .parent(this));
  //   `uvm_info("RAL READ", $sformatf("PORT_LOCK= %2h", data), UVM_MEDIUM);
  //   if (starting_phase != null)
  //     starting_phase.drop_objection(this);
  // endtask
  //
  // ToDo





endclass

`endif
