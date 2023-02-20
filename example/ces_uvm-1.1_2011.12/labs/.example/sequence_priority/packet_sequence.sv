`ifndef PACKET_SEQUENCE__SV
`define PACKET_SEQUENCE__SV

`include "packet.sv"

class base_seq extends uvm_sequence #(packet);
  `uvm_object_utils(base_seq)

  function new(string name = "base_seq");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual task pre_body();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if (starting_phase != null)
      starting_phase.raise_objection(this);
  endtask

  virtual task body();
    `uvm_do(req);
  endtask

  virtual task post_body();
    if (starting_phase != null)
      starting_phase.drop_objection(this);
  endtask

endclass

class seq0 extends base_seq;
  `uvm_object_utils(seq0)

  function new(string name = "seq0");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual task body();
    repeat(5) begin
      `uvm_do_with(req, {da == 0;});
    end
  endtask
endclass

class seq1 extends base_seq;
  `uvm_object_utils(seq1)

  function new(string name = "seq1");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual task body();
    repeat(5) begin
      `uvm_do_with(req, {da == 1;});
    end
  endtask
endclass

class seq2 extends base_seq;
  `uvm_object_utils(seq2)

  function new(string name = "seq2");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual task body();
    repeat(5) begin
      `uvm_do_with(req, {da == 2;});
    end
  endtask
endclass

class packet_sequence extends base_seq;
  `uvm_object_utils(packet_sequence)
  seq0 s0;
  seq1 s1;
  seq2 s2;

  function new(string name = "packet_sequence");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual task body();
    m_sequencer.set_arbitration(SEQ_ARB_STRICT_FIFO);
    fork
      `uvm_do_pri(s0, 500);
      `uvm_do(s1);  // priority defaults to 100
      `uvm_do_pri(s2, 700);
    join
  endtask
endclass

`endif
