interface rkv_intf1 #(type T = int);
  T data[];
endinterface
interface rkv_intf2 #(int N = 1);
  int data[N]; // N would effect data structure
  int val = N; // N would not effect data structure
endinterface

module tb;
  class rkv_packet1 #(type T = int);
    T data[];
  endclass
  class rkv_packet2 #(int N = 1);
    int data[N]; // N would effect data structure
    int val = N; // N would not effect data structure
  endclass

  rkv_intf1               intf0();
  rkv_intf1 #(string)     intf1();
  rkv_intf2               intf2();
  rkv_intf2 #(3)          intf3();

  initial begin
    virtual rkv_intf1               v_intf0;
    virtual rkv_intf1 #(string)     v_intf1;
    virtual rkv_intf2               v_intf2;
    virtual rkv_intf2 #(3)          v_intf3;
    v_intf0 = intf0;
    v_intf1 = intf1;
    v_intf2 = intf2;
    v_intf3 = intf3;
  end

  initial begin
    rkv_packet1             pkt0;
    rkv_packet1 #(string)   pkt1;
    rkv_packet2             pkt2;
    rkv_packet2 #(3)        pkt3;
    rkv_packet1             h_pkt0;
    rkv_packet1 #(string)   h_pkt1;
    rkv_packet2             h_pkt2;
    rkv_packet2 #(3)        h_pkt3;
    pkt0 = new();
    pkt1 = new();
    pkt2 = new();
    pkt3 = new();
    h_pkt0 = pkt0;
    h_pkt1 = pkt1;
    h_pkt2 = pkt2;
    h_pkt3 = pkt3;
  end
endmodule
