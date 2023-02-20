module tb;
  class c1;
    rand int m_type = 0;
    rand int m_id = 0;
    constraint  cstr {soft m_type == 1; soft m_id == 1;}
  endclass
  
  class c2 extends c1;
    c1 c1_inst;
    function new();
      c1_inst = new();
      m_type = 2;
      m_id = 2;
      c1_inst.randomize with {m_type == local::this.m_type; m_id == local::this.m_id;};
    endfunction
  endclass
  
  initial begin
    c2 c2_inst = new();
    $display("c2 body : %p \n c2_inst.c1_inst body : %p", c2_inst, c2_inst.c1_inst);
    $finish();
  end
endmodule

// simulation result:
// c2 body : '{m_type:2, m_id:2, c1_inst:{ ref to class c1}} 
// c2_inst.c1_inst body : '{m_type:2, m_id:2}
