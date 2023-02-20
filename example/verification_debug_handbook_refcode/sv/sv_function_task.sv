module tb;
  function void func1();
  endfunction
  
  task t1();
    func1();
  endtask
  
  task t2();
    #1ns;
  endtask
  
  function void func2();
    // VCS compilation warning :
    // Warning-[TEIF] Task enabled inside a function
    t1();
    // VCS compilation error:
    // Error-[SV-DOSIF] Delay or synchronization in function
    t2();
  endfunction
  
  initial begin
    t1();
    func2();
  end
endmodule
