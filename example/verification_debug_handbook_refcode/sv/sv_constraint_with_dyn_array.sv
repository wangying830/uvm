module tb;
  class constr_arr;
    int dynarr [], dynsub[];
    rand int a, b;
    constraint cstr {
      a inside {dynsub};
      b inside dynarr;
    }
    function void pre_randomize();
      dynsub = dynarr[0:2];
    endfunction
  endclass

  initial begin
    constr_arr c1 = new();
    // pre-define elements for constraint solution
    c1.dynarr = '{10,20,30,40,50,60}; // 6 elements
    c1.randomize();
    $display("c1.a= %0d", c1.a);
    $display("c1.b= %0d", c1.b);
  end
endmodule

// simulation result:
// c1.a= 10
// c1.b= 40
