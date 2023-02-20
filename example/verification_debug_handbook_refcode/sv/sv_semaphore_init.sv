module tb;
  class rkv_key;
    local semaphore _key;
    local int _key_count;
    local int _key_max;
    function new(int knum = 1);
      _key = new(knum);
      _key_count = knum;
      _key_max = knum;
    endfunction
    function int get_count();
      return _key_count;
    endfunction
    task get_key(int knum = 1);
      _key.get(knum);
      _key_count -= knum;
    endtask
    function bit put_key(int knum = 1);
      if(knum + _key_count <= _key_max) begin
        _key.put(knum);
        _key_count += knum;
        return 1;
      end
    endfunction
  endclass

  rkv_key key;
  initial begin
    key = new(3);
    $display("key is initialized with count %0d", key.get_count());
    key.get_key(2);
    $display("key current count is %0d after get key num = 2", key.get_count());
    for(int i = 3; i > 0; i--) begin
      if(key.put_key(i)) begin
        $display("key current count is %0d after put key num = %0d", key.get_count(), i);
        break;
      end
      else
        $display("key current count %0d and can NOT put key num = %0d", key.get_count(), i);
    end
    $finish();
  end
endmodule

// simulation result:
// key is initialized with count 3
// key current count is 1 after get key num = 2
// key current count 1 and can NOT put key num = 3
// key current count is 3 after put key num = 2
