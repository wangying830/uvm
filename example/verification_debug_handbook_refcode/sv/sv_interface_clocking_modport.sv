interface rkv_intf(input logic clk);
  logic req, grt;
  logic [7:0] addr, data;
  clocking cb @(posedge clk);
    input grt;
    output req, addr;
    inout data;
  endclocking
  modport mod_dut ( 
    input clk, req, addr, // async dut modport
    output grt,
    inout data 
  );
  modport mod_ck_tb (clocking cb); // synchronous testbench modport
  modport mod_tb ( 
    input grt, // async testbench modport
    output req, addr,
    inout data 
  );
endinterface
