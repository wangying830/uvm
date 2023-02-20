module tb;
  event sync_e1, sync_e2;
  bit flag1, flag2;
  initial begin : ini_pro1
    $display("ini_proc1 triggered sync event sync_e1");
    -> sync_e1;
    wait(sync_e2.triggered);
    $display("ini_proc1 got sync event sync_e2");
    flag1 = 1;
  end
  initial begin : ini_pro2
    wait(sync_e1.triggered);
    $display("ini_proc2 got sync event sync_e1");
    -> sync_e2;
    $display("ini_proc2 triggered sync event sync_e2");
    flag2 = 1;
  end
  initial begin
    wait({flag1, flag2} == 2'b11);
    $display("ini_proc1 and ini_proc2 finished!");
    $finish();
  end
endmodule

// simulation result:
// ini_proc1 triggered sync event sync_e1
// ini_proc2 got sync event sync_e1
// ini_proc2 triggered sync event sync_e2
// ini_proc1 got sync event sync_e2
// ini_proc1 and ini_proc2 finished!
