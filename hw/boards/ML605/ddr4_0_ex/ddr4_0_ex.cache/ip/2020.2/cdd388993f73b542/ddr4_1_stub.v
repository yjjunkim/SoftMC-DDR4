// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Tue Jun 22 15:51:47 2021
// Host        : DESKTOP-ILOVGO9 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ddr4_1_stub.v
// Design      : ddr4_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xcvu095-ffva2104-1-i
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ddr4_v2_2_10,Vivado 2020.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(sys_rst, c0_sys_clk_p, c0_sys_clk_n, 
  c0_ddr4_ui_clk, c0_ddr4_ui_clk_sync_rst, dbg_clk, c0_ddr4_act_n, c0_ddr4_adr, c0_ddr4_ba, 
  c0_ddr4_bg, c0_ddr4_cke, c0_ddr4_odt, c0_ddr4_cs_n, c0_ddr4_ck_t, c0_ddr4_ck_c, 
  c0_ddr4_reset_n, c0_ddr4_dm_dbi_n, c0_ddr4_dq, c0_ddr4_dqs_c, c0_ddr4_dqs_t, 
  c0_init_calib_complete, dBufAdr, wrData, wrDataMask, rdData, rdDataAddr, rdDataEn, rdDataEnd, 
  per_rd_done, rmw_rd_done, wrDataAddr, wrDataEn, mc_ACT_n, mc_ADR, mc_BA, mc_BG, mc_CKE, mc_CS_n, 
  mc_ODT, mcCasSlot, mcCasSlot2, mcRdCAS, mcWrCAS, winInjTxn, winRmw, gt_data_ready, winBuf, winRank, 
  tCWL, dbg_bus)
/* synthesis syn_black_box black_box_pad_pin="sys_rst,c0_sys_clk_p,c0_sys_clk_n,c0_ddr4_ui_clk,c0_ddr4_ui_clk_sync_rst,dbg_clk,c0_ddr4_act_n,c0_ddr4_adr[16:0],c0_ddr4_ba[1:0],c0_ddr4_bg[0:0],c0_ddr4_cke[0:0],c0_ddr4_odt[0:0],c0_ddr4_cs_n[0:0],c0_ddr4_ck_t[0:0],c0_ddr4_ck_c[0:0],c0_ddr4_reset_n,c0_ddr4_dm_dbi_n[7:0],c0_ddr4_dq[63:0],c0_ddr4_dqs_c[7:0],c0_ddr4_dqs_t[7:0],c0_init_calib_complete,dBufAdr[4:0],wrData[511:0],wrDataMask[63:0],rdData[511:0],rdDataAddr[4:0],rdDataEn[0:0],rdDataEnd[0:0],per_rd_done[0:0],rmw_rd_done[0:0],wrDataAddr[4:0],wrDataEn[0:0],mc_ACT_n[7:0],mc_ADR[135:0],mc_BA[15:0],mc_BG[7:0],mc_CKE[7:0],mc_CS_n[7:0],mc_ODT[7:0],mcCasSlot[1:0],mcCasSlot2[0:0],mcRdCAS[0:0],mcWrCAS[0:0],winInjTxn[0:0],winRmw[0:0],gt_data_ready,winBuf[4:0],winRank[1:0],tCWL[5:0],dbg_bus[511:0]" */;
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
