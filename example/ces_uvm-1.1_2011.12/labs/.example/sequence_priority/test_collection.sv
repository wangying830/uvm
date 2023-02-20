`ifndef TEST_COLLECTION__SV
`define TEST_COLLECTION__SV

`include "router_env.sv"

class seq_test extends base_seq;
  `uvm_object_utils(seq_test)

  function new(string name = "seq_test");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual task body();
    repeat(4) begin
      `uvm_do_with(req, {da == 4;});
    end
  endtask
endclass


class test_base extends uvm_test;
  `uvm_component_utils(test_base)

  router_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    env = router_env::type_id::create("env", this);
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_top.print_topology();
    factory.print();
  endfunction: start_of_simulation_phase

  virtual task main_phase(uvm_phase phase);
   seq_test seq;
    super.main_phase(phase);
    phase.raise_objection(this);
    seq = seq_test::type_id::create("seq", this);
    seq.start(env.i_agent.seqr,, 2000);
    phase.drop_objection(this);
  endtask

endclass: test_base
`endif

