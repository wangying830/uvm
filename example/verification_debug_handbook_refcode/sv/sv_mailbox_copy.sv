module tb;
  mailbox #(string) m1, m2;
  string s;
  initial begin
    m1 = new();
    m1.put("cake");
    m1.put("crackers");
    m1.put("cookies");
    m1.put("pie");
    m2 = new m1;
    while(m1.try_get(s)) begin
      $display("m1 content is %p", s);
    end
    while(m2.try_get(s)) begin
      $display("m2 content is %p", s);
    end
  end
endmodule

// simulation result
// VCS
// m1 content is "cake"
// m1 content is "crackers"
// m1 content is "cookies"
// m1 content is "pie"

// Questa
// m1 content is "cake"
// m1 content is "crackers"
// m1 content is "cookies"
// m1 content is "pie"
// m2 content is "cake"
// m2 content is "crackers"
// m2 content is "cookies"
// m2 content is "pie"
