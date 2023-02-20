module tb;
  class rkv_packet;
  endclass

  initial begin
    rkv_packet pkt = new();
    int arr [] = new[3];
    mailbox #(int )bx = new(1);
    semaphore key = new(1);
    event ev;
  end
endmodule
