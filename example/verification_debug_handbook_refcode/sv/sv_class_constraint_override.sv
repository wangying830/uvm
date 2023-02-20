module tb;
  class base_c;
    rand byte unsigned i;
    constraint c {i inside {[10:12]};}
    virtual function void print();
    endfunction
  endclass

  class der_c extends base_c;
    rand byte unsigned i;
    constraint c {i inside {[20:22]};}
    function void print();
      $display("der_c::i = %0d, base_c::i = %0d", i, super.i);
    endfunction
  endclass

  initial begin
    der_c inst = new();
    base_c bch = inst;
    if(inst.randomize())
      inst.print();
    if(bch.randomize())
      bch.print();
  end
endmodule

// simulation result:
// der_c::i = 20, base_c::i = 163
// der_c::i = 20, base_c::i = 214
