module tb;
  class packet;
    rand bit [7:0] data;
    constraint cstr1 {
      data inside {[0:31]};
    }
  endclass

  class user_packet extends packet;
    constraint cstr2 {
      data inside {[31:63]};
    }
  endclass

  initial begin
    user_packet up = new();
    repeat(3) begin
      if(!up.randomize())
        $error("up randomization failure");
      else
        $display("up.data is %0d", up.data);
    end
  end
endmodule

// simulation result
// up.data is 31
// up.data is 31
// up.data is 31



