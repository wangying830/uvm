module tb;
  typedef struct packed {
    bit [31:0] addr;
    bit [ 7:0] opcode;
    bit [ 3:0] [31:0] data ;
  } packeta_t;

  typedef struct {
    rand bit [31:0] addr;
    rand bit [ 7:0] opcode;
         bit [31:0] data [4];
  } packetb_t;

  class packet;
    rand packeta_t pkta;
    rand packetb_t pktb;
  endclass

  initial begin
    packet pkt = new();
    assert(pkt.randomize()) 
    else $error("randomization failure");
    $finish();
  end
endmodule



