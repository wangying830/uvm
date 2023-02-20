module tb;
  int q1[$] = {0, 1, 2, 6};
  int q2[$] = {3, 4};
  initial begin
    q1.insert(3, 5); //  '5' is an element type q1 = {0, 1, 2, 5, 6}
    //q1.insert(3, q2); // unavailble operation due to q2 is not an element
    q1 = {q1[0:2], q2, q1[3:$]}; // availble insertion
    $display("%p", q1);
  end
endmodule

// simulation result:
// '{0, 1, 2, 3, 4, 5, 6}
