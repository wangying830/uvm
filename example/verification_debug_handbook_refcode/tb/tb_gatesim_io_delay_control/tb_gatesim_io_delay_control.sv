
module tb;
  logic port0, dport0;
  logic port1, dport1;
  logic port2, dport2;
  logic port3, dport3;
  logic port4, dport4;

  `include "io_delay_include.svh"

  // mimic port assignment delay
  initial begin
    forever begin
      #10ns;
      port0 <= $urandom_range(0, 1);
      port1 <= $urandom_range(0, 1);
      port2 <= $urandom_range(0, 1);
      port3 <= $urandom_range(0, 1);
      port4 <= $urandom_range(0, 1);
    end
  end

  assign #PORT0_DELAY dport0 = port0;
  assign #PORT1_DELAY dport1 = port1;
  assign #PORT2_DELAY dport2 = port2;
  assign #PORT3_DELAY dport3 = port3;
  assign #PORT4_DELAY dport4 = port4;

endmodule
