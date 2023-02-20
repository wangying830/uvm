module tb;
  logic cond0 = 1'bx;
  logic [1:0] val0 = 2'b01, val1 = 2'b10;
  logic [1:0] res;

  initial begin
    if(cond0 != 0) 
      res = val0;
    else
      res = val1;
    $display("if(cond0 != 0) result in res = 'b%0b", res);
  end

  initial begin
    if(cond0 !== 0) 
      res = val0;
    else
      res = val1;
    $display("if(cond0 !== 0) result in res = 'b%0b", res);
  end

  initial begin
    res = (cond0 != 0) ? val0 : val1;
    $display("(cond0 != 0) ?: result in res = 'b%0b", res);
  end

  initial begin
    res = (cond0 !== 0) ? val0 : val1;
    $display("(cond0 !== 0) ?: result in res = 'b%0b", res);
  end
endmodule

// simulation result
// if(cond0 != 0) result in res = 'b10
// if(cond0 !== 0) result in res = 'b1
// (cond0 != 0) ?: result in res = 'bxx
// (cond0 !== 0) ?: result in res = 'b1
