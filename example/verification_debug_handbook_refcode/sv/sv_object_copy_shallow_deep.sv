package rkv_pkg;
  class transaction;
    bit[31:0] addr;
    bit[31:0] data;
    function new(bit[31:0] addr, bit[31:0] data);
      this.addr = addr;
      this.data = data;
    endfunction
    function void print(string name = "transaction");
      $display("%s addr = %0x, data = %0x", name, addr, data);
    endfunction
    function transaction copy();
      transaction t = new this;
      return t;
    endfunction
  endclass
  
  class packet;
    transaction tr1, tr2;
    function new(bit[31:0] addr, bit[31:0] data);
      tr1 = new(addr, data);
      tr2 = new tr1;
    endfunction
    function void print(string name = "packet");
      $display("%s sub children content is as follow:", name);
      tr1.print("tr1");
      tr2.print("tr2");
    endfunction
    function packet copy();
      packet p = new(0, 0);
      p.tr1 = tr1.copy();
      p.tr2 = tr2.copy();
      return p;
    endfunction
  endclass
endpackage

module tb;
  import rkv_pkg::*;
  transaction tr1, tr2;
  packet p1, p2;
  initial begin
    tr1 = new('h404, 'h302);
    tr1.print("tr1");
    tr2 = new tr1;
    tr2.print("tr2");
    p1 = new('h40, 'h20);
    p1.print("p1");
    p2 = p1.copy();
    p2.print("p2");
  end
endmodule

// simulation result:
// tr1 addr = 404, data = 302
// tr2 addr = 404, data = 302
// p1 sub children content is as follow:
// tr1 addr = 40, data = 20
// tr2 addr = 40, data = 20
// p2 sub children content is as follow:
// tr1 addr = 40, data = 20
// tr2 addr = 40, data = 20
