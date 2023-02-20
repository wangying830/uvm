module tb;
  int s1 = 0;
  int s2 = 0;
  
  task fork1_t;
    fork
      begin
        #10ns;
        $display("@%0t: time is %0t", $time, $time);
      end
      begin
        wait(s1==1);
        $display("@%0t: disable fork", $time);
        disable fork; // disable current child thread
      end
    join_none
  endtask
  
  task fork2_t;
    fork:fork2
      begin: thread2
        #20ns;
        $display("@%0t: time is %t", $time, $time);
      end
      begin
        wait(s2==1);
        $display("@%0t: disable fork2", $time);
        //disable fork; // disable current scope thread
        disable fork2; // disable parent thread and its children threads
        //disable thread2; 
      end
    join_none
  endtask
  
  initial begin
    fork1_t();
    wait fork;
    $display("@%0t: fork1 exited", $time);
  end
  
  initial begin
    fork2_t();
    wait fork;
    $display("@%0t: fork2 exited", $time);
  end
  
  initial begin
    #15ns s2 = 1;
  end
endmodule

// simulation result:
// @10000: time is 10000
// @15000: disable fork2
// @15000: fork2 exited
