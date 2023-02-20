module tb;
  bit [3:0][7:0] arr_mixed [1:0];
  logic [15:0] vec16;
  logic [31:0] vec32;
  logic [63:0] vec64;
  bit arr_unpacked [1:0][3:0][7:0];
  bit arr_unpacked_d2 [4][8];
  bit [1:0][3:0][7:0] arr_packed;

  initial begin: arr_assign
    $display("packed vector/arry assignment");
    vec16 = 16'hFFFF;  xdisplay("vec16", vec16);
    vec16 = '1; xdisplay("vec16", vec16);
    vec16 = {4{4'hF}}; xdisplay("vec16", vec16);
    vec32 = vec16; xdisplay("vec32", vec32);
    vec32 = 'hFF; xdisplay("vec32", vec32);
    vec64 = {vec32, vec32}; xdisplay("vec64", vec64);

    $display("packed array slice assignment");
    arr_mixed[0] = vec32; xdisplay("arr_mixed[0]", arr_mixed[0]);
    arr_mixed[1] = vec64; xdisplay("arr_mixed[1]", arr_mixed[1]);
    arr_packed[0] = arr_mixed[1]; xdisplay("arr_packed[0]", arr_packed[0]);
    // Errors below
    // arr_packed = arr_mixed;
    // arr_unpacked = arr_mixed;  

    $display("unpacked array slice assignment");
    //arr_unpacked_d2 = '{0:'{0:0, 1:0, default:1}, 1:'{0:1, 1:1, default:0}, default:'{default:1}};
    arr_unpacked_d2 = '{'{0:0, 1:0, default:1}, '{0:1, 1:1, default:0}, '{0:0, 1:0, default:1}, '{0:1, 1:1, default:0}};
    arr_unpacked_d2[0] = '{default:1};
    arr_unpacked[0] = arr_unpacked_d2;
    $finish();
  end

  function void xdisplay(string s, logic[63:0] val);
    $display("%s = 'h%x", s, val);
  endfunction
endmodule

// simulation result:
// packed vector/arry assignment
// vec16 = 'h000000000000ffff
// vec16 = 'h000000000000ffff
// vec16 = 'h000000000000ffff
// vec32 = 'h000000000000ffff
// vec32 = 'h00000000000000ff
// vec64 = 'h000000ff000000ff
// packed array slice assignment
// arr_mixed[0] = 'h00000000000000ff
// arr_mixed[1] = 'h00000000000000ff
// arr_packed[0] = 'h00000000000000ff
// unpacked array slice assignment
