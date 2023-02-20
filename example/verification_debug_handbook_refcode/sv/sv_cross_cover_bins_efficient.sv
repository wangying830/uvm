module tb;
  logic [1:0] d1, d2;
  covergroup rkv_cg;
    option.per_instance = 1;
    CP_D1: coverpoint d1 {
      option.weight = 0;
      bins v00 = {'b00};
      bins v01 = {'b01};
    }
    CP_D2: coverpoint d2 {
      option.weight = 0;
      bins v10 = {'b10};
      bins v11 = {'b11};
    }

    CRS_D1xD2_weight0: cross CP_D1, CP_D2 {
      bins d1_v00 = binsof(CP_D1.v00);
      bins d1_v01 = binsof(CP_D1.v01);
      bins d2_v10 = binsof(CP_D2.v10);
      bins d2_v11 = binsof(CP_D2.v11);
      bins v00xv10 = binsof(CP_D1.v00) && binsof(CP_D2.v10) ;
      bins v01xv11 = binsof(CP_D1.v01) && binsof(CP_D2.v11) ;
    }

    CRS_D1xD2_automax0: cross CP_D1, CP_D2 {
      option.cross_auto_bin_max = 0;
      bins v00xv10 = binsof(CP_D1.v00) && binsof(CP_D2.v10) ;
      bins v01xv11 = binsof(CP_D1.v01) && binsof(CP_D2.v11) ;
    }

    CRS_d1xd2_automax0: cross d1, d2 {
      option.cross_auto_bin_max = 0;
      bins v00xv10 = (binsof(d1) intersect {'b00}) && (binsof(d2) intersect {'b10});
      bins v01xv11 = (binsof(d1) intersect {'b01}) && (binsof(d2) intersect {'b11});
    }
  endgroup
  initial begin
    rkv_cg cg = new();
    d1 = 'b01;
    d2 = 'b11;
    cg.sample();
    $finish();
  end
endmodule
