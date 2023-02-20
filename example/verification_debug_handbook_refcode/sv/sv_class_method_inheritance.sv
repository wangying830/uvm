module tb;
  class pkt;
    protected byte unsigned _data;
    function new(int unsigned ini = 'h33);
      _data = ini;
    endfunction
    function byte unsigned get_data();
      return _data;
    endfunction
  endclass
  class enc_pkt extends pkt;
    function shortint unsigned get_data(bit enc = 0);
      get_data = enc ? (_data << 1) : super.get_data();
    endfunction
  endclass

  initial begin
    enc_pkt ept = new();
    pkt pt = ept;
    $display("ept member _data is 'h%0x via ept.get_data()", ept.get_data(1));
    $display("ept member _data is 'h%0x via pt.get_data()", pt.get_data());
  end
endmodule

// simulation result
// ept member _data is 'h66 via ept.get_data()
// ept member _data is 'h33 via pt.get_data()

