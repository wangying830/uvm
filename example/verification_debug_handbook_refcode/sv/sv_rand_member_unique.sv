module tb;
  typedef struct packed {
    bit[31:0] addr;
    bit[ 1:0] opcode;
    bit[ 7:0] size;
  } packet_info_t;
  class packet;
    rand packet_info_t info;
    rand bit[31:0] data [];
    static packet_info_t info_q[$];
    constraint cstr {
      info.addr [1:0] == 0;
      info.addr inside {['h00:'h1F]};
      info.size inside {1, 4, 8, 16, 32, 64};
      data.size() == info.size;
      unique {info_q, info};
      // same effect as 'unique' but lower solution performance
      // foreach(info_q[i]) info != info_q[i]; 

    }
    function void post_randomize();
      info_q.push_back(info);
    endfunction
  endclass

  initial begin
    int rt = 0;
    packet p = new();
    forever begin
      if(p.randomize())
        $display("p randomization success at %0d times", ++rt);
      else begin
        $display("p randomization failure at %0d times", ++rt);
        break;
      end
    end
    $finish();
  end
endmodule



