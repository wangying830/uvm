module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class component extends uvm_component;
    bit reset_jump = 0;
    `uvm_component_utils(component)
    function new(string name = "component", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("RESET", "phase running", UVM_LOW)
      #1ns `uvm_info("RESET", $sformatf("@%0t phase stepping..", $time), UVM_LOW)
      phase.drop_objection(this);
    endtask
    task configure_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("CONFIGURE", "phase running", UVM_LOW)
      #1ns `uvm_info("CONFIGURE", $sformatf("@%0t phase stepping..", $time ), UVM_LOW)
      phase.drop_objection(this);
    endtask
    task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("MAIN", "phase running", UVM_LOW)
      fork
        repeat(3) begin
          #1ns `uvm_info("MAIN", $sformatf("@%0t phase stepping..", $time), UVM_LOW)
        end
        begin 
          if(this.get_name() == "comp[0]" && !reset_jump) begin
            `uvm_info("MAIN", "phase jumpping to reset phase", UVM_LOW)
            reset_jump = 1;
            #1ns phase.jump(uvm_reset_phase::get()); 
            #1ns;
          end
        end
      join_any
      disable fork;
      phase.drop_objection(this);
    endtask
  endclass
  class phase_jump_test extends uvm_test;
    `uvm_component_utils(phase_jump_test)
    component comp[2];
    function new(string name = "phase_jump_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      foreach(comp[i]) comp[i] = component::type_id::create($sformatf("comp[%0d]", i), this);
    endfunction
    task reset_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("RESET", "phase running", UVM_LOW)
      phase.drop_objection(this);
    endtask
    task configure_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("CONFIGURE", "phase running", UVM_LOW)
      phase.drop_objection(this);
    endtask
    task main_phase(uvm_phase phase);
      phase.raise_objection(this);
      `uvm_info("MAIN", "phase running", UVM_LOW)
      repeat(2) #1ns `uvm_info("MAIN", $sformatf("@%0t phase stepping..", $time), UVM_LOW)
      phase.drop_objection(this);
    endtask
  endclass
  initial run_test("phase_jump_test");
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test phase_jump_test...
// UVM_INFO tb_phase_jump.sv(12) @ 0: uvm_test_top.comp[0] [RESET] phase running
// UVM_INFO tb_phase_jump.sv(12) @ 0: uvm_test_top.comp[1] [RESET] phase running
// UVM_INFO tb_phase_jump.sv(53) @ 0: uvm_test_top [RESET] phase running
// UVM_INFO tb_phase_jump.sv(13) @ 1000: uvm_test_top.comp[0] [RESET] @1000 phase stepping..
// UVM_INFO tb_phase_jump.sv(13) @ 1000: uvm_test_top.comp[1] [RESET] @1000 phase stepping..
// UVM_INFO tb_phase_jump.sv(18) @ 1000: uvm_test_top.comp[0] [CONFIGURE] phase running
// UVM_INFO tb_phase_jump.sv(18) @ 1000: uvm_test_top.comp[1] [CONFIGURE] phase running
// UVM_INFO tb_phase_jump.sv(58) @ 1000: uvm_test_top [CONFIGURE] phase running
// UVM_INFO tb_phase_jump.sv(19) @ 2000: uvm_test_top.comp[0] [CONFIGURE] @2000 phase stepping..
// UVM_INFO tb_phase_jump.sv(19) @ 2000: uvm_test_top.comp[1] [CONFIGURE] @2000 phase stepping..
// UVM_INFO tb_phase_jump.sv(24) @ 2000: uvm_test_top.comp[0] [MAIN] phase running
// UVM_INFO tb_phase_jump.sv(24) @ 2000: uvm_test_top.comp[1] [MAIN] phase running
// UVM_INFO tb_phase_jump.sv(63) @ 2000: uvm_test_top [MAIN] phase running
// UVM_INFO tb_phase_jump.sv(31) @ 2000: uvm_test_top.comp[0] [MAIN] phase jumpping to reset phase
// UVM_INFO tb_phase_jump.sv(64) @ 3000: uvm_test_top [MAIN] @3000 phase stepping..
// UVM_INFO tb_phase_jump.sv(27) @ 3000: uvm_test_top.comp[0] [MAIN] @3000 phase stepping..
// UVM_INFO ${UVM_HOME}/base/uvm_phase.svh(1556) @ 3000: reporter [PH_JUMP] phase main (schedule uvm_sched, domain uvm) is jumping to phase reset
// UVM_WARNING @ 3000: main_objection [OBJTN_CLEAR] Object 'uvm_top' cleared objection counts for main_objection
// UVM_INFO tb_phase_jump.sv(12) @ 3000: uvm_test_top.comp[0] [RESET] phase running
// UVM_INFO tb_phase_jump.sv(12) @ 3000: uvm_test_top.comp[1] [RESET] phase running
// UVM_INFO tb_phase_jump.sv(53) @ 3000: uvm_test_top [RESET] phase running
// UVM_INFO tb_phase_jump.sv(13) @ 4000: uvm_test_top.comp[0] [RESET] @4000 phase stepping..
// UVM_INFO tb_phase_jump.sv(13) @ 4000: uvm_test_top.comp[1] [RESET] @4000 phase stepping..
// UVM_INFO tb_phase_jump.sv(18) @ 4000: uvm_test_top.comp[0] [CONFIGURE] phase running
// UVM_INFO tb_phase_jump.sv(18) @ 4000: uvm_test_top.comp[1] [CONFIGURE] phase running
// UVM_INFO tb_phase_jump.sv(58) @ 4000: uvm_test_top [CONFIGURE] phase running
// UVM_INFO tb_phase_jump.sv(19) @ 5000: uvm_test_top.comp[0] [CONFIGURE] @5000 phase stepping..
// UVM_INFO tb_phase_jump.sv(19) @ 5000: uvm_test_top.comp[1] [CONFIGURE] @5000 phase stepping..
// UVM_INFO tb_phase_jump.sv(24) @ 5000: uvm_test_top.comp[0] [MAIN] phase running
// UVM_INFO tb_phase_jump.sv(24) @ 5000: uvm_test_top.comp[1] [MAIN] phase running
// UVM_INFO tb_phase_jump.sv(63) @ 5000: uvm_test_top [MAIN] phase running
// UVM_INFO tb_phase_jump.sv(64) @ 6000: uvm_test_top [MAIN] @6000 phase stepping..
// UVM_INFO tb_phase_jump.sv(64) @ 7000: uvm_test_top [MAIN] @7000 phase stepping..
