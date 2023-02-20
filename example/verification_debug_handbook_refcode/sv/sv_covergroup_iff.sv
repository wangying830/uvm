module tb;
  bit[3:0] var1, var2;
  bit flag0, flag1, flag2;
  event sample_e;
  
  covergroup covg1(ref bit[3:0] d1, ref bit[3:0] d2) @(sample_e iff flag0);
    coverpoint d1 iff(flag1);
    coverpoint d2 iff(flag2);
  endgroup

  covergroup covg2 with function sample(bit[3:0] d1, bit[3:0] d2);
    coverpoint d1 iff(flag1);
    coverpoint d2 iff(flag2);
  endgroup
  
  initial begin
    covg1 cg1 = new(var1, var2);
    covg2 cg2 = new();
    fork
      forever #10ns -> sample_e;
      begin
        #100ns flag0 = 1;
        #100ns flag1 = 1;
        #100ns flag2 = 1;
      end
      forever begin
        @sample_e;
        var1++;
        var2++;
      end
      forever begin
        @(sample_e iff flag0);
        cg2.sample(var1, var2);
        if(cg1.get_coverage() == 100 && cg2.get_coverage() == 100) begin
          $display("@%0t :coverge reached 100%%", $time);
          $finish();
        end
      end
    join
  end
endmodule

// simulation result:
// @450000 :coverge reached 100%
