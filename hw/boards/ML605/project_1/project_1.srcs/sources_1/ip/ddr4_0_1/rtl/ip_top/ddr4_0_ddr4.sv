
/******************************************************************************
// (c) Copyright 2013 - 2014 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
******************************************************************************/
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor             : Xilinx
// \   \   \/     Version            : 1.0
//  \   \         Application        : DDR4
//  /   /         Filename           : ddr4_0_ddr4.sv
// /___/   /\     Date Last Modified : $Date: 2014/09/03 $
// \   \  /  \    Date Created       : Thu Apr 18 2013
//  \___\/\___\
//
// Device           : UltraScale
// Design Name      : DDR4_SDRAM
// Purpose          :
//   Top-level  module. This module can be instantiated in the
//   system and interconnect as shown in user design wrapper file 
//   (user top module).
// Reference        :
// Revision History :
//*****************************************************************************



`timescale 1ps/1ps
`ifdef MODEL_TECH
    `ifndef CALIB_SIM
       `define SIMULATION
     `endif
`elsif INCA
    `ifndef CALIB_SIM
       `define SIMULATION
     `endif
`elsif VCS
    `ifndef CALIB_SIM
       `define SIMULATION
     `endif
`elsif XILINX_SIMULATOR
    `ifndef CALIB_SIM
       `define SIMULATION
     `endif
`elsif _VCP
    `ifndef CALIB_SIM
       `define SIMULATION
     `endif
`endif

