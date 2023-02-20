package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_config extends uvm_object;
    bit ctrl0;
    bit ctrl1;
    `uvm_object_utils(rkv_config)
    function new(string name = "rkv_config");
      super.new(name);
    endfunction
  endclass
  class rkv_component extends uvm_component;
    bit ctrl0;
    bit ctrl1;
    rkv_config cfg;
    `uvm_component_utils(rkv_component)
    function new(string name = "rkv_component", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      if(!uvm_config_db#(rkv_config)::get(this,"","cfg", cfg)) begin
        `uvm_error("GETCFG","cannot get rkv_config handle from config DB")
      end
    endfunction
  endclass
  class rkv_env extends uvm_component;
    rkv_component comp;
    `uvm_component_utils(rkv_env)
    function new(string name = "rkv_env", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      comp = rkv_component::type_id::create("comp", this);
      // available access
      comp.ctrl0 = 0;
      // ERROR access
      // comp.cfg.ctrl0 = 1;
    endfunction
    function void end_of_elaboration_phase(uvm_phase phase);
      // available access
      comp.ctrl0 = 0;
      comp.cfg.ctrl0 = 1;
    endfunction
  endclass
  class lower_hier_access_issue_test extends uvm_component;
    rkv_config cfg;
    rkv_env env;
    `uvm_component_utils(lower_hier_access_issue_test)
    function new(string name = "lower_hier_access_issue_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      cfg = rkv_config::type_id::create("cfg", this);
      env = rkv_env::type_id::create("env", this);
      uvm_config_db#(rkv_config)::set(this,"env.comp","cfg", cfg);
      // ERROR access
      // env.comp.ctrl1 = 1;
      // env.comp.cfg.ctrl1 = 1;
    endfunction
    function void end_of_elaboration_phase(uvm_phase phase);
      // available access
      env.comp.ctrl1 = 1;
      env.comp.cfg.ctrl1 = 1;
    endfunction
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("lower_hier_access_issue_test");
endmodule
