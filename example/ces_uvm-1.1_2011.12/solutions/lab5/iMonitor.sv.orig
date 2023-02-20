`ifndef IMONITOR__SV
`define IMONITOR__SV

class iMonitor extends uvm_monitor;
  // Just like in the driver, the monitors will need a port designater variable
  // and access to DUT virtual interface.  They are exactly the same as driver.
  // There are no additional learning points in creating and configuring these
  // fields, so they are done for you.
  virtual router_io sigs;
  int               port_id = -1;


  // Lab 5 - Task 2, Step 2
  // Create a TLM analysis port typed to packet.  Call the handle analysis_port.
  //
  // ToDo


  `uvm_component_utils_begin(iMonitor)
    `uvm_field_int(port_id, UVM_DEFAULT | UVM_DEC)
  `uvm_component_utils_end

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (!uvm_config_db#(int)::get(this, "", "port_id", port_id)) begin
      `uvm_fatal("CFGERR", "iMonitor port_id not set");
    end
    if (!uvm_config_db#(virtual router_io)::get(this, "", "router_io", sigs)) begin
      `uvm_fatal("CFGERR", "iMonitor DUT interface not set");
    end

    // Lab 5 - Task 2, Step 3
    // Construct analysis_port.
    //
    // TLM ports in UVM do not have factory support.  You cannot construct
    // TLM ports with the factory create() method.
    // You can only construct TLM ports by calling its constructor.
    //
    // ToDo


  endfunction

  virtual task run_phase(uvm_phase phase);

    // The job of the monitor is to passively monitor the physical signals,
    // interprete and report the activities that it sees.  In this case, to
    // re-construct the packet that it sees on the DUT's input port as specified
    // by port_id.
    //
    // The observed packet need to be stored in an object.  In this task, that
    // object handle is tr as declared below.

    packet tr;
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    forever begin

      // Lab 5 - Task 2, Step 5
      // Within the forever loop, you need to construct the object (tr) in which the
      // observed transaction on the DUT input port can be stored.  As always, use the
      // factory create() method to do the construction.
      //
      // In the observed transaction object, there are three fields that needs to be
      // populated: source address (sa), destination address (da) and the payload array
      // (payload).
      //
      // The source address is not part of the observable bit stream on the DUT interface.
      // It is, by definition, the port_id of the iMonitor object.  You should set this
      // field before calling the device driver (get_packet).
      //
      // Both the destination address and the payload can be extracted from the obserable
      // bit stream on the DUT interface.  These will be populated by the device driver.
      //
      // After setting the source address field, call get_packet() to retrieve the observed
      // transaction.  Then, display the content of the observed transaction and pass the
      // observed transaction on to all other interested component via the TLM analysis port
      // (analysis_port) by calling its write() method.
      //
      // tr = packet::type_id::create("tr", this);
      // tr.sa = this.port_id;
      // get_packet(tr);
      // `uvm_info("Got Input Packet", {"\n", tr.sprint()}, UVM_MEDIUM);
      // analysis_port.write(tr);
      //
      // ToDo



    end
  endtask

  //
  // In the interest of lab time, the device driver code is done for you.
  //

  virtual task get_packet(packet tr);
    logic [7:0] datum;
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    @(negedge sigs.iMonClk.frame_n[port_id]);

    for (int i=0; i<4; i++) begin
      if (!sigs.iMonClk.frame_n[port_id]) begin
        tr.da[i] = sigs.iMonClk.din[port_id];
      end else begin
        `uvm_fatal("Header Error", $sformatf("@ Header cycle %0d, Frame not zero", i));
      end
      @(sigs.iMonClk);
    end

    for (int i=0; i<5; i++) begin
      if (!sigs.iMonClk.frame_n[port_id]) begin
        if (sigs.iMonClk.valid_n[port_id] && sigs.iMonClk.din[port_id]) begin
          @(sigs.iMonClk);
          continue;
        end else begin
          `uvm_fatal("Header Error", $sformatf("@%0d Valid or Din zero", i));
        end
      end else begin
        `uvm_fatal("Header Error", "Frame not zero");
      end
    end

    forever begin
      for(int i=0; i<8; i=i) begin
        if (!sigs.iMonClk.valid_n[port_id]) begin
          if (sigs.iMonClk.busy_n[port_id]) begin
            datum[i++] = sigs.iMonClk.din[port_id];
            if (i == 8) begin
              tr.payload.push_back(datum);
            end
          end else begin
            `uvm_fatal("Payload Error", "Busy & Valid conflict");
          end
        end
        if (sigs.iMonClk.frame_n[port_id]) begin
          if (i == 8) begin
            return;
          end else begin
            `uvm_fatal("Payload Error", "Not byte aligned");
          end
        end
        @(sigs.iMonClk);
      end
    end
  endtask: get_packet

endclass

`endif
