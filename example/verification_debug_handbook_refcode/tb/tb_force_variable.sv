module mod;
  int data;
endmodule
module tb;
  class packet;
    int data;
  endclass
  mod m();
  initial begin: t1
    int addr;
    packet p = new();
    p.data = 10;
    // Error object's member cannot be forced
    // force p.data = 20;
    force m.data = 20;
    #20ns;
    $display("p.data = %0d, m.data = %0d, t1.addr = %0d", 
             p.data, m.data, addr);
  end
  initial begin: t2
    #10ns;
    force t1.addr = 30;
  end
endmodule
