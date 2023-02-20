module rkv_mod1(inout io);
  logic out0;
  assign io = out0 !== 1'bz ? out0 : 1'bz;
  // behavior model
  initial begin
    forever begin
      out0 <= 1'bz;
      #($urandom_range(1, 3)*1ns);
      wait(io === 1'bz);
      out0 <= $urandom_range(0, 1);
      #($urandom_range(1, 3)*1ns);
      out0 <= 1'bz;
    end
  end
endmodule

module rkv_mod2(
  input logic in0
  ,output logic out0
  ,output logic out0_en
);
  initial begin
    forever begin
      out0_en <= 0;
      #($urandom_range(2, 4)*1ns);
      wait(in0 === 1'bz);
      out0_en <= 1'b1;
      out0 <= $urandom_range(0, 1);
      #($urandom_range(2, 4)*1ns);
      out0_en <= 1'b0;
    end
  end
endmodule

module rkv_mod3(inout io);
  logic out0_en;
  logic out0;
  rkv_mod2 m1(
    .in0(io)
    ,.out0(out0)
    ,.out0_en(out0_en)
  );
  assign io = out0_en ? out0 : 1'bz;
endmodule

module rkv_top;
  wire logic io0, io1;
  
  rkv_mod1 m1(io0);
  rkv_mod1 m2(io0);

  rkv_mod3 m3(io1);
  rkv_mod3 m4(io1);
endmodule


