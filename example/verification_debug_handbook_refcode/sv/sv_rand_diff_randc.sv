module tb;
  typedef enum {SINGLE, BURST, INCR, WRAP, OUTORDER} command_t;
  class packet;
    rand command_t cmd_r;
    bit cmd_r_arr[command_t];
    randc command_t cmd_rc;
    bit cmd_rc_arr[command_t];
    int rtimes;
    function void post_randomize();
      cmd_r_arr[cmd_r] = 1;
      cmd_rc_arr[cmd_rc] = 1;
      rtimes++;
    endfunction
    typedef bit cmd_arr_t [command_t];
    function bit is_command_complete(ref cmd_arr_t arr);
      command_t rq [$] = {SINGLE, BURST, INCR, WRAP, OUTORDER};
      command_t q[$];
      foreach(arr[cmd]) q.push_back(cmd);
      return (rq == q);
    endfunction
    function void rand_command_complete(ref cmd_arr_t arr);
      forever begin
        void'(this.randomize());
        if(is_command_complete(arr)) begin
          $display("rand(c) array got complete command list with %0d times randomization", rtimes);
          return;
        end
      end
    endfunction
  endclass

  initial begin
    packet p = new();
    p.rand_command_complete(p.cmd_rc_arr);
    p.rand_command_complete(p.cmd_r_arr);
  end
endmodule

// simulation result:
// rand(c) array got complete command list with 5 times randomization
// rand(c) array got complete command list with 12 times randomization
