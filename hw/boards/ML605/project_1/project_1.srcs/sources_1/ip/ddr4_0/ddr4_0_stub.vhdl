-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
-- Date        : Mon Jun 14 19:05:40 2021
-- Host        : WIN-82IMF3CKAHH running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/Administrator/Desktop/xusp3s_test/vivado_prj/SoftMC-master/hw/boards/ML605/project_1/project_1.srcs/sources_1/ip/ddr4_0/ddr4_0_stub.vhdl
-- Design      : ddr4_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcvu095-ffva2104-3-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ddr4_0 is
  Port ( 
    sys_rst : in STD_LOGIC;
    c0_sys_clk_p : in STD_LOGIC;
    c0_sys_clk_n : in STD_LOGIC;
    c0_ddr4_act_n : out STD_LOGIC;
    c0_ddr4_adr : out STD_LOGIC_VECTOR ( 16 downto 0 );
    c0_ddr4_ba : out STD_LOGIC_VECTOR ( 1 downto 0 );
    c0_ddr4_bg : out STD_LOGIC_VECTOR ( 1 downto 0 );
    c0_ddr4_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr4_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr4_cs_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr4_ck_t : out STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr4_ck_c : out STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr4_reset_n : out STD_LOGIC;
    c0_ddr4_dm_dbi_n : inout STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr4_dq : inout STD_LOGIC_VECTOR ( 7 downto 0 );
    c0_ddr4_dqs_c : inout STD_LOGIC_VECTOR ( 0 to 0 );
    c0_ddr4_dqs_t : inout STD_LOGIC_VECTOR ( 0 to 0 );
    c0_init_calib_complete : out STD_LOGIC;
    c0_ddr4_ui_clk : out STD_LOGIC;
    c0_ddr4_ui_clk_sync_rst : out STD_LOGIC;
    dbg_clk : out STD_LOGIC;
    c0_ddr4_app_addr : in STD_LOGIC_VECTOR ( 28 downto 0 );
    c0_ddr4_app_cmd : in STD_LOGIC_VECTOR ( 2 downto 0 );
    c0_ddr4_app_en : in STD_LOGIC;
    c0_ddr4_app_hi_pri : in STD_LOGIC;
    c0_ddr4_app_wdf_data : in STD_LOGIC_VECTOR ( 63 downto 0 );
    c0_ddr4_app_wdf_end : in STD_LOGIC;
    c0_ddr4_app_wdf_mask : in STD_LOGIC_VECTOR ( 7 downto 0 );
    c0_ddr4_app_wdf_wren : in STD_LOGIC;
    c0_ddr4_app_rd_data : out STD_LOGIC_VECTOR ( 63 downto 0 );
    c0_ddr4_app_rd_data_end : out STD_LOGIC;
    c0_ddr4_app_rd_data_valid : out STD_LOGIC;
    c0_ddr4_app_rdy : out STD_LOGIC;
    c0_ddr4_app_wdf_rdy : out STD_LOGIC;
    dbg_bus : out STD_LOGIC_VECTOR ( 511 downto 0 )
  );

end ddr4_0;

architecture stub of ddr4_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "sys_rst,c0_sys_clk_p,c0_sys_clk_n,c0_ddr4_act_n,c0_ddr4_adr[16:0],c0_ddr4_ba[1:0],c0_ddr4_bg[1:0],c0_ddr4_cke[0:0],c0_ddr4_odt[0:0],c0_ddr4_cs_n[0:0],c0_ddr4_ck_t[0:0],c0_ddr4_ck_c[0:0],c0_ddr4_reset_n,c0_ddr4_dm_dbi_n[0:0],c0_ddr4_dq[7:0],c0_ddr4_dqs_c[0:0],c0_ddr4_dqs_t[0:0],c0_init_calib_complete,c0_ddr4_ui_clk,c0_ddr4_ui_clk_sync_rst,dbg_clk,c0_ddr4_app_addr[28:0],c0_ddr4_app_cmd[2:0],c0_ddr4_app_en,c0_ddr4_app_hi_pri,c0_ddr4_app_wdf_data[63:0],c0_ddr4_app_wdf_end,c0_ddr4_app_wdf_mask[7:0],c0_ddr4_app_wdf_wren,c0_ddr4_app_rd_data[63:0],c0_ddr4_app_rd_data_end,c0_ddr4_app_rd_data_valid,c0_ddr4_app_rdy,c0_ddr4_app_wdf_rdy,dbg_bus[511:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ddr4_v2_2_8,Vivado 2019.2";
begin
end;
