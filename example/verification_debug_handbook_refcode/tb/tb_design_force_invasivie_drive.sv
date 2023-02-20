module rkv_mod (
  input   logic [3:0]   in_p0
  ,output logic [3:0]  out_p0
  );
  parameter string name = "rkv_mod";
  initial begin
    out_p0 <= 0;
    forever begin
      #5ns out_p0 <= out_p0 + 1;
      if(out_p0 == 'hF) break;
    end
  end
  always_comb $display("@%0t:: %s in_p0 = 'h%0x", $time, name, in_p0);
  always_comb $display("@%0t:: %s out_p0 = 'h%0x", $time, name, out_p0);
endmodule

module rkv_top;
  logic [3:0] w0, w1;
  rkv_mod #("m0") m0(w0, w1);
  rkv_mod #("m1") m1(w1, w0);
endmodule

interface rkv_intf;
  // mimic driver from testbench
  logic [3:0] d0, d1;
  task drive(ref logic [3:0] d);
    d = 1;
    forever begin
      #5ns d = d << 1;
      if(d == 0) break;
    end
  endtask
  initial begin
    fork
      drive(d0);
      drive(d1);
    join
    $finish();
  end
endinterface

module rkv_tb;
  rkv_top top();
  rkv_intf intf();
  // invasive force from testbench and seperate design drive logic
  always_comb begin
    force top.m0.out_p0 = intf.d0;
    force top.m1.out_p0 = intf.d1;
  end
endmodule

// simulation result:
// @0:: m0 out_p0 = 'h1
// @0:: m1 in_p0 = 'h1
// @5000:: m0 out_p0 = 'h2
// @5000:: m1 in_p0 = 'h2
// @10000:: m0 out_p0 = 'h4
// @10000:: m1 in_p0 = 'h4
// @15000:: m0 out_p0 = 'h8
// @15000:: m1 in_p0 = 'h8
