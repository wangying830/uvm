`ifndef DRIVER__SV
`define DRIVER__SV

class driver extends uvm_driver #(packet);
  // Lab 4 - Task 2, Step 2 and 3
  // Create the new fields as shown below.
  //
  // virtual router_io sigs;          // DUT virtual interface
  // int               port_id = -1;  // Driver's designated port
  //
  // The intent of the port_id field is to designate the driver for driving a specific port.
  //
  // If port_id is set in the range of 0 through 15, the driver will only drive
  // the packet it gets from the sequencer through the DUT if the port_id matches the
  // packet's source address (sa) field.  If not, the packet is dropped.
  //
  // If port_id is -1 (the default), the driver will drive all packets it gets from
  // the sequencer through the DUT without checking the packet's source address.
  //
  // Example:  If port_id is 3 and req.sa is also 3,
  // (req is the packet handle that sequencer passed to the driver)
  // The driver will drive the packet through port 3 of DUT: sigs.drvClk.din[req.sa];
  //
  // Example:  If port_id is 3 and req.sa is 7,
  // The driver will drop the packet.
  //
  // Example:  If port_id is -1 and req.sa is 7,
  // The driver will drive the packet through port 7 of DUT: sigs.drvClk.din[req.sa];
  //
  // ToDo


  // Lab 4 - Task 2, Step 4
  //
  // Embed the port_id field in the `uvm_component_utils macro.
  // Note: You will need to change the macro to `uvm_component_utils_begin
  //       with a corresponding `uvm_component_utils_end
  //
  // ToDo
  `uvm_component_utils(driver)


  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    // Lab 4 - Task 2, Step 5
    //
    // Retrieve the port_id configuration and the virtual interface.
    //
    // uvm_config_db#(int)::get(this, "", "port_id", port_id);
    // if (!(port_id inside {-1, [0:15]})) begin
    //   `uvm_fatal("CFGERR", $sformatf("port_id must be {-1, [0:15]}, not %0d!", port_id));
    // end
    // uvm_config_db#(virtual router_io)::get(this, "", "router_io", sigs);
    // if (sigs == null) begin
    //   `uvm_fatal("CFGERR", "Interface for Driver not set");
    // end
    //
    // ToDo


  endfunction: build_phase


  //
  // The UVM start_of_simulation phase is designed for displaying the testbench configuration
  // before any active verification operation starts.
  //
  // For the sake of lab time, the start_of_simulation method is done for you.
  //
  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    `uvm_info("DRV_CFG", $sformatf("port_id is: %0d", port_id), UVM_MEDIUM);
  endfunction: start_of_simulation_phase


  virtual task run_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    forever begin
      seq_item_port.get_next_item(req);

      // Lab 4 - Task 2, Step 6
      //
      // Check port_id to see if the driver should accept or drop the packet.
      // If port_id is -1, or if port_id matches req object's sa field,
      // call send() method to drive the content of the req object through the DUT.
      // Otherwise, drop the req object without processing.  Like the following:
      //
      // if (port_id inside { -1, req.sa }) begin
      //   send(req);
      //   `uvm_info("DRV_RUN", {"\n", req.sprint()}, UVM_MEDIUM);
      // end
      //
      // ToDo



      seq_item_port.item_done();
    end
  endtask: run_phase


  // Lab 4 - Task 9, Step 3
  //
  // The driver is fully responsible for asserting and de-asserting the signal set
  // that it is assigned to handle.  This includes setting the signal state at reset.
  //
  // At the pre_reset phase, the signals should be set to default values (x for logic,
  // z for wire) to emulate power-up condition.
  //
  // At the reset phase, the signals should be set to the de-asserted states.
  //
  // These two methods are done for you.
  //
  // Caution: for this lab, we are not using the port_id because this lab is still
  // just a part of initial bringup process.  There is only one agent in the
  // environment.  So, if port_id is -1 (not using port_id), then the reset phases
  // will initialized the signals for all router (DUT) ports.  In the next lab,
  // when you implement a dedicated agent for each port, the port_id will be set
  // and the reset phases will only initialize its designated port.
  //
  // For this lab, just un-comment both the pre_reset and reset phase code.
  //
  // ToDo

/*
  virtual task pre_reset_phase(uvm_phase phase);
    super.pre_reset_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    phase.raise_objection(this);
    if (port_id == -1) begin
      sigs.drvClk.frame_n <= 'x;
      sigs.drvClk.valid_n <= 'x;
      sigs.drvClk.din <= 'x;
    end else begin
      sigs.drvClk.frame_n[port_id] <= 'x;
      sigs.drvClk.valid_n[port_id] <= 'x;
      sigs.drvClk.din[port_id] <= 'x;
    end
    phase.drop_objection(this);
  endtask: pre_reset_phase

  virtual task reset_phase(uvm_phase phase);
    super.reset_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    phase.raise_objection(this);
    if (port_id == -1) begin
      sigs.drvClk.frame_n <= '1;
      sigs.drvClk.valid_n <= '1;
      sigs.drvClk.din <= '0;
    end else begin
      sigs.drvClk.frame_n[port_id] <= '1;
      sigs.drvClk.valid_n[port_id] <= '1;
      sigs.drvClk.din[port_id] <= '0;
    end
    phase.drop_objection(this);
  endtask: reset_phase
*/

  //
  // In the interest of lab time, all device drivers have been done for you:
  //

  virtual task send(packet tr);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    send_address(tr);
    send_pad(tr);
    send_payload(tr);
  endtask: send

  virtual task send_address(packet tr);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    sigs.drvClk.frame_n[tr.sa] <= 1'b0;
    for(int i=0; i<4; i++) begin
      sigs.drvClk.din[tr.sa] <= tr.da[i];
      @(sigs.drvClk);
    end
  endtask: send_address

  virtual task send_pad(packet tr);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    sigs.drvClk.din[tr.sa] <= 1'b1;
    sigs.drvClk.valid_n[tr.sa] <= 1'b1;
    repeat(5) @(sigs.drvClk);
  endtask: send_pad

  virtual task send_payload(packet tr);
    logic [7:0] datum;
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    while(!sigs.drvClk.busy_n[tr.sa]) @(sigs.drvClk);
    foreach(tr.payload[index]) begin
      datum = tr.payload[index];
      for(int i=0; i<$size(tr.payload, 2); i++) begin
        sigs.drvClk.din[tr.sa] <= datum[i];
        sigs.drvClk.valid_n[tr.sa] <= 1'b0;
        sigs.drvClk.frame_n[tr.sa] <= ((tr.payload.size()-1) == index) && (i==7);
        @(sigs.drvClk);
      end
    end
    sigs.drvClk.valid_n[tr.sa] <= 1'b1;
  endtask: send_payload

endclass: driver

`endif
