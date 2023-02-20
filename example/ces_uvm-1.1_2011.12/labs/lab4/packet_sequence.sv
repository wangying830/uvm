`ifndef PACKET_SEQUENCE__SV
`define PACKET_SEQUENCE__SV

`include "packet.sv"

class packet_sequence extends uvm_sequence #(packet);

  // Lab 3 - Task 2, Step 2
  // Create the new fields as shown below.
  //
  //   int       item_count = 10;
  //   int       port_id    = -1;
  //   bit[15:0] da_enable  = '1;
  //   int       valid_da[$];
  //
  // The intent of the item_count field is to control how many packet objects
  // to create and pass on to the driver per execution of the body() task.
  //
  // The intent of the port_id field is to constrain the packet's source address.
  //
  // The lab DUT has 16 input ports needing to be tested.  Each input agent created
  // to drive a particular port will be assigned a port_id specifying which port it
  // should exercise.  Because of this, the sequence within an input agent when
  // when generating packets need to constrain the packet's source address.
  //
  // The rule for constrainint the source address shall be as follows:
  // If port_id is inside the range of {[0:15]}, then the source address shall be port_id.
  // If port_id is -1 (unconfigured), the source address shall be in the range of {[0:15]}
  // port_id outside the range of {-1, {[0:15]} is not allowed.
  //
  // The intent of the da_enable fields is to enable corresponding destination
  // addresses to be generated.  A value of 1 in a particular bit position will
  // enable the corresponding address as a valid address to generate.  A value of 0
  // prohibit the corresponding address from being generated.
  //
  // Example: if the sequence were to be configured to generate only packets
  // for destination address 3, then the da_enable need to be configured as:
  // 16'b0000_0000_0000_1000
  //
  // Note that the default value is '1, meaning that all addresses are enabled.
  //
  // To simplify the constraint coding, a corresponding set of queue, valid_da
  // is needed.  This queue is populated based on the value of da_enable.
  //
  // Example: if da_enable is 16'b0000_0011_0000_1000, then the valid_da queue
  // will populated with 3, 8 and 9.
  //
  // ToDo
  int       item_count = 10;
  int       port_id    = -1;
  bit[15:0] da_enable  = '1;
  int       valid_da[$];


  //
  // To save lab time, the `uvm_object_utils macro is filled in for you.
  //
  `uvm_object_utils_begin(packet_sequence)
    `uvm_field_int(item_count, UVM_ALL_ON)
    `uvm_field_int(port_id, UVM_ALL_ON)
    `uvm_field_int(da_enable, UVM_ALL_ON)
    `uvm_field_queue_int(valid_da, UVM_ALL_ON)
  `uvm_object_utils_end

  //
  // The valid_da queue must be populated with legal set of addresses as specified
  // by the da_enable field.  Since the first thing that the sequencer performs is
  // the randomization of its default_sequence, a good place to retreive the configuration
  // fields and populate the valid_da queue is in the pre_randomize() method.
  //
  // To simplify your code development, the code is done for you as follows:
  //
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

  task body();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    if (starting_phase != null)
      starting_phase.raise_objection(this);

    // Lab 3 - Task 2, Step 3
    // Instead of hard coding the number of item to be generated, replace the
    // hard-coded value 10 in the repeat() statement to use item_count.
    //
    // ToDo
    repeat(item_count) begin


      // Lab 3 - Task 2, Step 3
      //
      // As stated in the comment at the beginning of the file.  If the port_id is unconfigured (-1)
      // then the legal values for the source address shall be in the range of {[0:15]}.  If the
      // port_id is configured, then the source address shall be port_id.  This will give the test
      // the ability to test whether or not the driver drops the packet it is not configured to drive.
      //
      // For destination address, the legal values should be picked out of the valid_da array.
      //
      // Change the following `uvm_do(req) macro to:
      // `uvm_do_with(req, {if (port_id == -1) sa inside {[0:15]}; else sa == port_id; da inside valid_da;});
      //
      // ToDo
      `uvm_do_with(req, {if (port_id == -1) sa inside {[0:15]}; else sa == port_id; da inside valid_da;});


    end

    if (starting_phase != null)
      starting_phase.drop_objection(this);
 endtask

endclass

`endif
