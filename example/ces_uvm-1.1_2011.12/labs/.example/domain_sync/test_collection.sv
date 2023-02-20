`ifndef TEST_COLLECTION__SV
`define TEST_COLLECTION__SV

`define uvm_component_constructor \
  function new(string name, uvm_component parent); \
    super.new(name, parent); \
  endfunction: new

typedef class my_component_base;

class test_base extends my_component_base;
  my_component_base#(10) comp0;
  my_component_base#(100) comp1;
  my_component_base#(50) comp2;
  uvm_domain d0, d1, d2;
  `uvm_component_utils(test_base)
  `uvm_component_constructor

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    d0 = new("domain0");
    d1 = new("domain1");
    d2 = new("domain2");
    comp0 = my_component_base#(10)::type_id::create("comp0", this);
    comp1 = my_component_base#(100)::type_id::create("comp1", this);
    comp2 = my_component_base#(50)::type_id::create("comp2", this);
    comp0.set_domain(d0);
    comp1.set_domain(d1);
    comp2.set_domain(d2);
//    d0.sync(.target(d1), .phase(uvm_main_phase::get()));
    d0.sync(.target(d1), .phase(uvm_configure_phase::get()));
    d1.sync(.target(d2), .phase(uvm_configure_phase::get()));
//    d2.sync(.target(d1), .phase(uvm_main_phase::get()), .with_phase(uvm_shutdown_phase::get()));
  endfunction: build_phase
endclass

`define my_function_phase(phase_method_name) \
  virtual function void phase_method_name(uvm_phase phase); \
    uvm_domain phase_domain = phase.get_domain(); \
    uvm_domain component_domain = this.get_domain(); \
    super.phase_method_name(phase); \
    `uvm_info($sformatf("%m"), $sformatf("phase domain is: %s", phase_domain.get_name()), UVM_MEDIUM); \
    `uvm_info($sformatf("%m"), $sformatf("component domain is: %s", component_domain.get_name()), UVM_MEDIUM); \
  endfunction: phase_method_name

`define my_task_phase(phase_method_name) \
  virtual task phase_method_name(uvm_phase phase); \
    uvm_domain phase_domain = phase.get_domain(); \
    uvm_domain component_domain = this.get_domain(); \
    super.phase_method_name(phase); \
    phase.raise_objection(this); \
    `uvm_info($sformatf("%m"), $sformatf("phase domain is: %s", phase_domain.get_name()), UVM_MEDIUM); \
    `uvm_info($sformatf("%m"), $sformatf("component domain is: %s", component_domain.get_name()), UVM_MEDIUM); \
    #($urandom_range(delay)); \
    phase.drop_objection(this); \
  endtask: phase_method_name


class my_component_base #(delay=0) extends uvm_component;
  typedef my_component_base #(delay) this_type;
  `uvm_component_param_utils(this_type)
  `uvm_component_constructor

  `my_function_phase(build_phase)
  `my_function_phase(connect_phase)
  `my_function_phase(end_of_elaboration_phase)
  `my_function_phase(start_of_simulation_phase)
  `my_function_phase(extract_phase)
  `my_function_phase(check_phase)
  `my_function_phase(report_phase)
  `my_function_phase(final_phase)

  `my_task_phase(run_phase)

  `my_task_phase(reset_phase)
  `my_task_phase(pre_configure_phase)
  `my_task_phase(configure_phase)
  `my_task_phase(post_configure_phase)
  `my_task_phase(main_phase)
  `my_task_phase(shutdown_phase)
endclass
`endif

