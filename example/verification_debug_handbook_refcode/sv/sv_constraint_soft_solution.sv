module tb;
  class packet;
    rand int v;
    constraint cstr1 {
      soft v inside {[10:20]};
    };
    constraint cstr2 {
      soft v inside {[30:40]};
    };
  endclass
  initial begin
    packet p = new();
    if(!p.randomize() with {soft v inside {[40:50]};})
      $error("randomization failure!");
    else
      $display("v = %0d", p.v);
  end
endmodule

// simulation result:
// v = 40
