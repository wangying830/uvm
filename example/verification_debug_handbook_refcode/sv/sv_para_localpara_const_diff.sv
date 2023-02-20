module mod_a;
  parameter int data_width_p = 32;
  parameter int addr_width_p = 16;
  localparam int data_bytes_lp = data_width_p >> 3;
  localparam int addr_bytes_lp = addr_width_p >> 3;
endmodule

module tb;
  localparam int data_width_lp = 64;
  localparam int addr_width_lp = 32;
  const int data_width = 64; // declaration with initial value
  const int addr_width = 32; // declaration with value assigned later (only once)

  mod_a #(data_width_lp, addr_width_lp) m1();
  mod_a m2();
  defparam m2.data_width_p = 128;
  defparam m2.addr_width_p = 64;

  task automatic init();
    localparam int data_val_lp = 10;
    const int data = data_val_lp;
  endtask

  initial begin
    init();
  end
endmodule
