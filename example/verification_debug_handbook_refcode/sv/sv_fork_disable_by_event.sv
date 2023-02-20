module tb;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  class event_data extends uvm_object;
    int unsigned id;
    `uvm_object_utils(event_data)
    function new(string name = "event_data");
    endfunction
  endclass

  task automatic run_time(int t, int id);
    uvm_event stop_e = uvm_event_pool::get_global("stop_e");
    uvm_object tmp;
    event_data ed;
    fork
      #(t*1ns);
      begin
        forever begin
          stop_e.wait_trigger_data(tmp);
          void'($cast(ed, tmp));
          if(id == ed.id) begin
            $display("@%0t:: run_time thread[%0d] is disabled", $time, id);
            disable fork; // disable itself while id matches
          end
        end
      end
    join_any
    $display("@%0t:: run_time thread[%0d] finished", $time, id);
  endtask

  initial begin
    event_data ed = new("ed");
    uvm_event stop_e = uvm_event_pool::get_global("stop_e");
    for(int i=0; i<5; i++) begin
      automatic int t = i;
      fork
        run_time($urandom_range(10, 20), t);
      join_none
    end
    ed.id = 3;
    #5ns stop_e.trigger(ed); // disable the specified id
    wait fork;
  end
endmodule

// simualtion result
// @5000:: run_time thread[3] is disabled
// @11000:: run_time thread[1] finished
// @11000:: run_time thread[3] finished
// @12000:: run_time thread[4] finished
// @17000:: run_time thread[0] finished
// @19000:: run_time thread[2] finished
