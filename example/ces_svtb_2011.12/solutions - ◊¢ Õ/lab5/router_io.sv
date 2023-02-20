interface router_io(input bit clock);
  logic		reset_n;
  logic [15:0]	din;
  logic [15:0]	frame_n;
  logic [15:0]	valid_n;
  logic [15:0]	dout;
  logic [15:0]	valido_n;
  logic [15:0]	busy_n;
  logic [15:0]	frameo_n;

  //信号的方向是相对于modport而存在的
  clocking cb @(posedge clock);
    default input #1 output #1;
    output reset_n;
    output din;
    output frame_n;
    output valid_n;
    input dout;
    input valido_n;
    input busy_n;
    input frameo_n;
  endclocking

  
  //modport可以将信号分组， 这样TB也就不用再定义端口信号的input output等了
  //但是为什么这里，还要给出一个reset_n呢，有意义吗？？
  modport TB(clocking cb, output reset_n);
endinterface
