
typedef enum {WRITE, READ, IDLE} rkv_op_t;

class rkv_packet;
  rand int unsigned data;
  rand rkv_op_t t;
endclass

class rkv_transaction;
  rand rkv_packet pkts[];
  constraint cstr {pkts.size inside {[3:5]};}
  function void post_randomize();
    foreach(pkts[i]) begin
      pkts[i] = new();
      void'(pkts[i].randomize());
    end
  endfunction
endclass

