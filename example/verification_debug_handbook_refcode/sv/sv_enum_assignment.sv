module tb;
  typedef enum {RED=1, GREEN, BLUE, YELLOW} color_t;
  int val;
  color_t clr;
  initial begin
    $display("clr = %s OR %0d", clr, clr);
    clr = GREEN;
    val = clr;
    $display("clr = %s, val = %0d", clr, val);
    // legal value and type conversion
    val = 4;
    clr = color_t'(val);
    $display("clr = %s, val = %0d", clr, val);
    // illegal value and type conversion
    val = 6;
    clr = color_t'(val);
    $display("clr = %s, val = %0d", clr, val);
    // $cast(TGT, SRC)
    val = 6;
    if(!$cast(clr, val))
      $error("casting failure while val = %0d", val);
    else
      $display("clr = %s, val = %0d", clr, val);
    $finish();
  end
endmodule

// simulation result:
// clr =  OR 0
// clr = GREEN, val = 2
// clr = YELLOW, val = 4
// clr = , val = 6
// Error: "sv_enum_assignment.sv", 21: tb: at time 0 ps
// casting failure while val = 6

