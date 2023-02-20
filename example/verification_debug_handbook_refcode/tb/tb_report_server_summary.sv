package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class comp1 extends uvm_component;
    `uvm_component_utils(comp1)
    function new(string name = "comp1", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    task reset_phase(uvm_phase phase);
      `uvm_info("PHASE", "reset phase entered at", UVM_LOW)
    endtask
    task main_phase(uvm_phase phase);
      `uvm_info("PHASE", "main phase entered", UVM_LOW)
      phase.raise_objection(this);
      #30us;
      `uvm_error("CMPDATA", "compare data failed")
      phase.drop_objection(this);
    endtask
  endclass

  class report_server_summary_test extends uvm_test;
    comp1 c1;
    `uvm_component_utils(report_server_summary_test)
    function new(string name = "report_server_summary_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      c1 = comp1::type_id::create("c1", this);
    endfunction
    task reset_phase(uvm_phase phase);
      `uvm_info("PHASE", $sformatf("reset phase entered at %0t" , $time), UVM_LOW)
    endtask
    task main_phase(uvm_phase phase);
      `uvm_info("PHASE", $sformatf("main phase entered at %0t" , $time), UVM_LOW)
    endtask
    function void end_of_elaboration_phase(uvm_phase phase);
      uvm_report_server rps = uvm_report_server::get_server();
      uvm_default_report_server drps;
      if(!$cast(drps, rps)) `uvm_error("CASTFAIL", "TYPE CASTING ERROR")
      drps.enable_report_id_count_summary = 0;
    endfunction
    function void report_phase(uvm_phase phase);
      uvm_report_server rps = uvm_report_server::get_server();
      `uvm_info("REPORT", $sformatf("INFO COUNT: %0d", rps.get_severity_count(UVM_INFO)), UVM_LOW)
      `uvm_info("REPORT", $sformatf("ERROR COUNT: %0d", rps.get_severity_count(UVM_ERROR)), UVM_LOW)
      `uvm_info("REPORT", $sformatf("Test finished at %0t", $time), UVM_LOW)
    endfunction
  endclass 
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("report_server_summary_test"); 
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test report_server_summary_test...
// UVM_INFO tb_report_server_summary.sv(10) @ 0: uvm_test_top.c1 [PHASE] reset phase entered at
// UVM_INFO tb_report_server_summary.sv(31) @ 0: uvm_test_top [PHASE] reset phase entered at 0
// UVM_INFO tb_report_server_summary.sv(13) @ 0: uvm_test_top.c1 [PHASE] main phase entered
// UVM_INFO tb_report_server_summary.sv(34) @ 0: uvm_test_top [PHASE] main phase entered at 0
// UVM_ERROR tb_report_server_summary.sv(16) @ 30000000: uvm_test_top.c1 [CMPDATA] compare data failed
// UVM_INFO tb_report_server_summary.sv(44) @ 30000000: uvm_test_top [REPORT] INFO COUNT: 6
// UVM_INFO tb_report_server_summary.sv(45) @ 30000000: uvm_test_top [REPORT] ERROR COUNT: 1
// UVM_INFO tb_report_server_summary.sv(46) @ 30000000: uvm_test_top [REPORT] Test finished at 30000000
