package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_comp2 extends uvm_component;
    `uvm_component_utils(rkv_comp2)
    function new(string name = "rkv_comp2", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      `uvm_warning("RUN", "rkv_comp2 run phase entered")
      `uvm_warning("RUN", "rkv_comp2 run phase exited")
    endtask
  endclass

  class rkv_comp1 extends uvm_component;
    rkv_comp2 c2;
    `uvm_component_utils(rkv_comp1)
    function new(string name = "rkv_comp1", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      c2 = rkv_comp2::type_id::create("c2", this);
    endfunction
    task run_phase(uvm_phase phase);
      super.run_phase(phase);
      `uvm_warning("RUN", "rkv_comp1 run phase entered")
      `uvm_warning("RUN", "rkv_comp1 run phase exited")
    endtask
  endclass

  class message_severity_surpress_test extends uvm_test;
    rkv_comp1 c1;
    rkv_comp2 c2;
    `uvm_component_utils(message_severity_surpress_test)
    function new(string name = "message_severity_surpress_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      c1 = rkv_comp1::type_id::create("c1", this);
      c2 = rkv_comp2::type_id::create("c2", this);
    endfunction
    
    function void end_of_elaboration_phase(uvm_phase phase);
      // available to override severity for specific component
      //c1.set_report_severity_id_override(UVM_WARNING, "RUN", UVM_INFO);
      //c1.c2.set_report_severity_id_override(UVM_WARNING, "RUN", UVM_INFO);

      // available to override severity hierarchically 
      set_report_severity_id_override_hier(UVM_WARNING, "RUN", UVM_INFO);
    endfunction

    function void set_report_severity_id_override_hier(uvm_severity cur_severity,
                                                  string id, 
                                                  uvm_severity new_severity,
                                                  int depth = 10
                                                  );
      uvm_component children[$];
      m_rh.set_severity_id_override(cur_severity, id, new_severity);
      get_depth_children(this, children, depth);
      foreach(children[i])
        children[i].m_rh.set_severity_id_override(cur_severity, id, new_severity);
    endfunction

    function void get_depth_children(input uvm_component h, 
                                     ref uvm_component children[$], 
                                     input int depth=1
                                    );
      if(depth > 0) begin
        foreach(h.m_children[i]) begin
          children.push_back(h.m_children[i]);
          get_depth_children(h.m_children[i], children, depth-1);
        end
      end
    endfunction
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("message_severity_surpress_test"); 
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test message_severity_surpress_test...
// UVM_INFO uvm_message_severity_surpress.sv(11) @ 0: uvm_test_top.c1.c2 [RUN] rkv_comp2 run phase entered
// UVM_INFO uvm_message_severity_surpress.sv(12) @ 0: uvm_test_top.c1.c2 [RUN] rkv_comp2 run phase exited
// UVM_INFO uvm_message_severity_surpress.sv(28) @ 0: uvm_test_top.c1 [RUN] rkv_comp1 run phase entered
// UVM_INFO uvm_message_severity_surpress.sv(29) @ 0: uvm_test_top.c1 [RUN] rkv_comp1 run phase exited
// UVM_INFO uvm_message_severity_surpress.sv(11) @ 0: uvm_test_top.c2 [RUN] rkv_comp2 run phase entered
// UVM_INFO uvm_message_severity_surpress.sv(12) @ 0: uvm_test_top.c2 [RUN] rkv_comp2 run phase exited
