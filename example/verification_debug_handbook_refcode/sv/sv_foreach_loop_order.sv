module tb;
  int arr1 [2:0];
  int arr2 [1:3];
  int arr3 [int] = '{'h0:10, 'h4:20, 'h8:30};
  int arr4 [string] = '{"a":10, "b":20, "aa":30};
  initial foreach(arr1[i]) $display("arr1 index order %0d", i);
  initial foreach(arr2[i]) $display("arr2 index order %0d", i);
  initial foreach(arr3[i]) $display("arr3 index order %0d", i);
  initial foreach(arr4[i]) $display("arr4 index order %s", i);
endmodule

// simulation result:
// arr1 index order 2
// arr1 index order 1
// arr1 index order 0
// arr2 index order 1
// arr2 index order 2
// arr2 index order 3
// arr3 index order 0
// arr3 index order 4
// arr3 index order 8
// arr4 index order a
// arr4 index order aa
// arr4 index order b
