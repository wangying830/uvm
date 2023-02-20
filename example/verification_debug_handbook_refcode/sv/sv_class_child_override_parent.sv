module tb;
  class parent;
    bit [7:0] vec1 = 8'h7; 
    virtual function bit[7:0] get_val();
      return vec1;
    endfunction
  endclass
  
  class child extends parent;
    bit [15:0] vec1 = 16'hff;
    // SAME 1) method name 2) args name & num 3) return type
    // polymorphism with virtual method declaration
    function bit[7:0] get_val();
      return vec1;
    endfunction
  endclass
  
  initial begin
    bit [7:0] val;
    parent p1 = new();
    child c1 = new();
    $display("p1 obj get_val() = 'h%0x", p1.get_val());
    $display("c1 obj get_val() = 'h%0x", c1.get_val());
    p1 = c1;
    $display("c1 obj get_val() = 'h%0x", p1.get_val());
    $finish();
  end
endmodule

// simulation result:
// p1 obj get_val() = 'h7
// c1 obj get_val() = 'hff
// c1 obj get_val() = 'hff
