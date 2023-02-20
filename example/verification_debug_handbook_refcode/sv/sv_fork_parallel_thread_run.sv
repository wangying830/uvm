module tb;
  task run_time_static (int n, string s = "run_time");
    int d;
    d = n;
    #1ns;
    #(d * 1ns);
    $display("@%0t [%s] finished", $time, s);
  endtask
  
  task automatic run_time_automatic (int n, string s = "run_time");
    int d;
    d = n;
    #1ns;
    #(d * 1ns);
    $display("@%0t [%s] finished", $time, s);
  endtask
  
  initial begin
    for(int i = 1; i <= 3; i++) begin : run_time_static_proc
      fork
        run_time_static(i, "run_time1");
      join_none
    end
    wait fork;
  
    for(int j = 1; j <= 3; j++) begin : run_time_static_with_auto_var_proc
      automatic int n = j;
      fork
        run_time_static(n, "run_time2");
      join_none
    end
    wait fork;
  
    for(int k = 1; k <= 3; k++) begin : run_time_auto_with_auto_var_proc
      automatic int n = k;
      fork
        run_time_automatic(n, "run_time3");
      join_none
    end
    wait fork;
  end
endmodule

// simulation result:
// @5000 [run_time1] finished
// @5000 [run_time1] finished
// @5000 [run_time1] finished
// @9000 [run_time2] finished
// @9000 [run_time2] finished
// @9000 [run_time2] finished
// @11000 [run_time3] finished
// @12000 [run_time3] finished
// @13000 [run_time3] finished

