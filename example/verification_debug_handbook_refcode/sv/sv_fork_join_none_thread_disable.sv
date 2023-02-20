module tb;
  task automatic report_time(int n, int id);
    #(n*1ns) $display("@%0t timer[%0d] asserted", $time, id);
  endtask

  task fork_timer;
    fork
      report_time(10, 1);
      report_time(20, 2);
      report_time(30, 3);
    join_none
  endtask
  
  initial begin
    fork_timer;
    #25ns disable fork;
    $display("@%0t fork threads are disabled", $time);
    $finish();
  end
endmodule

// simulation result:
// @10000 timer[1] asserted
// @20000 timer[2] asserted
// @25000 fork threads are disabled
