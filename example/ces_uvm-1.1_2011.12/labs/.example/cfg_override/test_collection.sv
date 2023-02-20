//
// The following macro defines a wrapper method for the proxy create() call.
// The intent is to create configuration objects which has a context.
// Because the configuration objects have context, one can then use
// set_inst_override to factory replace chosen configuration within a
// configuration hierarchy.
//

`define create_cfg_utils(T) \
  static function T create_cfg(string name, contxt); \
    create_cfg = T::type_id::create(name,,contxt); \
    create_cfg.contxt = {contxt, ".", create_cfg.get_name()}; \
  endfunction

//
// The following is a wrapper class over the uvm_object base class to
// provide for context distinction.
//

class cfg_base extends uvm_object;

  // The added property:
  string contxt;

  `uvm_object_utils_begin(cfg_base)
    `uvm_field_string(contxt, UVM_ALL_ON)
  `uvm_object_utils_end

  // Macro used to provide wrapper method for proxy create()
  `create_cfg_utils(cfg_base)

  function new(string name="cfg_base");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  // get_full_name() method returns the context for factory replacement
  virtual function string get_full_name();
    return this.contxt;
  endfunction
endclass

//
// The following three classes creates a configuration hierarchy
//
class drv_cfg extends cfg_base;
  rand int port_id;
  `uvm_object_utils_begin(drv_cfg)
    `uvm_field_int(port_id, UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end

  // Macro used to provide wrapper method for proxy create()
  `create_cfg_utils(drv_cfg)

  constraint valid { port_id inside {[0:15]}; }
  function new(string name="drv_cfg");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new
endclass

class agent_cfg extends cfg_base;
  rand int port_id;
       drv_cfg d_cfg;

  `uvm_object_utils_begin(agent_cfg)
    `uvm_field_int(port_id, UVM_ALL_ON | UVM_DEC)
    `uvm_field_object(d_cfg, UVM_ALL_ON)
  `uvm_object_utils_end

  // Macro used to provide wrapper method for proxy create()
  `create_cfg_utils(agent_cfg)

  constraint valid { port_id inside {[0:15]}; }
  function new(string name="agent_cfg");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  // I'm creating sub-configurations in post_randomize().  There are other
  // approches one can take.
  function void post_randomize();
    super.post_randomize();

    // The wrapper method is used to create the configuration object.  Note
    // that one must pass in the context (use get_full_name()).  This
    // context field will be use by the factory as the discreminant to
    // determine whether to override or not.
    d_cfg = drv_cfg::create_cfg("d_cfg", this.get_full_name());
    d_cfg.randomize() with { this.port_id == local::port_id; };
  endfunction
endclass

class env_cfg extends cfg_base;
  rand int total_ports;
  rand int num_of_ports_to_test;
  rand bit valid_ports[];
       agent_cfg a_cfg[];

  `uvm_object_utils_begin(env_cfg)
    `uvm_field_int(total_ports, UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(num_of_ports_to_test, UVM_ALL_ON | UVM_DEC)
    `uvm_field_array_int(valid_ports, UVM_ALL_ON)
    `uvm_field_array_object(a_cfg, UVM_ALL_ON)
  `uvm_object_utils_end

  // Macro used to provide wrapper method for proxy create()
  `create_cfg_utils(env_cfg)

  constraint valid { num_of_ports_to_test inside {[1:total_ports]}; valid_ports.size() == total_ports; num_of_ports_to_test == valid_ports.sum(); }
  function new(string name="env_cfg");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction

  function void post_randomize();
    super.post_randomize();
    a_cfg = new[total_ports];
    foreach(valid_ports[i]) begin
      if (valid_ports[i]) begin
        // The wrapper method is used to create the configuration object.
        a_cfg[i] = agent_cfg::create_cfg($sformatf("a_cfg[%0d]", i), this.get_full_name());
        a_cfg[i].randomize() with { this.port_id == local::i; };
      end
    end
  endfunction
endclass

class test_base extends uvm_test;
  env_cfg e_cfg;
  `uvm_component_utils(test_base)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    // The wrapper method is used to create the configuration object.
    e_cfg = env_cfg::create_cfg("e_cfg", this.get_full_name());
    e_cfg.randomize() with { total_ports == 8; };
    e_cfg.print();
  endfunction: build_phase

  virtual function void start_of_simulation_phase(uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    uvm_top.print_topology();
    factory.print();
  endfunction: start_of_simulation_phase
endclass: test_base

class drv_test_cfg extends drv_cfg;
  `uvm_object_utils(drv_test_cfg)

  // Macro used to provide wrapper method for proxy create()
  `create_cfg_utils(drv_test_cfg)

  function new(string name="drv_test_cfg");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  function void post_randomize();
    super.post_randomize();
    this.port_id = 15;
  endfunction
endclass

//
// The following test executes a type override
//
// > make test=test_cfg_type_override
//
class test_cfg_type_override extends test_base;
  `uvm_component_utils(test_cfg_type_override)
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  // In this example, the override must come before super.build_phase()
  // call.  The reason is that the super.build_phase() calls randomize()
  // which creates all the sub-configuration components in the
  // post_randomize() method.
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    set_type_override("drv_cfg", "drv_test_cfg");
    super.build_phase(phase);
  endfunction
endclass

//
// The following test executes an instance override
//
// > make test=test_cfg_inst_override
//
class test_cfg_inst_override extends test_base;
  `uvm_component_utils(test_cfg_inst_override)
  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  // In this example, the override must come before super.build_phase()
  // call.  The reason is that the super.build_phase() calls randomize()
  // which creates all the sub-configuration components in the
  // post_randomize() method.
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    set_inst_override("e_cfg.a_cfg[3].d_cfg", "drv_cfg", "drv_test_cfg");
    super.build_phase(phase);
  endfunction
endclass
