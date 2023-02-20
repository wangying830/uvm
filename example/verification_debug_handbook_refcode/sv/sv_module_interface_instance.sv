interface rkv_master_intf;
  int master_id;
endinterface

interface rkv_slave_intf;
  int slave_id;
endinterface

interface rkv_system_intf #(int master_num = 1, int slave_num = 1);
  rkv_master_intf master_ifs[master_num] ();
  rkv_slave_intf  slave_ifs[slave_num] ();
endinterface

module master #(int master_id = 0) (rkv_master_intf intf);
  initial intf.master_id = master_id;
endmodule

module slave #(int slave_id = 0) (rkv_slave_intf intf);
  initial intf.slave_id = slave_id;
endmodule

module top;
  master #(0) mst0 (sys_intf.master_ifs[0]);
  master #(1) mst1 (sys_intf.master_ifs[1]);
  slave  #(0) slv0 (sys_intf.slave_ifs[0]);
  slave  #(1) slv1 (sys_intf.slave_ifs[1]);
  rkv_system_intf #(.master_num(2), .slave_num(2)) sys_intf();
endmodule
