module tb;
  class c0;
    string type_self = "c0";
    string type_shared = "c1";
  endclass
  class c1 extends c0;
    string type_self = "c1";
  endclass
  class c2 extends c1;
    string type_self = "c2";
    function new();
      this.type_shared = "c2";
      $display("type_shared = %s", super.type_shared);
      $display("this.type_self = %s", this.type_self);
      $display("super.type_self = %s", super.type_self);
    endfunction
  endclass

  initial begin
    c2 c2_inst = new();
    $finish();
  end
endmodule

// simulatio result:
// type_shared = c2
// this.type_self = c2
// super.type_self = c1
