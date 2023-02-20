package rkv_pkg;
  property prop2;
    1;
  endproperty
endpackage

interface intf;
  parameter bit verify_master = 1;
  property prop1;
    1;
  endproperty
  generate
    if(verify_master) begin
      ast_prop1: assert property(prop1);
      ast_prop2: assert property(rkv_pkg::prop2);
    end
    else begin
      asm_prop1: assume property(prop1);
      asm_prop2: assume property(rkv_pkg::prop2);
    end
  endgenerate
endinterface
