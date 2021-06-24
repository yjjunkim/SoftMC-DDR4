// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Mon Jun 14 19:05:33 2021
// Host        : WIN-82IMF3CKAHH running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub -rename_top ddr4_0 -prefix
//               ddr4_0_ ddr4_0_stub.v
// Design      : ddr4_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcvu095-ffva2104-3-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ddr4_v2_2_8,Vivado 2019.2" *)
module ddr4_0(sys_rst, c0_sys_clk_p, c0_sys_clk_n, 
  c0_ddr4_act_n, c0_ddr4_adr, c0_ddr4_ba, c0_ddr4_bg, c0_ddr4_cke, c0_ddr4_odt, c0_ddr4_cs_n, 
  c0_ddr4_ck_t, c0_ddr4_ck_c, c0_ddr4_reset_n, c0_ddr4_dm_dbi_n, c0_ddr4_dq, c0_ddr4_dqs_c, 
  c0_ddr4_dqs_t, c0_init_calib_complete, c0_ddr4_ui_clk, c0_ddr4_ui_clk_sync_rst, dbg_clk, 
  c0_ddr4_app_addr, c0_ddr4_app_cmd, c0_ddr4_app_en, c0_ddr4_app_hi_pri, 
  c0_ddr4_app_wdf_data, c0_ddr4_app_wdf_end, c0_ddr4_app_wdf_mask, c0_ddr4_app_wdf_wren, 
  c0_ddr4_app_rd_data, c0_ddr4_app_rd_data_end, c0_ddr4_app_rd_data_valid, 
  c0_ddr4_app_rdy, c0_ddr4_app_wdf_rdy, dbg_bus)
/* synthesis syn_black_box black_box_pad_pin="sys_rst,c0_sys_clk_p,c0_sys_clk_n,c0_ddr4_act_n,c0_ddr4_adr[16:0],c0_ddr4_ba[1:0],c0_ddr4_bg[1:0],c0_ddr4_cke[0:0],c0_ddr4_odt[0:0],c0_ddr4_cs_n[0:0],c0_ddr4_ck_t[0:0],c0_ddr4_ck_c[0:0],c0_ddr4_reset_n,c0_ddr4_dm_dbi_n[0:0],c0_ddr4_dq[7:0],c0_ddr4_dqs_c[0:0],c0_ddr4_dqs_t[0:0],c0_init_calib_complete,c0_ddr4_ui_clk,c0_ddr4_ui_clk_sync_rst,dbg_clk,c0_ddr4_app_addr[28:0],c0_ddr4_app_cmd[2:0],c0_ddr4_app_en,c0_ddr4_app_hi_pri,c0_ddr4_app_wdf_data[63:0],c0_ddr4_app_wdf_end,c0_ddr4_app_wdf_mask[7:0],c0_ddr4_app_wdf_wren,c0_ddr4_app_rd_data[63:0],c0_ddr4_app_rd_data_end,c0_ddr4_app_rd_data_valid,c0_ddr4_app_rdy,c0_ddr4_app_wdf_rdy,dbg_bus[511:0]" */;
  input sys_rst;
  input c0_sys_clk_p;
  input c0_sys_clk_n;
  output c0_ddr4_act_n;
  output [16:0]c0_ddr4_adr;
  output [1:0]c0_ddr4_ba;
  output [1:0]c0_ddr4_bg;
  output [0:0]c0_ddr4_cke;
  output [0:0]c0_ddr4_odt;
  output [0:0]c0_ddr4_cs_n;
  output [0:0]c0_ddr4_ck_t;
  output [0:0]c0_ddr4_ck_c;
  output c0_ddr4_reset_n;
  inout [0:0]c0_ddr4_dm_dbi_n;
  inout [7:0]c0_ddr4_dq;
  inout [0:0]c0_ddr4_dqs_c;
  inout [0:0]c0_ddr4_dqs_t;
  output c0_init_calib_complete;
  output c0_ddr4_ui_clk;
  output c0_ddr4_ui_clk_sync_rst;
  output dbg_clk;
  input [28:0]c0_ddr4_app_addr;
  input [2:0]c0_ddr4_app_cmd;
  input c0_ddr4_app_en;
  input c0_ddr4_app_hi_pri;
  input [63:0]c0_ddr4_app_wdf_data;
  input c0_ddr4_app_wdf_end;
  input [7:0]c0_ddr4_app_wdf_mask;
  input c0_ddr4_app_wdf_wren;
  output [63:0]c0_ddr4_app_rd_data;
  output c0_ddr4_app_rd_data_end;
  output c0_ddr4_app_rd_data_valid;
  output c0_ddr4_app_rdy;
  output c0_ddr4_app_wdf_rdy;
  output [511:0]dbg_bus;
endmodule
