package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class user_config extends uvm_object;
    bit coverage_enable = 1;
    bit covergroup_enable [string];
    `uvm_object_utils(user_config)
    function new(string name = "user_config");
      super.new(name);
    endfunction
  endclass

  class user_item extends uvm_object;
    randc bit [1:0] d1, d2;
    `uvm_object_utils(user_item)
    function new(string name = "user_item");
      super.new(name);
    endfunction
  endclass

  covergroup user_cg with function sample(bit[1:0] d);
    option.per_instance = 1;
    coverpoint d;
  endgroup

  class cov_model extends uvm_subscriber #(user_item);
    user_config cfg;
    user_cg cg1;
    user_cg cg2;
    `uvm_component_utils(cov_model)

    function new(string name = "cov_model", uvm_component parent = null);
      super.new(name, parent);
      cg1 = new();
      cg2 = new();
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
      cfg.covergroup_enable["cg1"] = 1;
      cfg.covergroup_enable["cg2"] = 1;
    endfunction

    function void write(T t);
      // sample data from argument 
      foreach(cfg.covergroup_enable[idx]) begin
        if(!is_covergroup_enabled(idx))
          continue;
        case(idx)
          "cg1"   : cg1.sample(t.d1);
          "cg2"   : cg2.sample(t.d2);
        endcase
      end
    endfunction

    function bit is_covergroup_enabled(string name);
      case(name)
        "cg1"   : return cfg.coverage_enable && cfg.covergroup_enable["cg1"];
        "cg2"   : return cfg.coverage_enable && cfg.covergroup_enable["cg2"];
        default : `uvm_error("UNDEF", $sformatf("unrecognized coverage name %s",name))
      endcase
    endfunction

    function real get_coverage(string name);
      case(name)
        "cg1"   : get_coverage = cg1.get_inst_coverage();
        "cg2"   : get_coverage = cg2.get_inst_coverage();
        default : `uvm_error("UNDEF", $sformatf("unrecognized coverage name %s",name))
      endcase
      `uvm_info("COVRPT", $sformatf("%s coverage = %.1f", name, get_coverage), UVM_LOW)
    endfunction

    function bit is_coverage_complete(string names[]);
      foreach(names[i]) begin
        if(get_coverage(names[i]) < 100.0)
          return 0;
      end
      return 1;
    endfunction
  endclass

  class sequence_control_with_coverage_test extends uvm_test;
    user_config cfg;
    cov_model cm;
    `uvm_component_utils(sequence_control_with_coverage_test)
    function new(string name = "sequence_control_with_coverage_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      cfg = user_config::type_id::create("cfg", this);
      cm = cov_model::type_id::create("cm", this);
    endfunction
    function void connect_phase(uvm_phase phase);
      cm.cfg = cfg;
    endfunction
    task run_phase(uvm_phase phase);
      user_item t = user_item::type_id::create("t");
      phase.raise_objection(this);
      `uvm_info("COVRPT", "coverage initial report::", UVM_LOW)
      void'(cm.get_coverage("cg1"));
      void'(cm.get_coverage("cg2"));
      forever begin
        void'(t.randomize());
        `uvm_info("COVSMP", "coverage is sampled", UVM_LOW)
        cm.write(t);
        if(cm.is_coverage_complete('{"cg1", "cg2"}))
          break;
      end
      `uvm_info("COVRPT", "coverage finish report::", UVM_LOW)
      void'(cm.get_coverage("cg1"));
      void'(cm.get_coverage("cg2"));
      phase.drop_objection(this);
    endtask
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("sequence_control_with_coverage_test");
endmodule

// simulation result
// UVM_INFO @ 0: reporter [RNTST] Running test coverage_control_test...
// UVM_INFO uvm_sequence_control_with_coverage.sv(98) @ 0: uvm_test_top [COVRPT] coverage initial report::
// UVM_INFO uvm_sequence_control_with_coverage.sv(69) @ 0: uvm_test_top.cm [COVRPT] cg1 coverage = 0.0
// UVM_INFO uvm_sequence_control_with_coverage.sv(69) @ 0: uvm_test_top.cm [COVRPT] cg2 coverage = 0.0
// UVM_INFO uvm_sequence_control_with_coverage.sv(103) @ 0: uvm_test_top [COVSMP] coverage is sampled
// UVM_INFO uvm_sequence_control_with_coverage.sv(69) @ 0: uvm_test_top.cm [COVRPT] cg1 coverage = 25.0
// UVM_INFO uvm_sequence_control_with_coverage.sv(103) @ 0: uvm_test_top [COVSMP] coverage is sampled
// UVM_INFO uvm_sequence_control_with_coverage.sv(69) @ 0: uvm_test_top.cm [COVRPT] cg1 coverage = 50.0
// UVM_INFO uvm_sequence_control_with_coverage.sv(103) @ 0: uvm_test_top [COVSMP] coverage is sampled
// UVM_INFO uvm_sequence_control_with_coverage.sv(69) @ 0: uvm_test_top.cm [COVRPT] cg1 coverage = 75.0
// UVM_INFO uvm_sequence_control_with_coverage.sv(103) @ 0: uvm_test_top [COVSMP] coverage is sampled
// UVM_INFO uvm_sequence_control_with_coverage.sv(69) @ 0: uvm_test_top.cm [COVRPT] cg1 coverage = 100.0
// UVM_INFO uvm_sequence_control_with_coverage.sv(69) @ 0: uvm_test_top.cm [COVRPT] cg2 coverage = 100.0
// UVM_INFO uvm_sequence_control_with_coverage.sv(108) @ 0: uvm_test_top [COVRPT] coverage finish report::
// UVM_INFO uvm_sequence_control_with_coverage.sv(69) @ 0: uvm_test_top.cm [COVRPT] cg1 coverage = 100.0
// UVM_INFO uvm_sequence_control_with_coverage.sv(69) @ 0: uvm_test_top.cm [COVRPT] cg2 coverage = 100.0
