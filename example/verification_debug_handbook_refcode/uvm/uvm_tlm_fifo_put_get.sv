package rkv_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  class rkv_trans extends uvm_object;
    int data;
    `uvm_object_utils(rkv_trans)
    function new(string name = "rkv_trans");
      super.new(name); 
    endfunction
  endclass

  class rkv_fifo #(type T = rkv_trans) extends uvm_tlm_analysis_fifo #(T);
    int buffer [];
    function new(string name = "rkv_fifo", uvm_component parent = null);
      super.new(name, parent); 
    endfunction
    task get_data(int ntrans);
      T t;
      repeat(ntrans) begin
        get(t); // blocking get data (data consuming behaivor)
        buffer = {buffer, t.data}; // compose a new dynamic array
        `uvm_info("GETDATA", $sformatf("@time %0t::buffer content is %p", $time, buffer), UVM_LOW)
      end
    endtask
  endclass

  class tlm_fifo_put_get_test extends uvm_test;
    rkv_fifo fifo;
    `uvm_component_utils(tlm_fifo_put_get_test)
    function new(string name = "tlm_fifo_put_get_test", uvm_component parent = null);
      super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      fifo = new("fifo", this);
    endfunction

    task run_phase(uvm_phase phase);
      rkv_trans t;
      int ntr = 5;
      super.run_phase(phase);
      phase.raise_objection(this);
      fork 
        // mimic the data pushed into the target analysis fifo
        begin
          for(int i=1; i<=ntr; i++) begin
            t = new();
            t.data = i;
            fifo.put(t);
            #10ns;
          end
        end
        // mimic the data popped from fifo in parallel
        begin
          fifo.get_data(ntr);
        end
      join
      phase.drop_objection(this);
    endtask
  endclass
endpackage

module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import rkv_pkg::*;
  initial run_test("tlm_fifo_put_get_test"); 
endmodule

// simulation result:
// UVM_INFO @ 0: reporter [RNTST] Running test tlm_fifo_put_get_test...
// UVM_INFO uvm_tlm_fifo_put_get.sv(23) @ 0: uvm_test_top.fifo [GETDATA] @time 0::buffer content is '{1} 
// UVM_INFO uvm_tlm_fifo_put_get.sv(23) @ 10000: uvm_test_top.fifo [GETDATA] @time 10000::buffer content is '{1, 2} 
// UVM_INFO uvm_tlm_fifo_put_get.sv(23) @ 20000: uvm_test_top.fifo [GETDATA] @time 20000::buffer content is '{1, 2, 3} 
// UVM_INFO uvm_tlm_fifo_put_get.sv(23) @ 30000: uvm_test_top.fifo [GETDATA] @time 30000::buffer content is '{1, 2, 3, 4} 
// UVM_INFO uvm_tlm_fifo_put_get.sv(23) @ 40000: uvm_test_top.fifo [GETDATA] @time 40000::buffer content is '{1, 2, 3, 4, 5} 
