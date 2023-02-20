`define A_CFG 100
`define B_CFG 200
`define addr_map(arg) `arg
`define suffix CFG
program test;

initial begin
  int addr;


  `ifdef TEST_A
    `define prefix A_
  `else
    `define prefix B_
  `endif

  addr = `addr_map(`prefix```suffix);
  $display("addr = %0d", addr);
end

endprogram

