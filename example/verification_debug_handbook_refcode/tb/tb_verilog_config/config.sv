config cfg1;
  design work.top;
  default liblist work;
endconfig

config cfg2;
  design work.top;
  default liblist work;
  instance top.m1_inst.m2_inst liblist tblib;
endconfig
