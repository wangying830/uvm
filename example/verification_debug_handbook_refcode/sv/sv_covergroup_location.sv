package pkg;
  covergroup cg_pkg;
  endgroup
  class covmodel;
    covergroup cg_class;
    endgroup
    function new();
      cg_class = new();
    endfunction
    function init();
      cg_pkg cg_p1 = new();
    endfunction
  endclass
endpackage

interface intf;
  covergroup cg_intf;
  endgroup
  initial begin
    cg_intf cg_i1 = new();
    pkg::cg_pkg cg_p2 = new();
  end
endinterface

module tb;
  covergroup cg_mod;
  endgroup
  initial begin
    cg_mod cg_m1 = new();
  end
endmodule
