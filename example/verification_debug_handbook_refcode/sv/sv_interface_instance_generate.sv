interface genif;
endinterface

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  localparam IFS_NUM = 4;

  // suggested way with generate-loop
  genvar i;
  genif ifs[IFS_NUM]();
  generate
    for(i =0; i<IFS_NUM; i++) begin
      initial begin
        uvm_config_db#(virtual genif)::set(uvm_root::get(), $sformatf("uvm_test_top.*agents[%0d]*", i), "vif", ifs[i]);
      end
    end
  endgenerate

  // available solution but not flexible due to constant index
  initial begin
    uvm_config_db#(virtual genif)::set(uvm_root::get(), "uvm_test_top.*agents[0]*", "vif", ifs[0]);
    uvm_config_db#(virtual genif)::set(uvm_root::get(), "uvm_test_top.*agents[1]*", "vif", ifs[1]);
    uvm_config_db#(virtual genif)::set(uvm_root::get(), "uvm_test_top.*agents[2]*", "vif", ifs[2]);
    uvm_config_db#(virtual genif)::set(uvm_root::get(), "uvm_test_top.*agents[3]*", "vif", ifs[3]);
  end
endmodule
