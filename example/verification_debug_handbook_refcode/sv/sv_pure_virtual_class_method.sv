module tb;
  virtual class abstract_packet;
    pure virtual function void content();
  endclass
  virtual class base_packet extends abstract_packet;
    function void content();
    endfunction
    pure virtual function void format();
  endclass
  class packet extends base_packet;
    function void format();
    endfunction
  endclass
  initial begin
    // ERROR abstract class cannot be instantiated
    // abstract_packet ap = new(); 
    // base_packet bp = new();
    packet p = new();
  end
endmodule