(*

  X_MIG_OLYMPUS = 1,  
  X_ULTRASCALE_IO_FLOW = "xilinx.com:ip:ddr4_phy:2.2",
  LIVE_DESIGN = 0,
  MEM_CORE_VER = "xilinx.com:ip:mem:1.4",
  PhyIP_CUSTOM_PART_ATTRIBUTES = "NONE",
  ControllerType = "ddr4_sdram",
  PhyIP_TimePeriod = 833,
  PhyIP_InputClockPeriod = 13328,
  PhyIP_MemoryType = "Components",
  PhyIP_MemoryPart = "MT40A512M8RH-075E",
  PhyIP_PhyClockRatio = "4:1",
  PhyIP_ECC = "false",
  PhyIP_CasLatency = 17,
  PhyIP_CasWriteLatency = 12,
  PhyIP_DataWidth = 8,
  PhyIP_ChipSelect = "true",
  PhyIP_Slot = "Single",
  PhyIP_isCKEShared = "false",
  PhyIP_DataMask = "DM_NO_DBI",
  PhyIP_MemoryVoltage = "1.2V",
  PhyIP_PARTIAL_RECONFIG_FLOW_MIG = "false",
  
  PhyIP_SELF_REFRESH = "false",
  PhyIP_SAVE_RESTORE = "false",
  PhyIP_Enable_LVAUX = "false", 
  PhyIP_CLKFBOUT_MULT = "20",
  PhyIP_DIVCLK_DIVIDE = "1",
  PhyIP_CLKOUT0_DIVIDE = "5",
  PhyIP_CLKOUT1_DIVIDE = "0",
  PhyIP_CLKOUT2_DIVIDE = "0",
  PhyIP_CLKOUT3_DIVIDE = "0",
  PhyIP_CLKOUT4_DIVIDE = "0",
  PhyIP_VrefVoltage = "0.84",
  PhyIP_StackHeight = "1",
  PhyIP_IS_FROM_PHY = "1",
  PhyIP_CA_MIRROR = "0",

  PhyIP_System_Clock = "Differential",
  PhyIP_Simulation_Mode = "BFM",
  PhyIP_Phy_Only = "Complete_Memory_Controller",
  PhyIP_DEBUG_SIGNAL = "Disable",
  PhyIP_CLKOUTPHY_MODE = "VCO_2X",
  PhyIP_DQ_WIDTH = 8,
  PhyIP_MEM_DEVICE_WIDTH = 8,
  PhyIP_MIN_PERIOD = 750,
  PhyIP_USE_DM_PORT = "DM_NO_DBI",
  PhyIP_USE_CS_PORT = "true",
  PhyIP_ADDR_WIDTH = 17,
  PhyIP_BANK_WIDTH = 2,
  PhyIP_BANK_GROUP_WIDTH = 2,
  PhyIP_CKE_WIDTH = 1,
  PhyIP_CK_WIDTH = 1,
  PhyIP_CS_WIDTH = 1,
  PhyIP_CLAMSHELL = "false",
  PhyIP_RANK_WIDTH = 1,
  PhyIP_tCK = 833,
  PhyIP_HR_MIN_FREQ = 0,
  PhyIP_DCI_CASCADE_CUTOFF = 938,
  PhyIP_IS_FASTER_SPEED_RAM = "No",
  PhyIP_ODT_WIDTH = 1,
  PhyIP_nCS_PER_RANK = 1,
  PhyIP_DATABITS_PER_STROBE = 8,
  PhyIP_DQS_WIDTH = 1,
  PhyIP_DM_WIDTH = 1

*)
module ddr4_0_ddr4 #
 (
    parameter integer ADDR_WIDTH              = 17,
    parameter integer ROW_WIDTH               = 15,
    parameter integer BANK_WIDTH              = 2,
    parameter integer BANK_GROUP_WIDTH        = 2,
    parameter integer S_HEIGHT                = 1,
    parameter integer LR_WIDTH                = 1,
    parameter integer CKE_WIDTH               = 1,
    parameter integer CK_WIDTH                = 1,
    parameter integer COL_WIDTH               = 10,
    parameter integer CS_WIDTH                = 1,
    parameter integer ODT_WIDTH               = 1,
    parameter integer DQ_WIDTH                = 8,
    parameter integer DQS_WIDTH               = 1,
    parameter integer DM_WIDTH                = 1,

    parameter         DRAM_TYPE               = "DDR4",
    parameter         MEM_ADDR_ORDER          = "ROW_COLUMN_BANK",

    parameter DM_DBI                          = "DM_NODBI",

    parameter         PARTIAL_RECONFIG        = "Disable", // Partial Reconfig enablement
    parameter         USE_CS_PORT             = 1,
    parameter         NUMREF                  = 1,
    parameter         REG_CTRL                = "OFF",
    parameter         LRDIMM_MODE             = "OFF", // LRDIMM Mode
    parameter         MCS_ECC_ENABLE       = "FALSE",
    parameter         tCK                     = 833,  // Memory clock period (DDR4 clock cycle)

    parameter         tFAW                    = 26,//In DDR4 clock cycles
    parameter         tRTW                    = 11, // CL + (BL/2) - CWL + 2tCK In DDR4 clock cycles
    parameter         tWTR_L                  = 10, //In DDR4 clock cycles
    parameter         tWTR_S                  = 4, //In DDR4 clock cycles
    parameter         tRFC                    = 313, //In DDR4 clock cycles
    parameter         tREFI                   = 9363, //In DDR4 clock cycles
    parameter         ZQINTVL                 = 1200480193, //In DDR4 clock cycles
    parameter         tZQCS                   = 128, //In DDR4 clock cycles
    parameter         tRP                     = 17, //In DDR4 clock cycles
    parameter         tRRD_L                  = 6, //In DDR4 clock cycles
    parameter         tRRD_S                  = 4, //In DDR4 clock cycles
    parameter         tRAS                    = 39, //In DDR4 clock cycles
    parameter         tRCD                    = 17, //In DDR4 clock cycles
    parameter         tRTP                    = 10, //In DDR4 clock cycles

    parameter         tWR                     = 20, //In DDR4 clock cycles
    parameter         PER_RD_INTVL            = 32'd301,
    parameter         ODTWRDEL                = 5'd12,
    parameter         ODTWRDUR                = 4'd6,
    parameter         ODTWRODEL               = 5'd9,
    parameter         ODTWRODUR               = 4'd6,
    parameter         ODTRDDEL                = 5'd17,
    parameter         ODTRDDUR                = 4'd6,
    parameter         ODTRDODEL               = 5'd9,
    parameter         ODTRDODUR               = 4'd6,
    parameter         ODTNOP                  = 16'h0000,

    parameter real    TCQ                     = 100,
    parameter         DRAM_WIDTH              = 8,
    parameter         RANKS                   = 1,
    parameter         ORDERING                = "NORM",
    parameter         RTL_VERSION             = 0,
    parameter         TXN_FIFO_BYPASS         = "ON",
    parameter         TXN_FIFO_PIPE           = "OFF",
    parameter         PER_RD_PERF             = 1'b1,
    parameter         CAS_FIFO_BYPASS         = "ON",
    parameter         ALIAS_PAGE              = "OFF",
    parameter         ALIAS_P_CNT             = "OFF",
    parameter         NOP_ADD_LOW             = 1'b0,
    parameter         STARVATION_EN           = 1'b1,
    parameter         STARVE_COUNT_WIDTH      = 9,
    parameter         EXTRA_CMD_DELAY         = 0,
    parameter         nCK_PER_CLK             = 4,
    parameter         APP_ADDR_WIDTH          = 29,
    parameter         APP_DATA_WIDTH          = 64,
    parameter         APP_MASK_WIDTH          = 8,

    parameter         CLKIN_PERIOD_MMCM        = 13328,
    parameter         CLKFBOUT_MULT_MMCM       = 20,
    parameter         DIVCLK_DIVIDE_MMCM       = 1,
    parameter         CLKOUT0_DIVIDE_MMCM      = 5,
    parameter         CLKOUT1_DIVIDE_MMCM      = 5,
    parameter         CLKOUT2_DIVIDE_MMCM      = 5,
    parameter         CLKOUT3_DIVIDE_MMCM      = 5,
    parameter         CLKOUT4_DIVIDE_MMCM      = 5,
    parameter         CLKOUT6_DIVIDE_MMCM      = 10,
    parameter         CLKOUTPHY_MODE           = "VCO_2X",
    parameter         C_FAMILY                 = "virtexu",

// following local parameters are defined for coverage purpose and is for internal use
    parameter C_S_AXI_ID_WIDTH = 0, // for internal use only
    parameter C_S_AXI_ADDR_WIDTH = 0, // for internal use only
    parameter C_S_AXI_DATA_WIDTH = 0, // for internal use only
    parameter C_S_AXI_SUPPORTS_NARROW_BURST   = 0, // for internal use only
    parameter C_RD_WR_ARB_ALGORITHM           = "RD_PRI_REG", // for internal use only
    parameter BURST_MODE                      = "8",     // Burst length // for internal use only
    parameter ECC                               = "OFF",
    parameter ECC_TEST                          = "OFF",
    parameter PAYLOAD_WIDTH                     = (ECC == "OFF") ? DQ_WIDTH : APP_DATA_WIDTH/8,
    parameter AUTO_AP_COL_A3                    = "OFF",
    parameter MIG_PARAM_CHECKS                  ="FALSE",
    parameter INTERFACE                         ="NATIVE",
    parameter ADV_USER_REQ                      ="NONE",
    parameter FPGA			                        = "xcvu095-ffva2104-3-e-",
    parameter DEVICE			                      = "xcvu095-",
    parameter FAMILY                            = "ULTRASCALE",
    parameter DEBUG_SIGNAL		                  = "Disable",
    parameter AL                                = "0",
    parameter SELF_REFRESH                      = "false",
    parameter SAVE_RESTORE                      = "false",
    parameter RESTORE_CRC                       = "false",
    parameter IS_CKE_SHARED                     = "false",
    parameter MEMORY_PART                       = "MT40A512M8RH-075E",
    parameter integer COMPONENT_WIDTH           = 8,
    parameter NUM_SLOT                          = 1,
    parameter RANK_SLOT                         = 1,
    parameter         PING_PONG_PHY             = 1, 
    parameter MEMORY_DENSITY                    = "4Gb",
    parameter MEMORY_SPEED_GRADE                = "075E",
    parameter MEMORY_WIDTH                      = "8",
    parameter MEMORY_CONFIGURATION              = "COMPONENT",
    parameter         SYSCLK_TYPE             = "DIFFERENTIAL",
                                // input clock type
    parameter CALIB_HIGH_SPEED                  = "FALSE",
    parameter         CA_MIRROR                 = "OFF",

    // Clamshell architecture of DRAM parts on PCB
    parameter         DDR4_CLAMSHELL       = "OFF",

    parameter DDR4_REG_PARITY_ENABLE            = "OFF",
    parameter integer DBYTES                    = 1,
    parameter         MR0                       = 13'b0101101100100,
    parameter         DDR4_DB_HIF_RTT_NOM     = 4'b0011, 
    parameter         DDR4_DB_HIF_RTT_WR      = 4'b0000, 
    parameter         DDR4_DB_HIF_RTT_PARK    = 4'b0000, 
    parameter         DDR4_DB_HIF_DI          = 4'b0001, 
    parameter         DDR4_DB_DIF_ODT         = 4'b0011, 
    parameter         DDR4_DB_DIF_DI          = 4'b0000, 
    parameter         DDR4_DB_HIF_VREF        = 8'b0001_1011,
    parameter         DDR4_DB_DIF_VREF        = 8'b0001_1011,

    parameter         ODTWR                     = 16'h0021,
    parameter         ODTRD                     = 16'h0000,
    parameter         MR1                       = 13'b0001100000001,
    parameter         MR5                       = 13'b0010000000000,
    parameter         MR6                       = 13'b0100000010100,



    parameter         MR2                       = 13'b0000000011000,
    parameter         MR3                       = 13'b0001000000000,
    parameter         MR4                       = 13'b0000000000000,

    parameter         RD_VREF_VAL               = 7'h1F,
    parameter         SLOT0_CONFIG              = {{(8-CS_WIDTH){1'b0}},{CS_WIDTH{1'b1}}},
    parameter         SLOT1_CONFIG              = 8'b0000_0000,
    parameter         SLOT0_FUNC_CS             = {{(8-CS_WIDTH){1'b0}},{CS_WIDTH{1'b1}}},
    parameter         SLOT1_FUNC_CS             = 8'b0000_0000,
    parameter         SLOT0_ODD_CS              = 8'b0000_0000,
    parameter         SLOT1_ODD_CS              = 8'b0000_0000,

    parameter         DDR4_REG_RC03             = {9'b0_0000_0011, 4'b0000},

    parameter         DDR4_REG_RC04             = {9'b0_0000_0100, 4'b0000},

    parameter         DDR4_REG_RC05             = {9'b0_0000_0101, 4'b0000},
    parameter         tXPR                      = 82, // In fabric clock cycles
    parameter         tMOD                      = 6, // In fabric clock cycles
    parameter         tMRD                      = 2, // In fabric clock cycles
    parameter         tZQINIT                   = 256, // In fabric clock cycles
    parameter         MEM_CODE                  = 0,
    parameter         C_DEBUG_ENABLED           = 0,
    parameter         CPLX_PAT_LENGTH           = "LONG",
    parameter         EARLY_WR_DATA             = "OFF",

    // Migration parameters
    parameter                    MIGRATION = "OFF",

    parameter [8*CK_WIDTH-1:0]   CK_SKEW   = 8'd0,
    parameter [8*ADDR_WIDTH-1:0] ADDR_SKEW = {8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0,8'd0},
    parameter [8*BANK_WIDTH-1:0] BA_SKEW   = {8'd0,8'd0},
    parameter [8*BANK_GROUP_WIDTH-1:0] BG_SKEW   = {8'd0,8'd0},
    parameter [8*1-1:0]          ACT_SKEW  = 8'd0,
    parameter [8*1-1:0]          PAR_SKEW  = 8'd0,
    parameter [8*CS_WIDTH-1:0]   CS_SKEW   = 8'd0,
    parameter [8*CKE_WIDTH-1:0]  CKE_SKEW  = 8'd0,
    parameter [8*ODT_WIDTH-1:0]  ODT_SKEW  = 8'd0,
    parameter [8*LR_WIDTH-1:0]   C_SKEW    = 8'd0,

  `ifdef SIMULATION
    parameter         SIM_MODE                  = "BFM",
    parameter         BISC_EN                   = 0,
    parameter         BYPASS_CAL                = "TRUE",
    parameter         CAL_DQS_GATE              = "SKIP",
    parameter         CAL_WRLVL                 = "SKIP",
    parameter         CAL_RDLVL                 = "SKIP",
    parameter         CAL_RDLVL_DBI             = "SKIP",
    parameter         CAL_WR_DQS_DQ             = "SKIP",
    parameter         CAL_WR_DQS_DM_DBI         = "SKIP",
    parameter         CAL_WRITE_LAT             = "FAST",
    parameter         CAL_RDLVL_COMPLEX         = "SKIP",
    parameter         CAL_WR_DQS_COMPLEX        = "SKIP",
    parameter         CAL_RD_VREF               = "SKIP",
    parameter         CAL_RD_VREF_PATTERN       = "SIMPLE",
    parameter         CAL_WR_VREF               = "SKIP",
    parameter         CAL_WR_VREF_PATTERN       = "SIMPLE",
    parameter         CAL_DQS_TRACKING          = "SKIP",
    parameter         CAL_JITTER                = "NONE",
    parameter         t200us                    = 100, // In fabric clock cycles
    parameter         t500us                    = 150 // In fabric clock cycles
  `else
    parameter         SIM_MODE                  = "FULL",
    parameter         BISC_EN                   = 1,
    parameter         BYPASS_CAL                = "FALSE",
    parameter         CAL_DQS_GATE              = "FULL",
    parameter         CAL_WRLVL                 = "FULL",
    parameter         CAL_RDLVL                 = "FULL",
    parameter         CAL_RDLVL_DBI             = "SKIP",
    parameter         CAL_WR_DQS_DQ             = "FULL",
    parameter         CAL_WR_DQS_DM_DBI         = "FULL",
    parameter         CAL_WRITE_LAT             = "FULL",
    parameter         CAL_RDLVL_COMPLEX         = "FULL",
    parameter         CAL_WR_DQS_COMPLEX        = "FULL",
    parameter         CAL_RD_VREF               = "SKIP",
    parameter         CAL_RD_VREF_PATTERN       = "SIMPLE",
    parameter         CAL_WR_VREF               = "SKIP",
    parameter         CAL_WR_VREF_PATTERN       = "SIMPLE",
    parameter         CAL_DQS_TRACKING          = "FULL",
    parameter         CAL_JITTER                = "FULL",
    parameter         t200us                    = 60025, // In fabric clock cycles
    parameter         t500us                    = 150061 // In fabric clock cycles
  `endif
    ) 
   (
   input  sys_rst,

   // iob<>DDR4 signals

   input                           c0_sys_clk_p,
   input                           c0_sys_clk_n,

   output                          c0_ddr4_act_n,
   output [ADDR_WIDTH-1:0]         c0_ddr4_adr,
   output [BANK_WIDTH-1:0]         c0_ddr4_ba,
   output [BANK_GROUP_WIDTH-1:0]   c0_ddr4_bg,
   output [CKE_WIDTH-1:0]          c0_ddr4_cke,
   output [ODT_WIDTH-1:0]          c0_ddr4_odt,
   output [CS_WIDTH-1:0]           c0_ddr4_cs_n,
   output [CK_WIDTH-1:0]           c0_ddr4_ck_t,
   output [CK_WIDTH-1:0]           c0_ddr4_ck_c,
   output                          c0_ddr4_reset_n,
   inout  [DM_WIDTH-1:0]           c0_ddr4_dm_dbi_n,
   inout  [DQ_WIDTH-1:0]           c0_ddr4_dq,
   inout  [DQS_WIDTH-1:0]          c0_ddr4_dqs_c,
   inout  [DQS_WIDTH-1:0]          c0_ddr4_dqs_t,

   output                          c0_init_calib_complete,

   output                             addn_ui_clkout1,
   output                             addn_ui_clkout2,
   output                             addn_ui_clkout3,
   output                             addn_ui_clkout4,
   output                             dbg_clk,
   (* KEEP = "true" *) input [36:0]   sl_iport0,
   (* KEEP = "true" *) output [16:0]  sl_oport0,
   input                               c0_ddr4_app_correct_en_i,
   output                              c0_ddr4_ui_clk,
   output                              c0_ddr4_ui_clk_sync_rst,
   // user interface ports
   input  [APP_ADDR_WIDTH-1:0]         c0_ddr4_app_addr,
   input  [2:0]                        c0_ddr4_app_cmd,
   input                               c0_ddr4_app_en,
   input                               c0_ddr4_app_hi_pri,
   input  [APP_DATA_WIDTH-1:0]         c0_ddr4_app_wdf_data,
   input                               c0_ddr4_app_wdf_end,
   input  [APP_MASK_WIDTH-1:0]         c0_ddr4_app_wdf_mask,
   input                               c0_ddr4_app_wdf_wren,

   output [APP_DATA_WIDTH-1:0]         c0_ddr4_app_rd_data,
   output                              c0_ddr4_app_rd_data_end,
   output                              c0_ddr4_app_rd_data_valid,
   output                              c0_ddr4_app_rdy,
   output                              c0_ddr4_app_wdf_rdy,
   // Debug Port
   output wire [511:0]             dbg_bus
   );

  function integer clogb2 (input integer size);
    begin
      size = size - 1;
      for (clogb2=1; size>1; clogb2=clogb2+1)
        size = size >> 1;
    end
  endfunction // clogb2

  localparam RANK_WIDTH = clogb2(RANKS);
  localparam ECC_WIDTH = 8;
  localparam DATA_BUF_OFFSET_WIDTH = 1;
  // Fixed error log definition for all DRAM configs
  // Field:  reserved 3DS_C reserved RMW  Row     Column  reserved  Rank   Group   Bank
  // Bit:       51    50:48   47:45  44  43:24     23:8      7:6     5:4    3:2    1:0
  localparam MC_ERR_ADDR_WIDTH = 52;

  wire c0_rst;
  wire c0_div_clk;
  wire c0_div_clk_rst;
  (* keep = "TRUE" *) reg div_clk_rst_r1;
  wire c0_riu_clk;
  wire c0_riu_clk_rst;
  wire c0_mmcm_clk_in;
  wire sys_clk_in;
  wire mmcm_lock;
  wire pll_lock;
  wire reset_ub;
  wire pllGate;

  wire                                   c0_ddr4_correct_en;
  wire [2*nCK_PER_CLK-1:0]               c0_ddr4_raw_not_ecc;
  wire [2*nCK_PER_CLK-1:0]               c0_ddr4_ecc_single_int;
  wire [2*nCK_PER_CLK-1:0]               c0_ddr4_ecc_multiple_int;
  wire [MC_ERR_ADDR_WIDTH-1:0]           c0_ddr4_ecc_err_addr_int;
  wire                                   c0_ddr4_app_correct_en;
  wire [2*nCK_PER_CLK-1:0]               c0_ddr4_app_ecc_multiple_err;

  reg                                    c0_ddr4_init_calib_complete_r;
  wire [DQ_WIDTH*8-1:0]                  c0_ddr4_rd_data_phy2mc;

  wire [2*nCK_PER_CLK-1:0]               c0_ddr4_app_raw_not_ecc;
  wire [DQ_WIDTH/8-1:0]                  c0_ddr4_fi_xor_we;
  wire [DQ_WIDTH-1:0]                    c0_ddr4_fi_xor_wrdata;


  //***************************************************************************
  // Added a single register stage for the calib_done to fix timing
  //***************************************************************************

  always @(posedge c0_div_clk)
    c0_ddr4_init_calib_complete_r <= c0_init_calib_complete;


  always @(posedge c0_div_clk)
    div_clk_rst_r1 <= c0_div_clk_rst;

  assign c0_ddr4_ui_clk = c0_div_clk;
  assign c0_ddr4_ui_clk_sync_rst = div_clk_rst_r1;


  ddr4_v2_2_8_infrastructure #
    (
     .CLKIN_PERIOD_MMCM   (CLKIN_PERIOD_MMCM),
     .CLKFBOUT_MULT_MMCM  (CLKFBOUT_MULT_MMCM),
     .DIVCLK_DIVIDE_MMCM  (DIVCLK_DIVIDE_MMCM),
     .CLKOUT0_DIVIDE_MMCM (CLKOUT0_DIVIDE_MMCM),
     .CLKOUT1_DIVIDE_MMCM (CLKOUT1_DIVIDE_MMCM),
     .CLKOUT2_DIVIDE_MMCM (CLKOUT2_DIVIDE_MMCM),
     .CLKOUT3_DIVIDE_MMCM (CLKOUT3_DIVIDE_MMCM),
     .CLKOUT4_DIVIDE_MMCM (CLKOUT4_DIVIDE_MMCM),
     .CLKOUT6_DIVIDE_MMCM (CLKOUT6_DIVIDE_MMCM),
     .C_FAMILY            (C_FAMILY),
     .TCQ                 (TCQ)
     )
  u_ddr4_infrastructure
    (
     .sys_rst          (sys_rst),
     .sys_clk_in       (sys_clk_in),
     .mmcm_clk_in      (c0_mmcm_clk_in),
     .pll_lock         (pll_lock),

     .mmcm_lock        (mmcm_lock),
     .div_clk          (c0_div_clk),
     .riu_clk          (c0_riu_clk),
     .addn_ui_clkout1  (addn_ui_clkout1),
     .addn_ui_clkout2  (addn_ui_clkout2),
     .addn_ui_clkout3  (addn_ui_clkout3),
     .addn_ui_clkout4  (addn_ui_clkout4),
     .dbg_clk          (dbg_clk),
     .rstdiv0          (c0_div_clk_rst),
     .rstdiv1          (c0_riu_clk_rst),
     .reset_ub         (reset_ub),
     .pllgate          (pllGate)
     );

ddr4_0_ddr4_mem_intfc #
  (
     .ADDR_WIDTH            (ADDR_WIDTH),
     .ROW_WIDTH             (ROW_WIDTH),
     .BANK_WIDTH            (BANK_WIDTH),
     .BANK_GROUP_WIDTH      (BANK_GROUP_WIDTH),
     .S_HEIGHT              (S_HEIGHT),
     .CKE_WIDTH             (CKE_WIDTH),
     .CK_WIDTH              (CK_WIDTH),
     .COL_WIDTH             (COL_WIDTH),
     .CS_WIDTH              (CS_WIDTH),
     .ODT_WIDTH             (ODT_WIDTH),
     .DRAM_TYPE             (DRAM_TYPE),
     .DQ_WIDTH              (DQ_WIDTH),
     .DBYTES                (DBYTES),
     .DEVICE                (DEVICE),
     .SAVE_RESTORE          (1'b0),
     .SELF_REFRESH          (1'b0),
     .RESTORE_CRC           (1'b0),
     .NUM_SLOT              (NUM_SLOT),
     .RANK_SLOT             (RANK_SLOT),
     .DQS_WIDTH             (DQS_WIDTH),
     .DM_WIDTH              (DM_WIDTH),
     .MEM_ADDR_ORDER        (MEM_ADDR_ORDER),
     .DM_DBI                (DM_DBI),
     .USE_CS_PORT           (USE_CS_PORT),
     .ADDR_FIFO_WIDTH       (MC_ERR_ADDR_WIDTH),
     .ECC                   (ECC),
     .ECC_WIDTH             (ECC_WIDTH),
     .PAYLOAD_WIDTH         (PAYLOAD_WIDTH),
     .AUTO_AP_COL_A3        (AUTO_AP_COL_A3),

     .SLOT0_CONFIG          (SLOT0_CONFIG),
     .SLOT1_CONFIG          (SLOT1_CONFIG),
     .SLOT0_FUNC_CS         (SLOT0_FUNC_CS),
     .SLOT1_FUNC_CS         (SLOT1_FUNC_CS),

     .PARTIAL_RECONFIG      (PARTIAL_RECONFIG),
     .REG_CTRL              (REG_CTRL),
     .LRDIMM_MODE           (LRDIMM_MODE),
     .DDR4_DB_HIF_RTT_NOM   (DDR4_DB_HIF_RTT_NOM),
     .DDR4_DB_HIF_RTT_WR    (DDR4_DB_HIF_RTT_WR),
     .DDR4_DB_HIF_RTT_PARK  (DDR4_DB_HIF_RTT_PARK),
     .DDR4_DB_HIF_DI        (DDR4_DB_HIF_DI),
     .DDR4_DB_DIF_ODT       (DDR4_DB_DIF_ODT),
     .DDR4_DB_DIF_DI        (DDR4_DB_DIF_DI),
     .DDR4_DB_HIF_VREF      (DDR4_DB_HIF_VREF),
     .DDR4_DB_DIF_VREF      (DDR4_DB_DIF_VREF),
     .DDR4_REG_RC03         (DDR4_REG_RC03),
     .DDR4_REG_RC04         (DDR4_REG_RC04),
     .DDR4_REG_RC05         (DDR4_REG_RC05),
     .MCS_ECC_ENABLE        (MCS_ECC_ENABLE),
     .tCK                   (tCK),
     .tFAW                  (tFAW),
     .tRTW                  (tRTW),
     .tWTR_L                (tWTR_L),
     .tWTR_S                (tWTR_S),
     .tRFC                  (tRFC),
     .tREFI                 (tREFI),
     .ZQINTVL               (ZQINTVL),
     .tZQCS                 (tZQCS),
     .tRP                   (tRP),
     .tRRD_L                (tRRD_L),
     .tRRD_S                (tRRD_S),
     .tRAS                  (tRAS),
     .tRCD                  (tRCD),
     .tRTP                  (tRTP),
     .tWR                   (tWR),
     .NUMREF                (NUMREF),
     .PER_RD_INTVL          (PER_RD_INTVL),
     .ODTWR                 (ODTWR),
     .ODTWRDEL              (ODTWRDEL),
     .ODTWRDUR              (ODTWRDUR),
     .ODTWRODEL             (ODTWRODEL),
     .ODTWRODUR             (ODTWRODUR),
     .ODTRD                 (ODTRD),
     .ODTRDDEL              (ODTRDDEL),
     .ODTRDDUR              (ODTRDDUR),
     .ODTRDODEL             (ODTRDODEL),
     .ODTRDODUR             (ODTRDODUR),
     .ODTNOP                (ODTNOP),
     .DRAM_WIDTH            (DRAM_WIDTH),
     .RANKS                 (RANKS),
     .RANK_WIDTH            (RANK_WIDTH),
     .ORDERING              (ORDERING),
     .RTL_VERSION           (RTL_VERSION),
     .TXN_FIFO_BYPASS       (TXN_FIFO_BYPASS),
     .TXN_FIFO_PIPE         (TXN_FIFO_PIPE),
     .PER_RD_PERF           (PER_RD_PERF),
     .CAS_FIFO_BYPASS       (CAS_FIFO_BYPASS),
     .ALIAS_PAGE            (ALIAS_PAGE),
     .ALIAS_P_CNT           (ALIAS_P_CNT),
     .NOP_ADD_LOW           (NOP_ADD_LOW),
     .STARVATION_EN         (STARVATION_EN),
     .STARVE_COUNT_WIDTH    (STARVE_COUNT_WIDTH),
     .EXTRA_CMD_DELAY       (EXTRA_CMD_DELAY),
     .nCK_PER_CLK           (nCK_PER_CLK),
     .APP_DATA_WIDTH        (APP_DATA_WIDTH),
     .APP_MASK_WIDTH        (APP_MASK_WIDTH),
     .APP_ADDR_WIDTH        (APP_ADDR_WIDTH),

     .MIG_PARAM_CHECKS      (MIG_PARAM_CHECKS),
     .INTERFACE             (INTERFACE),
     .ADV_USER_REQ          (ADV_USER_REQ),
     .MEMORY_DENSITY        (MEMORY_DENSITY),
     .MEMORY_SPEED_GRADE    (MEMORY_SPEED_GRADE),
     .MEMORY_WIDTH          (MEMORY_WIDTH),
     .MEMORY_CONFIGURATION  (MEMORY_CONFIGURATION),
     .CALIB_HIGH_SPEED      (CALIB_HIGH_SPEED),

     .MR0                   (MR0),
     .MR1                   (MR1),
     .MR2                   (MR2),
     .MR3                   (MR3),
     .MR4                   (MR4),
     .MR5                   (MR5),
     .MR6                   (MR6),

     .RD_VREF_VAL           (RD_VREF_VAL),  
     .SLOT0_ODD_CS          (SLOT0_ODD_CS),
     .SLOT1_ODD_CS          (SLOT1_ODD_CS),
     
     .DDR4_CLAMSHELL         (DDR4_CLAMSHELL),
     .CA_MIRROR              (CA_MIRROR),
     .DDR4_REG_PARITY_ENABLE (DDR4_REG_PARITY_ENABLE),
     
     .t200us                 (t200us),
     .t500us                 (t500us),
     .tXPR                   (tXPR),
     .tMOD                   (tMOD),
     .tMRD                   (tMRD),
     .tZQINIT                (tZQINIT),
     .TCQ                    (TCQ),
     
     .EARLY_WR_DATA          (EARLY_WR_DATA),
     .MEM_CODE               (MEM_CODE),
 
     .MIGRATION              (MIGRATION),
     .CK_SKEW                (CK_SKEW),
     .ADDR_SKEW              (ADDR_SKEW),
     .BA_SKEW                (BA_SKEW),
     .BG_SKEW                (BG_SKEW),
     .ACT_SKEW               (ACT_SKEW),
     .PAR_SKEW               (PAR_SKEW),
     .CKE_SKEW               (CKE_SKEW),
     .CS_SKEW                (CS_SKEW),
     .ODT_SKEW               (ODT_SKEW),
     .C_SKEW                 (C_SKEW),

     .BISC_EN                (BISC_EN),
     .BYPASS_CAL             (BYPASS_CAL),
     .CAL_DQS_GATE           (CAL_DQS_GATE),
     .CAL_WRLVL              (CAL_WRLVL),
     .CAL_RDLVL              (CAL_RDLVL),
     .CAL_RDLVL_DBI          (CAL_RDLVL_DBI),
     .CAL_WR_DQS_DQ          (CAL_WR_DQS_DQ),
     .CAL_WR_DQS_DM_DBI      (CAL_WR_DQS_DM_DBI),
     .CAL_WRITE_LAT          (CAL_WRITE_LAT),
     .CAL_RDLVL_COMPLEX      (CAL_RDLVL_COMPLEX),
     .CAL_WR_DQS_COMPLEX     (CAL_WR_DQS_COMPLEX),
     .CAL_RD_VREF            (CAL_RD_VREF),
     .CAL_RD_VREF_PATTERN    (CAL_RD_VREF_PATTERN),
     .CAL_WR_VREF            (CAL_WR_VREF),
     .CAL_WR_VREF_PATTERN    (CAL_WR_VREF_PATTERN),
     .CAL_DQS_TRACKING       (CAL_DQS_TRACKING),
     .CAL_JITTER             (CAL_JITTER),
     .CPLX_PAT_LENGTH        (CPLX_PAT_LENGTH),
     .C_FAMILY               (C_FAMILY),
     
     .CLKOUTPHY_MODE         (CLKOUTPHY_MODE),
     .CLKFBOUT_MULT_MMCM     (CLKFBOUT_MULT_MMCM),
     .DIVCLK_DIVIDE_MMCM     (DIVCLK_DIVIDE_MMCM),
     .CLKOUT0_DIVIDE_MMCM    (CLKOUT0_DIVIDE_MMCM)
   )
u_ddr4_mem_intfc
  (

   .sys_clk_p           (c0_sys_clk_p),
   .sys_clk_n           (c0_sys_clk_n),
   .mmcm_lock           (mmcm_lock),
   .reset_ub            (reset_ub),
   .pllGate             (pllGate),
   .div_clk             (c0_div_clk),
   .div_clk_rst         (c0_div_clk_rst),
   .riu_clk             (c0_riu_clk),
   .riu_clk_rst         (c0_riu_clk_rst),
   .pll_lock            (pll_lock),
   .sys_clk_in          (sys_clk_in),
   .mmcm_clk_in         (c0_mmcm_clk_in),
   .calDone             (c0_init_calib_complete),

   .ddr4_act_n          (c0_ddr4_act_n),
   .ddr4_adr            (c0_ddr4_adr),
   .ddr4_ba             (c0_ddr4_ba),
   .ddr4_bg             (c0_ddr4_bg),
   .ddr4_c              (),
   .ddr4_cke            (c0_ddr4_cke),
   .ddr4_odt            (c0_ddr4_odt),
   .ddr4_cs_n           (c0_ddr4_cs_n),
   .ddr4_ck_t           (c0_ddr4_ck_t),
   .ddr4_ck_c           (c0_ddr4_ck_c),
   .ddr4_reset_n        (c0_ddr4_reset_n),
   .ddr4_dm_dbi_n       (c0_ddr4_dm_dbi_n),
   .ddr4_dq             (c0_ddr4_dq),
   .ddr4_dqs_c          (c0_ddr4_dqs_c),
   .ddr4_dqs_t          (c0_ddr4_dqs_t),

   .app_addr              (c0_ddr4_app_addr),
   .app_cmd               (c0_ddr4_app_cmd),
   .app_en                (c0_ddr4_app_en),
   .app_hi_pri            (c0_ddr4_app_hi_pri),
   .app_autoprecharge     (1'b0),
   .app_wdf_data          (c0_ddr4_app_wdf_data),
   .app_wdf_end           (c0_ddr4_app_wdf_end),
   .app_wdf_mask          (c0_ddr4_app_wdf_mask),
   .app_wdf_wren          (c0_ddr4_app_wdf_wren),
   .app_correct_en_i      (c0_ddr4_app_correct_en_i),
   .app_raw_not_ecc       (c0_ddr4_app_raw_not_ecc),
   .app_ecc_multiple_err  (c0_ddr4_app_ecc_multiple_err),
   .app_rd_data           (c0_ddr4_app_rd_data),
   .app_rd_data_end       (c0_ddr4_app_rd_data_end),
   .app_rd_data_valid     (c0_ddr4_app_rd_data_valid),
   .app_rdy               (c0_ddr4_app_rdy),
   .app_wdf_rdy           (c0_ddr4_app_wdf_rdy),
   .app_ref_req           (1'b0),
   .app_ref_ack           (),
   .app_zq_req            (1'b0),
   .app_zq_ack            (),   
   .sl_iport0             (sl_iport0),
   .sl_oport0             (sl_oport0),
   .ddr4_mcs_lmb_ue                (),
   .ddr4_mcs_lmb_ce                (),
   .cal_pre_status        (),
   .cal_r1_status         (),
   .cal_r2_status         (),
   .cal_r3_status         (),
   .cal_post_status       (),
   .cal_error             (),
   .cal_error_bit         (),
   .cal_error_nibble      (),
   .cal_error_code        (),
   .app_sr_req            (1'b0),
   .app_sr_active         (),
   .app_mem_init_skip     (1'b0),
   .app_save_req          (1'b0),
   .app_save_ack          (),
   .app_restore_en        (1'b0),
   .app_restore_complete  (1'b0),
   .xsdb_select           (1'b0),
   .xsdb_rd_en            (1'b0),
   .xsdb_wr_en            (1'b0),
   .xsdb_addr             (16'b0),
   .xsdb_wr_data          (9'b0),
   .xsdb_rd_data          (),
   .xsdb_rdy              (),
   .dbg_out               (),
   .restore_crc_error     (),
   .traffic_wr_done               (1'b0),
   .traffic_status_err_bit_valid  (1'b0),
   .traffic_status_err_type_valid (1'b0),
   .traffic_status_err_type       (1'b0),
   .traffic_status_done           (1'b0),
   .traffic_status_watch_dog_hang (1'b0),
   .traffic_error                 ({APP_DATA_WIDTH{1'b0}}),
   .win_start                     (4'b0),
   .traffic_clr_error             (),
   .traffic_start                 (),
   .traffic_rst                   (),
   .traffic_err_chk_en            (),
   .traffic_instr_addr_mode       (),
   .traffic_instr_data_mode       (),
   .traffic_instr_rw_mode         (),
   .traffic_instr_rw_submode      (),
   .traffic_instr_num_of_iter     (),
   .traffic_instr_nxt_instr       (),
   .win_status                    (),
   .ecc_err_addr          (c0_ddr4_ecc_err_addr_int),
   .eccSingle             (c0_ddr4_ecc_single_int),
   .eccMultiple           (c0_ddr4_ecc_multiple_int),
   .fi_xor_we             (c0_ddr4_fi_xor_we),
   .fi_xor_wrdata         (c0_ddr4_fi_xor_wrdata),
   .rd_data_phy2mc        (c0_ddr4_rd_data_phy2mc),
     //Debug Port
   .dbg_bus               (dbg_bus), 
   .dbg_rd_data_cmp           (),
   .dbg_expected_data         (),
   .dbg_cal_seq               (),
   .dbg_cal_seq_cnt           (),
   .dbg_cal_seq_rd_cnt        (),
   .dbg_rd_valid              (),
   .dbg_cmp_byte              (),
   .dbg_rd_data               (),
   .dbg_cplx_config           (),
   .dbg_cplx_status           (),
   .dbg_io_address            (),
   .dbg_pllGate               (),
   .dbg_phy2clb_fixdly_rdy_low(),
   .dbg_phy2clb_fixdly_rdy_upp(),
   .dbg_phy2clb_phy_rdy_low   (),
   .dbg_phy2clb_phy_rdy_upp   (),
   .cal_r0_status             ()
   );
    assign c0_ddr4_app_raw_not_ecc    = {2*nCK_PER_CLK{1'b0}};
    assign c0_ddr4_fi_xor_we          = {DQ_WIDTH/8{1'b0}};
    assign c0_ddr4_fi_xor_wrdata      = {DQ_WIDTH{1'b0}};

endmodule
