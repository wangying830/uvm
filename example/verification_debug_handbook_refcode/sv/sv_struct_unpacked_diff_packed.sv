module tb;
  typedef struct {
    rand bit[7:0] m1[4];
    int m2;
    byte m3[4];
  } data1_t;
  
  typedef struct packed {
    bit [7:0][3:0] m1;
    int unsigned m2;
    bit[31:0] m3;
  } data2_t;
  
  class packet;
    rand data1_t d1;
    rand data2_t d2;
    rand bit[95:0] vec;
    constraint cstr {vec == d2;};
  endclass
  
  initial begin
    packet p = new();
    void'(p.randomize());
    $display("p = %p", p);
  end
endmodule

// simulation result:
// p = '{d1:'{m1:'{'ha3, 'h8f, 'h11, 'h8a} , m2:0, m3:'{0, 0, 0, 0} }, d2:'{m1:'h97ae37b4, m2:'h6ec8f6d, m3:'heda662ac}, vec:'h97ae37b406ec8f6deda662ac}
