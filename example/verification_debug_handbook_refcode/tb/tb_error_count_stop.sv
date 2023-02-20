module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class error_count_stop_test extends uvm_test;
    `uvm_component_utils(error_count_stop_test)
    function new(string name = "error_count_stop_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void end_of_elaboration_phase(uvm_phase phase);
      uvm_root::get().set_report_max_quit_count(5);
      uvm_report_server::get_server().set_max_quit_count(4);
      // uvm_root::get().set_report_severity_action_hier(UVM_FATAL, UVM_DISPLAY | UVM_COUNT);
      // same effect as statement above 'set_report_severity_action_hier'
      uvm_root::get().set_report_severity_id_action_hier(UVM_FATAL, "FATCNT", UVM_DISPLAY | UVM_COUNT);
    endfunction
    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      fork
        for(int i=1; i<=10; i++) begin
          #1ns `uvm_error("ERRCNT", $sformatf("Error report count number is %0d", i))
        end
        for(int i=1; i<=10; i++) begin
          #1ns `uvm_fatal("FATCNT", $sformatf("Fatal report count number is %0d", i))
        end
      join
      phase.drop_objection(this);
    endtask
  endclass
  initial run_test("error_count_stop_test");
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test error_count_stop_test...
// UVM_ERROR tb_error_count_stop.sv(20) @ 1000: uvm_test_top [ERRCNT] Error report count number is 1
// UVM_FATAL tb_error_count_stop.sv(23) @ 1000: uvm_test_top [FATCNT] Fatal report count number is 1
// UVM_ERROR tb_error_count_stop.sv(20) @ 2000: uvm_test_top [ERRCNT] Error report count number is 2
// UVM_FATAL tb_error_count_stop.sv(23) @ 2000: uvm_test_top [FATCNT] Fatal report count number is 2

