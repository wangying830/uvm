program automatic test(router_io.TB rtr_io);
  int run_for_n_packets;      // number of packets to test
  bit[3:0] sa;                        // source address
  bit[3:0] da;                        // destination address
  logic[7:0] payload[$];              // expected packet data array
  //Lab 3 - Task 2, Step 2
  //
  //Add a global declaration for queue used to store sampled data
  //ToDo
  logic[7:0] pkt2cmp_payload[$];      // actual packet data array


  initial begin
  	$vcdpluson;
    
    //Lab 3 - Task 6, Step 2
    //
    //Send 2000 packets
    //ToDo Caution!! Do only in Task 6
	run_for_n_packets = 2000;
  	reset();
	//这段把运行的顺序都给定义好了
	repeat(run_for_n_packets) begin

	  gen();
      
      //Lab 3 - Task 2, Step 3
      //
      //Execute receive routine recv() concurrently with send()
	  //followed by self-checking routine check()
      //ToDo
	  fork
	    send();
	    recv();
	  join

	  check();
    
	end
	repeat(10) @(rtr_io.cb);
    
  end
  
  task reset();
    rtr_io.reset_n = 1'b0;
    rtr_io.cb.frame_n <= '1;
    rtr_io.cb.valid_n <= '1;
    ##2 rtr_io.cb.reset_n <= 1'b1;
    repeat(15) @(rtr_io.cb);
  endtask: reset

  //这个gen task的随机化的任务，最后都放进了packet中，其中的new函数可以代替这些了 
  task gen();
  
    //Lab 3 - Task 6, Step 1
    //
    //Randomly generate sa and da
    //ToDo Caution!! Do only in Task 6
	sa = $urandom;
	da = $urandom;
	payload.delete(); //clear previous data
	repeat($urandom_range(4,2))
	  payload.push_back($urandom);

  endtask: gen

  task send();
  
	send_addrs();
	send_pad();
	send_payload();

  endtask: send

  task send_addrs();
  
	rtr_io.cb.frame_n[sa] <= 1'b0; //start of packet
	for(int i=0; i<4; i++) begin
	  rtr_io.cb.din[sa] <= da[i]; //i'th bit of da
	  @(rtr_io.cb);
	end

  endtask: send_addrs

  task send_pad();
  
	rtr_io.cb.frame_n[sa] <= 1'b0;
	rtr_io.cb.din[sa] <= 1'b1;
	rtr_io.cb.valid_n[sa] <= 1'b1;
	repeat(5) @(rtr_io.cb);

  endtask: send_pad

  task send_payload();
  
	foreach(payload[index])
	  for(int i=0; i<8; i++) begin
	    rtr_io.cb.din[sa] <= payload[index][i];
		rtr_io.cb.valid_n[sa] <= 1'b0; //driving a valid bit
		rtr_io.cb.frame_n[sa] <= ((i == 7) && (index == (payload.size() - 1)));
		@(rtr_io.cb);
	  end
	rtr_io.cb.valid_n[sa] <= 1'b1;
  endtask: send_payload

  //Lab 3 - Task 3, Step 1
  //
  //Declare the recv() task
  //ToDo
  task recv();

    //Lab 3 - Task 3, Step 2
    //
    //In recv() task call get_payload() to retrieve payload
    //ToDo
	get_payload();
  
  endtask: recv

  //Lab 3 - Task 3, Step 3
  //
  //Declare the get_payload() task
  //ToDo
  task get_payload();

    //Lab 3 - Task 3, Step 4
    //
    //In get_payload() delete content of pkt2cmp_payload[$]
    //ToDo
    pkt2cmp_payload.delete();

    //Lab 3 - Task 3, Step 5
    //
    //Continuing in get_payload() wait for falling edge of output frame signal
	//Implement a watchdog timer of 1000 clocks
    //ToDo
	//看门狗的目的就是为了防止时间到点了，还没采到数据结束标志吧,
	//和timeout error大概是一个道理吧
    fork
      begin: wd_timer_fork
      fork: frameo_wd_timer
        @(negedge rtr_io.cb.frameo_n[da]); //this is a thread by itself
        begin                              //this is another thread
          repeat(1000) @(rtr_io.cb);
      	$display("\n%m\n[ERROR]%t Frame signal timed out!\n", $realtime);
          $finish;
        end
      join_any: frameo_wd_timer
      disable fork;
      end: wd_timer_fork
    join

    //Lab 3 - Task 3, Step 6
    //
    //Continuing in get_payload() sample output of the router:
    //Loop until end of frame is detected.
    //Within the loop, assemble a byte of data at a time(8 clocks)
    //Store each byte in pkt2cmp_payload[$]
    //ToDo
    forever begin
      logic[7:0] datum;
	  //这个i=i设计的还是蛮有意思
      for(int i=0; i<8; i=i)  begin //i=i prevents VCS warning messages
        if(!rtr_io.cb.valido_n[da])
          datum[i++] = rtr_io.cb.dout[da];
		  //这是等待frame，到frame拉高
        if(rtr_io.cb.frameo_n[da])
          if(i==8) begin //byte alligned
      	  pkt2cmp_payload.push_back(datum);
		  //这里的return是什么意思呢？？？？？？，返回上一层吗？？还是说返回值的意思？？？
      	  return;      //done with payload
      	end

          //Lab 3 - Task 3, Step 7
          //也就是在处理收集的数据不是八位时的情况
		  //但是为什么这里的else 不是和前面的if对其，而是换了一行呢？？？逻辑有点乱？？？？？
          //If payload is not byte aligned, print message and end simulation
          //ToDo
      	else begin
      	  $display("\n%m\n[ERROR]%t Packet payload not byte aligned!\n", $realtime);
      	  $finish;
      	end
        @(rtr_io.cb);
      end
	  //这是i=8之后的情况了吧，，但是为什么要再把数据装一遍呢？？？
      pkt2cmp_payload.push_back(datum);
    end
  endtask: get_payload

  //Lab 3 - Task 4, Step 1
  //
  //Create function compare() which returns single bit
  //and has pass-by-reference string argument
  //ToDo
  //返回值的0表示比对失败，1表示比对成功
  function bit compare(ref string message);

    //Lab 3 - Task 4, Step 2
    //
    //In compare() compare data payload[$] with pkt2cmp_payload[$]
    //If sizes do not match
    //   set string argument with description of error
    //   terminate subroutine by returning a 0
    //If data matches (you can directly compare arrays using ==)
    //   set string argument with description of success
    //   terminate subroutine successfully by returning a 1
    //If data does not match
    //   set string argument with description of error
    //   terminate subroutine by returning a 0
    //ToDo
    if(payload.size() != pkt2cmp_payload.size()) begin
      message = "Payload size Mismatch:\n";
      message = { message, $sformatf("payload.size() = %0d, pkt2cmp_payload.size() = %0d\n", payload.size(), pkt2cmp_payload.size()) };
      return (0);
    end
    if(payload == pkt2cmp_payload) ;
    else begin
      message = "Payload Content Mismatch:\n";
      message = { message, $sformatf("Packet Sent:   %p\nPkt Received:   %p", payload, pkt2cmp_payload) };
      return (0);
    end
    message = "Successfully Compared";
    return(1);
  endfunction: compare

  //Lab 3 - Task 4, Step 3
  //
  //Create task called check()
  //ToDo
  task check();

    //Lab 3 - Task 4, Step 4
    //
    //In check() declare a string variable message
    //keep a count of packets checked with variable pkts_checked
    //ToDo
	//还可以有字符串 变量信息这么一说呀，就好在不同的情况下，赋予不同的字符串内容，
	//这样的话，依据情况就可以答应不同的字符串了， 也是一种该变量的形式呢
    string message;
	//定义的pkt的顺序
    static int pkts_checked = 0;

    //Lab 3 - Task 4, Step 4
    //
    //In check() call compare() to check the packet received
    //If error detected print error message and end simulation
    //If successful print message indicating number of packets checked
    //ToDo
    if (!compare(message)) begin
      $display("\n%m\n[ERROR]%t Packet #%0d %s\n", $realtime, pkts_checked, message);
      $finish;
    end
    $display("[NOTE]%t Packet #%0d %s", $realtime, pkts_checked++, message);
  endtask: check

endprogram: test
