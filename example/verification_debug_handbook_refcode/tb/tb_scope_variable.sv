module tb;
  int a = 10;
  int b = 20;
  initial begin: init_proc
    int a = 30;
    int b = 40;
    $display("init_proc:: a = %0d, b = %0d", a, b);
    print_var();
  end
  initial begin
    $display("tb:: a = %0d, b = %0d", a, b);
  end
  function automatic print_var();
    int a = 50;
    int b = 60;
    $display("print_var:: a = %0d, b = %0d", a, b);
  endfunction
endmodule

// simulation result:
// init_proc:: a = 30, b = 40
// print_var:: a = 50, b = 60
// tb:: a = 10, b = 20
