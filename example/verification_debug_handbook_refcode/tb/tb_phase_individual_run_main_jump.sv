module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  class phase_jump_test extends uvm_test;
    bit has_main_phase_jump;
    bit has_run_phase_jump;
    `uvm_component_utils(phase_jump_test)
    function new(string name = "phase_jump_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void start_of_simulation_phase(uvm_phase phase);
      `uvm_info("START_OF_SIMULATION", "phase running", UVM_LOW)
    endfunction
    task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("RESET", "phase running", UVM_LOW)
      repeat(1) #1ns `uvm_info("RESET", $sformatf("@%0t phase stepping..", $time), UVM_LOW)
      phase.drop_objection(this);
    endtask
    task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("MAIN", "phase running", UVM_LOW)
      repeat(2) #1ns `uvm_info("MAIN", $sformatf("@%0t phase stepping..", $time), UVM_LOW)
      if(!has_main_phase_jump) begin
        has_main_phase_jump = 1;
        phase.jump(uvm_reset_phase::get()); 
      end
      phase.drop_objection(this);
    endtask
    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("RUN", "phase running", UVM_LOW)
      repeat(3) #1ns `uvm_info("RUN", $sformatf("@%0t phase stepping..", $time), UVM_LOW)
      if(!has_run_phase_jump) begin
        has_run_phase_jump = 1;
        phase.jump(uvm_start_of_simulation_phase::get()); 
      end
      phase.jump(uvm_start_of_simulation_phase::get()); 
      phase.drop_objection(this);
    endtask
  endclass
  initial run_test("phase_jump_test");
endmodule

// simulation result
// UVM_INFO @ 0: reporter [RNTST] Running test phase_jump_test...
// UVM_INFO tb_phase_individual_run_main_jump.sv(13) @ 0: uvm_test_top [START_OF_SIMULATION] phase running
// UVM_INFO tb_phase_individual_run_main_jump.sv(33) @ 0: uvm_test_top [RUN] phase running
// UVM_INFO tb_phase_individual_run_main_jump.sv(17) @ 0: uvm_test_top [RESET] phase running
// UVM_INFO tb_phase_individual_run_main_jump.sv(34) @ 1000: uvm_test_top [RUN] @1000 phase stepping..
// UVM_INFO tb_phase_individual_run_main_jump.sv(18) @ 1000: uvm_test_top [RESET] @1000 phase stepping..
// UVM_INFO tb_phase_individual_run_main_jump.sv(23) @ 1000: uvm_test_top [MAIN] phase running
// UVM_INFO tb_phase_individual_run_main_jump.sv(34) @ 2000: uvm_test_top [RUN] @2000 phase stepping..
// UVM_INFO tb_phase_individual_run_main_jump.sv(24) @ 2000: uvm_test_top [MAIN] @2000 phase stepping..
// UVM_INFO tb_phase_individual_run_main_jump.sv(34) @ 3000: uvm_test_top [RUN] @3000 phase stepping..
// UVM_INFO tb_phase_individual_run_main_jump.sv(24) @ 3000: uvm_test_top [MAIN] @3000 phase stepping..
// UVM_INFO ${UVM_HOME}/base/uvm_phase.svh(1556) @ 3000: reporter [PH_JUMP] phase run (schedule , domain common) is jumping to phase start_of_simulation
// UVM_INFO ${UVM_HOME}/base/uvm_phase.svh(1556) @ 3000: reporter [PH_JUMP] phase main (schedule uvm_sched, domain uvm) is jumping to phase reset
// UVM_INFO ${UVM_HOME}/base/uvm_objection.svh(1276) @ 3000: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
// UVM_INFO tb_phase_individual_run_main_jump.sv(13) @ 3000: uvm_test_top [START_OF_SIMULATION] phase running
// UVM_INFO tb_phase_individual_run_main_jump.sv(33) @ 3000: uvm_test_top [RUN] phase running
// UVM_FATAL ${UVM_HOME}/uvm_root.svh(1077) @ 3000: reporter [RUNPHSTIME] The run phase must start at time 0, current time is 3000. No non-zero delays are allowed before run_test(), and pre-run user defined phases may not consume simulation time before the start of the run phase.
