module tb;
  class rkv_packet;
    rand bit[3:0] dyn_arr[];
    rand bit[3:0] que_arr[$];
    constraint c1 {dyn_arr.size inside {[2:5]}; que_arr.size == dyn_arr.size();}
  endclass

  class rkv_trans;
    rand rkv_packet pkt;
    function new();
      pkt = new();
    endfunction
  endclass

  initial begin
    rkv_trans tr = new();
    if(!tr.randomize()) $error("randomization failure!");
    $display("tr content = %p", tr);
    $display("tr.pkt content = %p", tr.pkt);
  end
endmodule

// simulation result:
// tr content = '{pkt:{ ref to class rkv_packet}}
// tr.pkt content = '{dyn_arr:'{'h3, 'hf, 'h1, 'ha, 'h4} , que_arr:'{'h3, 'h2, 'h9, 'he, 'h0} }
