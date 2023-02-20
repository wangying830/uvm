module tb;
  task automatic report_time(int n, int id);
    repeat(n) begin
      #1ns $display("timer[%0d] time is %0t", id, $time);
    end
  endtask
  
  initial begin
    fork
      repeat(3) begin
        fork
          report_time(2, 1);
          report_time(3, 2);
        join_any
        disable fork;
        $display("DISABLE FORK");
      end
    join_none
    wait fork;
    $finish();
  end
endmodule

// simulation result
// timer[1] time is 1000
// timer[2] time is 1000
// timer[1] time is 2000
// DISABLE FORK
// timer[1] time is 3000
// timer[2] time is 3000
// timer[1] time is 4000
// DISABLE FORK
// timer[1] time is 5000
// timer[2] time is 5000
// timer[1] time is 6000
// DISABLE FORK

