package rkv_pkg;
  parameter int ADDR_WIDTH = 16;
  parameter int DATA_WIDTH = 32;

  int cur_trans_id = 0;

  typedef enum {IDLE, RUN, WAIT, ABORT} state_t;
  state_t cur_trans_state = IDLE;

  class packet;
    rand byte unsigned data[];
  endclass

  covergroup data_cg with function sample(byte unsigned data);
    coverpoint data;
  endgroup
endpackage

module tb;
  import rkv_pkg::*;
  packet ps[];
  data_cg cg;
  initial begin
    ps = new[5];
    cg = new();
    foreach(ps[i]) begin
      packet p;
      ps[i] = new();
      p = ps[i];
      rkv_pkg::cur_trans_id = i;
      void'(p.randomize());
      foreach(p.data[j]) begin
        cg.sample(p.data[j]);
      end
    end
  end
endmodule
