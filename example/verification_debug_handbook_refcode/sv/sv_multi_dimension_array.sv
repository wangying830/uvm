module tb;
  typedef struct {
    rand int d0[];
  } ds0_t;
  typedef struct {
    rand ds0_t d1[];
  } ds1_t;

  class data_pool;
    int arr_dyn_d1 [][];
    rand int arr_dyn_d2 [][];
    rand int arr_dyn_d3 [][][];
    rand ds1_t arr_dyn_d4 [];
    int arr_fix_d1 [2][3][4];
    rand int arr_fix_d2 [2][3][4];
    constraint cstr {
      // constraint to dynnamic array with 2-dimesion
      arr_dyn_d2.size() == 2;
      foreach(arr_dyn_d2[i]) arr_dyn_d2[i].size() == 3;

      // constraint to dynnamic array with 3-dimesion
      arr_dyn_d3.size() inside {[1:2]};
      foreach(arr_dyn_d3[i]) { 
        arr_dyn_d3[i].size() inside {[2:3]};
        foreach(arr_dyn_d3[i][j]) arr_dyn_d3[i][j].size() inside {[3:4]};
      }
      // constraint to dynnamic array with 3-dimesion
      arr_dyn_d4.size() inside {[1:2]};
      foreach(arr_dyn_d4[i]) { 
        arr_dyn_d4[i].d1.size() inside {[2:3]};
        foreach(arr_dyn_d4[i].d1[j]) arr_dyn_d4[i].d1[j].d0.size() inside {[3:4]};
      }
    }
  endclass

  class dim0;
    rand int d0[];
    constraint cstr {
      d0.size() inside {[3:4]};
    }
  endclass
  class dim1;
    rand dim0 d1[];
    constraint cstr {
      d1.size() inside {[2:3]};
    }
    function void post_randomize();
      foreach(d1[i]) begin
        d1[i] = new();
        void'(d1[i].randomize());
      end
    endfunction
  endclass
  class dim2;
    rand dim1 d2[];
    constraint cstr {
      d2.size() inside {[1:2]};
    }
    function void post_randomize();
      foreach(d2[i]) begin
        d2[i] = new();
        void'(d2[i].randomize());
      end
    endfunction
  endclass

  initial begin
    data_pool dp = new();
    dim2 dm = new();
    assert(dp.randomize())
    else $error("data pool randomization failed!");
    assert(dm.randomize())
    else $error("dim object randomization failed!");
    $finish();
  end
endmodule
