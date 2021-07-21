// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ddr4_v2_2_10,Vivado 2020.2" *)
module ddr4_0(sys_rst, c0_sys_clk_p, c0_sys_clk_n, 
  c0_ddr4_ui_clk, c0_ddr4_ui_clk_sync_rst, dbg_clk, c0_ddr4_act_n, c0_ddr4_adr, c0_ddr4_ba, 
  c0_ddr4_bg, c0_ddr4_cke, c0_ddr4_odt, c0_ddr4_cs_n, c0_ddr4_ck_t, c0_ddr4_ck_c, 
  c0_ddr4_reset_n, c0_ddr4_dm_dbi_n, c0_ddr4_dq, c0_ddr4_dqs_c, c0_ddr4_dqs_t, 
  c0_init_calib_complete, dBufAdr, wrData, wrDataMask, rdData, rdDataAddr, rdDataEn, rdDataEnd, 
  per_rd_done, rmw_rd_done, wrDataAddr, wrDataEn, mc_ACT_n, mc_ADR, mc_BA, mc_BG, mc_CKE, mc_CS_n, 
  mc_ODT, mcCasSlot, mcCasSlot2, mcRdCAS, mcWrCAS, winInjTxn, winRmw, gt_data_ready, winBuf, winRank, 
  tCWL, dbg_bus);
  input sys_rst;
  input c0_sys_clk_p;
  input c0_sys_clk_n;
  output c0_ddr4_ui_clk;
  output c0_ddr4_ui_clk_sync_rst;
  output dbg_clk;
  output c0_ddr4_act_n;
  output [16:0]c0_ddr4_adr;
  output [1:0]c0_ddr4_ba;
  output [0:0]c0_ddr4_bg;
  output [0:0]c0_ddr4_cke;
  output [0:0]c0_ddr4_odt;
  output [0:0]c0_ddr4_cs_n;
  output [0:0]c0_ddr4_ck_t;
  output [0:0]c0_ddr4_ck_c;
  output c0_ddr4_reset_n;
  inout [7:0]c0_ddr4_dm_dbi_n;
  inout [63:0]c0_ddr4_dq;
  inout [7:0]c0_ddr4_dqs_c;
  inout [7:0]c0_ddr4_dqs_t;
  output c0_init_calib_complete;
  input [4:0]dBufAdr;
  input [511:0]wrData;
  input [63:0]wrDataMask;
  output [511:0]rdData;
  output [4:0]rdDataAddr;
  output [0:0]rdDataEn;
  output [0:0]rdDataEnd;
  output [0:0]per_rd_done;
  output [0:0]rmw_rd_done;
  output [4:0]wrDataAddr;
  output [0:0]wrDataEn;
  input [7:0]mc_ACT_n;
  input [135:0]mc_ADR;
  input [15:0]mc_BA;
  input [7:0]mc_BG;
  input [7:0]mc_CKE;
  input [7:0]mc_CS_n;
  input [7:0]mc_ODT;
  input [1:0]mcCasSlot;
  input [0:0]mcCasSlot2;
  input [0:0]mcRdCAS;
  input [0:0]mcWrCAS;
  input [0:0]winInjTxn;
  input [0:0]winRmw;
  input gt_data_ready;
  input [4:0]winBuf;
  input [1:0]winRank;
  output [5:0]tCWL;
  output [511:0]dbg_bus;
endmodule
