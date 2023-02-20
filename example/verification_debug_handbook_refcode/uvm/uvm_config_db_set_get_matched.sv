package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class rkv_config #(type T = int) extends uvm_object;
    T data[];
    `uvm_object_param_utils(rkv_config)
    function new(string name = "rkv_config");
      super.new(name);
    endfunction
  endclass
  class rkv_component extends uvm_component;
    int ctrl0;
    byte ctrl1;
    bit ctrl2;
    rkv_config#(byte unsigned) cfg;
    `uvm_component_utils(rkv_component)
    function new(string name = "rkv_component", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      if(!uvm_config_db#(rkv_config#(byte unsigned))::get(get_parent(),"","cfg", cfg)) begin
        `uvm_warning("GETCFG","cannot get rkv_config #(byte unsigned) handle from config DB")
      end
      if(!uvm_config_db#(int)::get(this,"","ctrl", ctrl0)) begin
        `uvm_warning("GETCFG","cannot get ctrl (int type) from config DB")
      end
      if(!uvm_config_db#(byte)::get(this,"","ctrl", ctrl1)) begin
        `uvm_warning("GETCFG","cannot get ctrl (byte type) from config DB")
      end
      if(!uvm_config_db#(bit)::get(this,"","ctrl", ctrl2)) begin
        `uvm_warning("GETCFG","cannot get ctrl (bit type) from config DB")
      end
    endfunction
  endclass
  class rkv_env extends uvm_component;
    uvm_object cfg0;
    rkv_config cfg1;
    rkv_config#(byte) cfg2;
    rkv_config#(byte unsigned) cfg3;
    rkv_component comp;
    `uvm_component_utils(rkv_env)
    function new(string name = "rkv_env", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      if(!uvm_config_db#(uvm_object)::get(this,"","cfg", cfg0)) begin
        `uvm_warning("GETCFG","cannot get uvm_object handle from config DB")
      end
      if(!uvm_config_db#(rkv_config)::get(this,"","cfg", cfg1)) begin
        `uvm_warning("GETCFG","cannot get rkv_config #(int) handle from config DB")
      end
      if(!uvm_config_db#(rkv_config#(byte))::get(this,"","cfg", cfg2)) begin
        `uvm_warning("GETCFG","cannot get rkv_config #(byte) handle from config DB")
      end
      if(!uvm_config_db#(rkv_config#(byte unsigned))::get(this,"","cfg", cfg3)) begin
        `uvm_warning("GETCFG","cannot get rkv_config #(byte unsigned) handle from config DB")
      end
      comp = rkv_component::type_id::create("comp", this);
    endfunction
  endclass
  class config_set_get_matched_test extends uvm_component;
    rkv_config #(byte unsigned) cfg;
    rkv_env env;
    `uvm_component_utils(config_set_get_matched_test)
    function new(string name = "config_set_get_matched_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      cfg = new("cfg");
      //cfg = rkv_config#(byte unsigned)::type_id::create("cfg", this);
      uvm_config_db#(rkv_config#(byte unsigned))::set(this,"env","cfg", cfg);
      uvm_config_db#(bit)::set(this,"env*","ctrl", 1);
      env = rkv_env::type_id::create("env", this);
    endfunction
    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      phase.drop_objection(this);
    endtask
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("config_set_get_matched_test");
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test config_set_get_matched_test...
// UVM_WARNING uvm_config_db_set_get_matched.sv(47) @ 0: uvm_test_top.env [GETCFG] cannot get uvm_object handle from config DB
// UVM_WARNING uvm_config_db_set_get_matched.sv(50) @ 0: uvm_test_top.env [GETCFG] cannot get rkv_config #(int) handle from config DB
// UVM_WARNING uvm_config_db_set_get_matched.sv(53) @ 0: uvm_test_top.env [GETCFG] cannot get rkv_config #(byte) handle from config DB
// UVM_WARNING uvm_config_db_set_get_matched.sv(25) @ 0: uvm_test_top.env.comp [GETCFG] cannot get ctrl (int type) from config DB
// UVM_WARNING uvm_config_db_set_get_matched.sv(28) @ 0: uvm_test_top.env.comp [GETCFG] cannot get ctrl (byte type) from config DB
