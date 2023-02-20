package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_config extends uvm_object;
    int comp_num = 1;
    `uvm_object_utils(rkv_config)
    function new(string name = "rkv_config");
      super.new(name);
    endfunction
  endclass
  class rkv_component extends uvm_component;
    local bit _ctrl = 1;
    `uvm_component_utils(rkv_component)
    function new(string name = "rkv_component", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function bit get_ctrl();
      return _ctrl;
    endfunction
  endclass
  class rkv_env extends uvm_component;
    rkv_config cfg;
    rkv_component comps[];
    `uvm_component_utils(rkv_env)
    function new(string name = "rkv_env", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      if(!uvm_config_db#(rkv_config)::get(this,"","cfg", cfg)) begin
        `uvm_error("GETCFG","cannot get rkv_config handle from config DB")
      end
      comps = new[cfg.comp_num];
      for(int i=0; i<cfg.comp_num; i++)
        comps[i] = rkv_component::type_id::create($sformatf("comps[%0d]", i), this);
    endfunction
    function bit get_ctrl(int id = 0);
      if(id < cfg.comp_num && comps[id] != null)
        return comps[id].get_ctrl();
      else 
        return 0;
    endfunction
  endclass
  class cross_hier_access_test extends uvm_component;
    rkv_config cfg;
    rkv_env env;
    `uvm_component_utils(cross_hier_access_test)
    function new(string name = "cross_hier_access_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      cfg = rkv_config::type_id::create("cfg", this);
      cfg.comp_num = 3;
      uvm_config_db#(rkv_config)::set(this,"env","cfg", cfg);
      env = rkv_env::type_id::create("env", this);
    endfunction
    task run_phase(uvm_phase phase);
      bit ctrl;
      phase.raise_objection(this);
      // suggested way
      ctrl = env.get_ctrl(2);
      `uvm_info("GETVAL", $sformatf("comp[2] ctrl bit is %0d", ctrl), UVM_LOW)
      // available but not best
      ctrl = env.comps[1].get_ctrl();
      `uvm_info("GETVAL", $sformatf("comp[1] ctrl bit is %0d", ctrl), UVM_LOW)
      phase.drop_objection(this);
    endtask
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("cross_hier_access_test");
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test cross_hier_access_test...
// UVM_INFO uvm_cross_hier_access.sv(61) @ 0: uvm_test_top [GETVAL] comp[2] ctrl bit is 1
// UVM_INFO uvm_cross_hier_access.sv(64) @ 0: uvm_test_top [GETVAL] comp[1] ctrl bit is 1
