module tb;
  int val;
  function automatic int fun_foo(int a);
    return a;
  endfunction

  task automatic tsk_foo(ref int a);
    forever begin
      @a;
      if(a < 5) $display("a = %0d", a);
      else return;
    end
  endtask

  initial begin
    fun_foo(val);
    tsk_foo(val);
    $finish();
  end
  
  initial begin
    for(int i = 0; i< 10; i++) 
      #1ns val = i;
  end
endmodule

// simulation result:
// a = 1
// a = 2
// a = 3
// a = 4
