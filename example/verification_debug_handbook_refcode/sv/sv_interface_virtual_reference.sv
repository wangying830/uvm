interface intf;
  logic a;
  logic b;
endinterface

class driver;
  virtual intf vif;
endclass

module tb;
  intf ifi0();
  intf ifi1();
  intf ifis[2] ();
  virtual intf vifs[4];
  driver drv;
  initial begin
    vifs = '{ifi0, ifi1, ifis[0], ifis[1]};
    vifs[0].a = 1'b1;
    drv = new();
    drv.vif = ifi1;
    drv.vif.b = 1'b0;
    $finish();
  end
endmodule


