module tb;
  class packet;
    rand bit[3:0] dyn_arr[];
    rand bit[3:0] que_arr[$];
    constraint cstr {dyn_arr.size inside {[2:5]}; que_arr.size == dyn_arr.size();}
  endclass

  initial begin
    packet p = new();
    p.randomize() ;
    $display("p content = %p", p);
    p.dyn_arr.rand_mode(0);
    p.randomize() ;
    $display("p content = %p", p);
    p.rand_mode(1);
    p.randomize() with {dyn_arr.size() == 3;};
    $display("p content = %p", p);
  end
endmodule

// simulation result:
// p content = '{dyn_arr:'{'h3, 'hf, 'h1, 'ha, 'h4} , que_arr:'{'h3, 'h2, 'h9, 'he, 'h0} }
// p content = '{dyn_arr:'{'h3, 'hf, 'h1, 'ha, 'h4} , que_arr:'{'h6, 'h7, 'h6, 'h1, 'h3} }
// p content = '{dyn_arr:'{'h1, 'he, 'h3} , que_arr:'{'hc, 'h9, 'h2} }
