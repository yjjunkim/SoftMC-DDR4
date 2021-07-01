// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_5,Vivado 2020.2" *)
module rdback_fifo(clk, srst, din, wr_en, rd_en, dout, full, almost_full, 
  empty, wr_rst_busy, rd_rst_busy);
  input clk;
  input srst;
  input [511:0]din;
  input wr_en;
  input rd_en;
  output [511:0]dout;
  output full;
  output almost_full;
  output empty;
  output wr_rst_busy;
  output rd_rst_busy;
endmodule
