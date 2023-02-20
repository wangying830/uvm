module tb;
  logic v1, v2;
  bit clk;
  initial forever #5ns clk <= !clk;
  initial #21ns v1 <= 1'b1; 
  initial #28ns v2 <= 1'b1; 
  initial begin
    fork
      while(1) begin
        if(v1 === 1'b1) begin
          $display("@%0t got v1 === 1'b1", $time);
          break;
        end
        // important to add delay
        #10ns;
      end
      forever begin
        if(v2 === 1'b1) begin
          $display("@%0t got v2 === 1'b1", $time);
          break;
        end
        // blocking statement added
        @(posedge clk);
      end
    join
    $display("@%0t blocking process exited", $time);
    $finish();
  end
endmodule

// simulation time
// @30000 got v1 === 1'b1
// @35000 got v2 === 1'b1
// @35000 blocking process exited
