package rkv_pkg1;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class comp1 extends uvm_component;
    `uvm_component_utils(comp1)
    //`uvm_component_param_utils(comp1) // register only with type but no name
    function new(string name = "comp1", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
  class comp1x extends comp1;
    `uvm_component_utils(comp1x)
    function new(string name = "comp1x", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
  class comp1y extends comp1;
    `uvm_component_utils(comp1y)
    function new(string name = "comp1y", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
endpackage

package rkv_pkg2;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class comp1 extends uvm_component;
    `uvm_component_utils(comp1)
    //`uvm_component_param_utils(comp1) // register only with type but no name
    function new(string name = "comp1", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
  class comp1z extends comp1;
    `uvm_component_utils(comp1z)
    function new(string name = "comp1z", uvm_component parent = null);
      super.new(name, parent);
    endfunction
  endclass
endpackage

package rkv_pkg3;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  class component_registry_conflicts_test extends uvm_test;
    rkv_pkg1::comp1 c0;
    rkv_pkg2::comp1 c1;
    `uvm_component_utils(component_registry_conflicts_test)
    function new(string name = "component_registry_conflicts_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // ERROR override would effect irrelated types
      //set_type_override("comp1", "comp1x");
      //set_type_override_by_type(rkv_pkg1::comp1::get_type(), rkv_pkg1::comp1y::get_type());
      //set_type_override_by_type(rkv_pkg2::comp1::get_type(), rkv_pkg2::comp1z::get_type());

      // Available to specify the overrided instance than type
      //set_inst_override("c0", "comp1", "comp1x");
      //set_inst_override_by_type("c1", rkv_pkg2::comp1::get_type(), rkv_pkg2::comp1z::get_type());

      c0 = rkv_pkg1::comp1::type_id::create("c0", this);
      c1 = rkv_pkg2::comp1::type_id::create("c1", this);
      `uvm_info("build", "exited", UVM_LOW)
    endfunction
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg3::*;
  initial run_test("component_registry_conflicts_test");
endmodule

// simulation result
