module tb;
  function automatic void extend_array(inout int arr[]);
    arr = new[arr.size()+1] (arr);
  endfunction

  task automatic wait_array_size(ref int arr[], input int size);
    wait(arr.size() == size);
  endtask

  int arr[];

  initial begin : extend_proc
    for(int i=0; i<10; i++) begin
      extend_array(arr);
      arr[arr.size()-1] = i;
      #1ns;
    end
  end 

  initial begin : wait_proc
    wait_array_size(arr, 5);
    $display("arr size reached 5 with members %p", arr);
    $finish();
  end
endmodule

// simulation result:
// arr size reached 5 with members '{0, 1, 2, 3, 4}
