interface rkv_intf;
endinterface

package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  typedef enum {WRITE, READ, IDLE} command_t;
  typedef struct {
    string name;
    int num;
  } score_t;
  class rkv_comp extends uvm_component;
    command_t cmd;
    string info;
    score_t score;
    bit[1:0] ctrl;
    virtual rkv_intf vif;
    `uvm_component_utils(rkv_comp)
    function new(string name = "rkv_comp", uvm_component parent = null);
      super.new(name, parent);
      if(!uvm_config_db#(int)::get(this, "", "cmd", cmd))
        `uvm_warning("CFGGET","cannot get cmd from config DB")
      else
        `uvm_info("CFGGET", $sformatf("Got cmd = %s", cmd), UVM_LOW)
      if(!uvm_config_db#(integer)::get(this, "", "cmd", cmd))
        `uvm_warning("CFGGET","cannot get cmd from config DB via integer type")
      else
        `uvm_info("CFGGET", $sformatf("Got cmd = %s", cmd), UVM_LOW)
      if(!uvm_config_db#(byte)::get(this, "", "cmd", cmd))
        `uvm_warning("CFGGET","cannot get cmd from config DB via byte type")
      else
        `uvm_info("CFGGET", $sformatf("Got cmd = %s", cmd), UVM_LOW)
      if(!uvm_config_db#(string)::get(this, "", "info", info))
        `uvm_warning("CFGGET","cannot get info from config DB")
      else
        `uvm_info("CFGGET", $sformatf("Got info = %s", info), UVM_LOW)
      if(!uvm_config_db#(score_t)::get(this, "", "score", score))
        `uvm_warning("CFGGET","cannot get score from config DB")
      else
        `uvm_info("CFGGET", $sformatf("Got score name = %s, num = %0d", score.name, score.num), UVM_LOW)
      if(!uvm_config_db#(bit[1:0])::get(this, "", "ctrl", ctrl))
        `uvm_warning("CFGGET","cannot get score from config DB")
      else
        `uvm_info("CFGGET", $sformatf("Got ctrl = 'b%0b", ctrl), UVM_LOW)
      if(!uvm_config_db#(bit[3:0])::get(this, "", "ctrl", ctrl))
        `uvm_warning("CFGGET","cannot get ctrl from config DB via bit[3:0] type")
      else
        `uvm_info("CFGGET", $sformatf("Got ctrl = 'b%0b", ctrl), UVM_LOW)
      if(!uvm_config_db#(virtual rkv_intf)::get(this, "", "vif", vif))
        `uvm_warning("CFGGET","cannot get vif from config DB")
      else
        `uvm_info("CFGGET", "Got vif", UVM_LOW)
    endfunction
  endclass

  class config_set_get_type_test extends uvm_test;
    rkv_comp c1;
    string info = "config";
    score_t score = '{name:"check", num:100};
    bit [1:0] ctrl = 2'b01;
    virtual rkv_intf vif;
    `uvm_component_utils(config_set_get_type_test)
    function new(string name = "config_set_get_type_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      uvm_config_db#(int)::set(this, "c1", "cmd", 1);
      uvm_config_db#(string)::set(this, "c1", "info", info);
      uvm_config_db#(score_t)::set(this, "c1", "score", score);
      uvm_config_db#(bit[1:0])::set(this, "c1", "ctrl", ctrl);
      uvm_config_db#(virtual rkv_intf)::set(this, "c1", "vif", vif);
      c1 = rkv_comp::type_id::create("c1", this);
    endfunction
  endclass 
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("config_set_get_type_test"); 
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test config_set_get_type_test...
// UVM_INFO uvm_config_set_get_type.sv(24) @ 0: uvm_test_top.c1 [CFGGET] Got cmd = READ
// UVM_WARNING uvm_config_set_get_type.sv(26) @ 0: uvm_test_top.c1 [CFGGET] cannot get cmd from config DB via integer type
// UVM_WARNING uvm_config_set_get_type.sv(30) @ 0: uvm_test_top.c1 [CFGGET] cannot get cmd from config DB via byte type
// UVM_INFO uvm_config_set_get_type.sv(36) @ 0: uvm_test_top.c1 [CFGGET] Got info = config
// UVM_INFO uvm_config_set_get_type.sv(40) @ 0: uvm_test_top.c1 [CFGGET] Got score name = check, num = 100
// UVM_INFO uvm_config_set_get_type.sv(44) @ 0: uvm_test_top.c1 [CFGGET] Got ctrl = 'b1
// UVM_WARNING uvm_config_set_get_type.sv(46) @ 0: uvm_test_top.c1 [CFGGET] cannot get ctrl from config DB via bit[3:0] type
// UVM_INFO uvm_config_set_get_type.sv(52) @ 0: uvm_test_top.c1 [CFGGET] Got vif
