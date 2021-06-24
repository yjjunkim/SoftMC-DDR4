//-----------------------------------------------------------------------------
//
// (c) Copyright 2009-2011 Xilinx, Inc. All rights reserved.
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
//
//-----------------------------------------------------------------------------
// Project    : Virtex-6 Integrated Block for PCI Express
// File       : pcie_2_0_rport_v6.v
// Version    : 2.4
//-- Description: Virtex6 solution wrapper : Root Port for PCI Express
//--
//--
//--
//--------------------------------------------------------------------------------

`timescale 1ns/1ns

module pcie_2_0_rport_v6 # (

  parameter        REF_CLK_FREQ = 0,                        // 0 - 100 MHz, 1 - 125 MHz, 2 - 250 MHz
  parameter        PIPE_PIPELINE_STAGES = 0,                // 0 - 0 stages, 1 - 1 stage, 2 - 2 stages
  parameter        PCIE_DRP_ENABLE = "FALSE",
  parameter        DS_PORT_HOT_RST = "FALSE",               // FALSE - for ROOT PORT(default), TRUE - for DOWNSTREAM PORT
  parameter        AER_BASE_PTR = 12'h128,
  parameter        AER_CAP_ECRC_CHECK_CAPABLE = "FALSE",
  parameter        AER_CAP_ECRC_GEN_CAPABLE = "FALSE",
  parameter        AER_CAP_ID = 16'h0001,
  parameter        AER_CAP_INT_MSG_NUM_MSI = 5'h0a,
  parameter        AER_CAP_INT_MSG_NUM_MSIX = 5'h15,
  parameter        AER_CAP_NEXTPTR = 12'h160,
  parameter        AER_CAP_ON = "FALSE",
  parameter        AER_CAP_PERMIT_ROOTERR_UPDATE = "TRUE",
  parameter        AER_CAP_VERSION = 4'h1,
  parameter        ALLOW_X8_GEN2 = "FALSE",
  parameter        BAR0 = 32'h00000000,  // Memory aperture disabled
  parameter        BAR1 = 32'h00000000,  // Memory aperture disabled
  parameter        BAR2 = 32'h00ffffff,  // Constant for rport
  parameter        BAR3 = 32'hffff0000,  // IO Limit/Base Registers not implemented
  parameter        BAR4 = 32'hfff0fff0,  // Constant for rport
  parameter        BAR5 = 32'hFFF1_FFF1, // Prefetchable Memory Limit/Base Registers implemented
  parameter        CAPABILITIES_PTR = 8'h40,
  parameter        CARDBUS_CIS_POINTER = 32'h00000000,
  parameter        CLASS_CODE = 24'h060400,
  parameter        CMD_INTX_IMPLEMENTED = "TRUE",
  parameter        CPL_TIMEOUT_DISABLE_SUPPORTED = "FALSE",
  parameter        CPL_TIMEOUT_RANGES_SUPPORTED = 4'h0,
  parameter        CRM_MODULE_RSTS = 7'h00,
  parameter        DEV_CAP_ENABLE_SLOT_PWR_LIMIT_SCALE = "TRUE",
  parameter        DEV_CAP_ENABLE_SLOT_PWR_LIMIT_VALUE = "TRUE",
  parameter        DEV_CAP_ENDPOINT_L0S_LATENCY = 0,
  parameter        DEV_CAP_ENDPOINT_L1_LATENCY = 0,
  parameter        DEV_CAP_EXT_TAG_SUPPORTED = "TRUE",
  parameter        DEV_CAP_FUNCTION_LEVEL_RESET_CAPABLE = "FALSE",
  parameter        DEV_CAP_MAX_PAYLOAD_SUPPORTED = 1,
  parameter        DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT = 0,
  parameter        DEV_CAP_ROLE_BASED_ERROR = "TRUE",
  parameter        DEV_CAP_RSVD_14_12 = 0,
  parameter        DEV_CAP_RSVD_17_16 = 0,
  parameter        DEV_CAP_RSVD_31_29 = 0,
  parameter        DEV_CONTROL_AUX_POWER_SUPPORTED = "FALSE",
  parameter        DEVICE_ID = 16'h0007,
  parameter        DISABLE_ASPM_L1_TIMER = "FALSE",
  parameter        DISABLE_BAR_FILTERING = "TRUE",
  parameter        DISABLE_ID_CHECK = "TRUE",
  parameter        DISABLE_LANE_REVERSAL = "FALSE",
  parameter        DISABLE_RX_TC_FILTER = "TRUE",
  parameter        DISABLE_SCRAMBLING = "FALSE",
  parameter        DNSTREAM_LINK_NUM = 8'h00,
  parameter        DSN_BASE_PTR = 12'h100,
  parameter        DSN_CAP_ID = 16'h0003,
  parameter        DSN_CAP_NEXTPTR = 12'h10c,
  parameter        DSN_CAP_ON = "TRUE",
  parameter        DSN_CAP_VERSION = 4'h1,
  parameter        ENABLE_MSG_ROUTE = 11'h200,
  parameter        ENABLE_RX_TD_ECRC_TRIM = "FALSE",
  parameter        ENTER_RVRY_EI_L0 = "TRUE",
  parameter        EXPANSION_ROM = 32'h00000000, // Memory aperture disabled
  parameter        EXT_CFG_CAP_PTR = 6'h3f,
  parameter        EXT_CFG_XP_CAP_PTR = 10'h3ff,
  parameter        HEADER_TYPE = 8'h01,
  parameter        INFER_EI = 5'h0c,
  parameter        INTERRUPT_PIN = 8'h01,
  parameter        IS_SWITCH = "FALSE",
  parameter        LAST_CONFIG_DWORD = 10'h042,
  parameter        LINK_CAP_ASPM_SUPPORT = 1,
  parameter        LINK_CAP_CLOCK_POWER_MANAGEMENT = "FALSE",
  parameter        LINK_CAP_DLL_LINK_ACTIVE_REPORTING_CAP = "FALSE",
  parameter        LINK_CAP_LINK_BANDWIDTH_NOTIFICATION_CAP = "FALSE",
  parameter        LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN1 = 7,
  parameter        LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN2 = 7,
  parameter        LINK_CAP_L0S_EXIT_LATENCY_GEN1 = 7,
  parameter        LINK_CAP_L0S_EXIT_LATENCY_GEN2 = 7,
  parameter        LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN1 = 7,
  parameter        LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN2 = 7,
  parameter        LINK_CAP_L1_EXIT_LATENCY_GEN1 = 7,
  parameter        LINK_CAP_L1_EXIT_LATENCY_GEN2 = 7,
  parameter        LINK_CAP_MAX_LINK_SPEED = 4'h1,
  parameter        LINK_CAP_MAX_LINK_WIDTH = 6'h08,
  parameter        LINK_CAP_RSVD_23_22 = 0,
  parameter        LINK_CAP_SURPRISE_DOWN_ERROR_CAPABLE = "FALSE",
  parameter        LINK_CONTROL_RCB = 0,
  parameter        LINK_CTRL2_DEEMPHASIS = "FALSE",
  parameter        LINK_CTRL2_HW_AUTONOMOUS_SPEED_DISABLE = "FALSE",
  parameter        LINK_CTRL2_TARGET_LINK_SPEED = LINK_CAP_MAX_LINK_SPEED,
  parameter        LINK_STATUS_SLOT_CLOCK_CONFIG = "TRUE",
  parameter        LL_ACK_TIMEOUT = 15'h0204,
  parameter        LL_ACK_TIMEOUT_EN = "FALSE",
  parameter        LL_ACK_TIMEOUT_FUNC = 0,
  parameter        LL_REPLAY_TIMEOUT = 15'h060d,
  parameter        LL_REPLAY_TIMEOUT_EN = "FALSE",
  parameter        LL_REPLAY_TIMEOUT_FUNC = 0,
  parameter        LTSSM_MAX_LINK_WIDTH = LINK_CAP_MAX_LINK_WIDTH,
  parameter        MSI_BASE_PTR = 8'h48,
  parameter        MSI_CAP_ID = 8'h05,
  parameter        MSI_CAP_MULTIMSGCAP = 0,
  parameter        MSI_CAP_MULTIMSG_EXTENSION = 0,
  parameter        MSI_CAP_NEXTPTR = 8'h60,
  parameter        MSI_CAP_ON = "TRUE",
  parameter        MSI_CAP_PER_VECTOR_MASKING_CAPABLE = "TRUE",
  parameter        MSI_CAP_64_BIT_ADDR_CAPABLE = "TRUE",
  parameter        MSIX_BASE_PTR = 8'h9c,
  parameter        MSIX_CAP_ID = 8'h11,
  parameter        MSIX_CAP_NEXTPTR = 8'h00,
  parameter        MSIX_CAP_ON = "TRUE",
  parameter        MSIX_CAP_PBA_BIR = 0,
  parameter        MSIX_CAP_PBA_OFFSET = 29'h00000050,
  parameter        MSIX_CAP_TABLE_BIR = 0,
  parameter        MSIX_CAP_TABLE_OFFSET = 29'h00000040,
  parameter        MSIX_CAP_TABLE_SIZE = 11'h000,
  parameter        N_FTS_COMCLK_GEN1 = 255,
  parameter        N_FTS_COMCLK_GEN2 = 254,
  parameter        N_FTS_GEN1 = 255,
  parameter        N_FTS_GEN2 = 255,
  parameter        PCIE_BASE_PTR = 8'h60,
  parameter        PCIE_CAP_CAPABILITY_ID = 8'h10,
  parameter        PCIE_CAP_CAPABILITY_VERSION = 4'h2,
  parameter        PCIE_CAP_DEVICE_PORT_TYPE = 4'h4,
  parameter        PCIE_CAP_INT_MSG_NUM = 5'h00,
  parameter        PCIE_CAP_NEXTPTR = 8'h9c,
  parameter        PCIE_CAP_ON = "TRUE",
  parameter        PCIE_CAP_RSVD_15_14 = 0,
  parameter        PCIE_CAP_SLOT_IMPLEMENTED = "TRUE",
  parameter        PCIE_REVISION = 2,
  parameter        PGL0_LANE = 0,
  parameter        PGL1_LANE = 1,
  parameter        PGL2_LANE = 2,
  parameter        PGL3_LANE = 3,
  parameter        PGL4_LANE = 4,
  parameter        PGL5_LANE = 5,
  parameter        PGL6_LANE = 6,
  parameter        PGL7_LANE = 7,
  parameter        PL_AUTO_CONFIG = 0,
  parameter        PL_FAST_TRAIN = "FALSE",
  parameter        PM_BASE_PTR = 8'h40,
  parameter        PM_CAP_AUXCURRENT = 0,
  parameter        PM_CAP_DSI = "FALSE",
  parameter        PM_CAP_D1SUPPORT = "TRUE",
  parameter        PM_CAP_D2SUPPORT = "TRUE",
  parameter        PM_CAP_ID = 8'h01,
  parameter        PM_CAP_NEXTPTR = 8'h48,
  parameter        PM_CAP_ON = "TRUE",
  parameter        PM_CAP_PME_CLOCK = "FALSE",
  parameter        PM_CAP_PMESUPPORT = 5'h0f,
  parameter        PM_CAP_RSVD_04 = 0,
  parameter        PM_CAP_VERSION = 3,
  parameter        PM_CSR_BPCCEN = "FALSE",
  parameter        PM_CSR_B2B3 = "FALSE",
  parameter        PM_CSR_NOSOFTRST = "TRUE",
  parameter        PM_DATA_SCALE0 = 2'h1,
  parameter        PM_DATA_SCALE1 = 2'h1,
  parameter        PM_DATA_SCALE2 = 2'h1,
  parameter        PM_DATA_SCALE3 = 2'h1,
  parameter        PM_DATA_SCALE4 = 2'h1,
  parameter        PM_DATA_SCALE5 = 2'h1,
  parameter        PM_DATA_SCALE6 = 2'h1,
  parameter        PM_DATA_SCALE7 = 2'h1,
  parameter        PM_DATA0 = 8'h01,
  parameter        PM_DATA1 = 8'h01,
  parameter        PM_DATA2 = 8'h01,
  parameter        PM_DATA3 = 8'h01,
  parameter        PM_DATA4 = 8'h01,
  parameter        PM_DATA5 = 8'h01,
  parameter        PM_DATA6 = 8'h01,
  parameter        PM_DATA7 = 8'h01,
  parameter        RECRC_CHK = 0,
  parameter        RECRC_CHK_TRIM = "FALSE",
  parameter        REVISION_ID = 8'h00,
  parameter        ROOT_CAP_CRS_SW_VISIBILITY = "FALSE",
  parameter        SELECT_DLL_IF = "FALSE",
  parameter        SLOT_CAP_ATT_BUTTON_PRESENT = "FALSE",
  parameter        SLOT_CAP_ATT_INDICATOR_PRESENT = "FALSE",
  parameter        SLOT_CAP_ELEC_INTERLOCK_PRESENT = "FALSE",
  parameter        SLOT_CAP_HOTPLUG_CAPABLE = "FALSE",
  parameter        SLOT_CAP_HOTPLUG_SURPRISE = "FALSE",
  parameter        SLOT_CAP_MRL_SENSOR_PRESENT = "FALSE",
  parameter        SLOT_CAP_NO_CMD_COMPLETED_SUPPORT = "FALSE",
  parameter        SLOT_CAP_PHYSICAL_SLOT_NUM = 13'h0000,
  parameter        SLOT_CAP_POWER_CONTROLLER_PRESENT = "FALSE",
  parameter        SLOT_CAP_POWER_INDICATOR_PRESENT = "FALSE",
  parameter        SLOT_CAP_SLOT_POWER_LIMIT_SCALE = 0,
  parameter        SLOT_CAP_SLOT_POWER_LIMIT_VALUE = 8'h00,
  parameter        SPARE_BIT0 = 0,
  parameter        SPARE_BIT1 = 0,
  parameter        SPARE_BIT2 = 0,
  parameter        SPARE_BIT3 = 0,
  parameter        SPARE_BIT4 = 0,
  parameter        SPARE_BIT5 = 0,
  parameter        SPARE_BIT6 = 0,
  parameter        SPARE_BIT7 = 0,
  parameter        SPARE_BIT8 = 0,
  parameter        SPARE_BYTE0 = 8'h00,
  parameter        SPARE_BYTE1 = 8'h00,
  parameter        SPARE_BYTE2 = 8'h00,
  parameter        SPARE_BYTE3 = 8'h00,
  parameter        SPARE_WORD0 = 32'h00000000,
  parameter        SPARE_WORD1 = 32'h00000000,
  parameter        SPARE_WORD2 = 32'h00000000,
  parameter        SPARE_WORD3 = 32'h00000000,
  parameter        SUBSYSTEM_ID = 16'h0007,
  parameter        SUBSYSTEM_VENDOR_ID = 16'h10ee,
  parameter        TL_RBYPASS = "FALSE",
  parameter        TL_RX_RAM_RADDR_LATENCY = 0,
  parameter        TL_RX_RAM_RDATA_LATENCY = 2,
  parameter        TL_RX_RAM_WRITE_LATENCY = 0,
  parameter        TL_TFC_DISABLE = "FALSE",
  parameter        TL_TX_CHECKS_DISABLE = "FALSE",
  parameter        TL_TX_RAM_RADDR_LATENCY = 0,
  parameter        TL_TX_RAM_RDATA_LATENCY = 2,
  parameter        TL_TX_RAM_WRITE_LATENCY = 0,
  parameter        UPCONFIG_CAPABLE = "TRUE",
  parameter        UPSTREAM_FACING = "FALSE",
  parameter        EXIT_LOOPBACK_ON_EI  = "TRUE",
  parameter        UR_INV_REQ = "TRUE",
  parameter        USER_CLK_FREQ = 3,
  parameter        VC_BASE_PTR = 12'h10c,
  parameter        VC_CAP_ID = 16'h0002,
  parameter        VC_CAP_NEXTPTR = 12'h128,
  parameter        VC_CAP_ON = "TRUE",
  parameter        VC_CAP_REJECT_SNOOP_TRANSACTIONS = "FALSE",
  parameter        VC_CAP_VERSION = 4'h1,
  parameter        VC0_CPL_INFINITE = "TRUE",
  parameter        VC0_RX_RAM_LIMIT = 13'h01ff,
  parameter        VC0_TOTAL_CREDITS_CD = 77,
  parameter        VC0_TOTAL_CREDITS_CH = 36,
  parameter        VC0_TOTAL_CREDITS_NPH = 12,
  parameter        VC0_TOTAL_CREDITS_PD = 77,
  parameter        VC0_TOTAL_CREDITS_PH = 32,
  parameter        VC0_TX_LASTPACKET = 13,
  parameter        VENDOR_ID = 16'h10ee,
  parameter        VSEC_BASE_PTR = 12'h160,
  parameter        VSEC_CAP_HDR_ID = 16'h1234,
  parameter        VSEC_CAP_HDR_LENGTH = 12'h018,
  parameter        VSEC_CAP_HDR_REVISION = 4'h1,
  parameter        VSEC_CAP_ID = 16'h000b,
  parameter        VSEC_CAP_IS_LINK_VISIBLE = "TRUE",
  parameter        VSEC_CAP_NEXTPTR = 12'h000,
  parameter        VSEC_CAP_ON = "TRUE",
  parameter        VSEC_CAP_VERSION = 4'h1
)
(
  //-------------------------------------------------------
  // 1. PCI Express (pci_exp) Interface
  //-------------------------------------------------------

  // Tx
  output  [(LINK_CAP_MAX_LINK_WIDTH - 1):0]     pci_exp_txp,
  output  [(LINK_CAP_MAX_LINK_WIDTH - 1):0]     pci_exp_txn,

  // Rx
  input   [(LINK_CAP_MAX_LINK_WIDTH - 1):0]     pci_exp_rxp,
  input   [(LINK_CAP_MAX_LINK_WIDTH - 1):0]     pci_exp_rxn,

  //-------------------------------------------------------
  // 2. Transaction (TRN) Interface
  //-------------------------------------------------------

  // Common
  output                                        trn_clk,
  output                                        trn_reset_n,
  output                                        trn_lnk_up_n,

  // Tx
  output  [5:0]                                 trn_tbuf_av,
  output                                        trn_tcfg_req_n,
  output                                        trn_terr_drop_n,
  output                                        trn_tdst_rdy_n,
  input  [63:0]                                 trn_td,
  input                                         trn_trem_n,
  input                                         trn_tsof_n,
  input                                         trn_teof_n,
  input                                         trn_tsrc_rdy_n,
  input                                         trn_tsrc_dsc_n,
  input                                         trn_terrfwd_n,
  input                                         trn_tcfg_gnt_n,
  input                                         trn_tstr_n,

  // Rx
  output  [63:0]                                trn_rd,
  output                                        trn_rrem_n,
  output                                        trn_rsof_n,
  output                                        trn_reof_n,
  output                                        trn_rsrc_rdy_n,
  output                                        trn_rsrc_dsc_n,
  output                                        trn_rerrfwd_n,
  output  [6:0]                                 trn_rbar_hit_n,
  input                                         trn_rdst_rdy_n,
  input                                         trn_rnp_ok_n,
  output                                        trn_recrc_err_n,

  // Flow Control
  output [11:0]                                 trn_fc_cpld,
  output  [7:0]                                 trn_fc_cplh,
  output [11:0]                                 trn_fc_npd,
  output  [7:0]                                 trn_fc_nph,
  output [11:0]                                 trn_fc_pd,
  output  [7:0]                                 trn_fc_ph,
  input   [2:0]                                 trn_fc_sel,


  //-------------------------------------------------------
  // 3. Configuration (CFG) Interface
  //-------------------------------------------------------

  output [31:0]                                 cfg_do,
  output                                        cfg_rd_wr_done_n,
  input  [31:0]                                 cfg_di,
  input   [3:0]                                 cfg_byte_en_n,
  input   [9:0]                                 cfg_dwaddr,
  input                                         cfg_wr_en_n,
  input                                         cfg_wr_rw1c_as_rw_n,
  input                                         cfg_rd_en_n,

  input                                         cfg_err_cor_n,
  input                                         cfg_err_ur_n,
  input                                         cfg_err_ecrc_n,
  input                                         cfg_err_cpl_timeout_n,
  input                                         cfg_err_cpl_abort_n,
  input                                         cfg_err_cpl_unexpect_n,
  input                                         cfg_err_posted_n,
  input                                         cfg_err_locked_n,
  input  [47:0]                                 cfg_err_tlp_cpl_header,
  output                                        cfg_err_cpl_rdy_n,
  input                                         cfg_interrupt_n,
  output                                        cfg_interrupt_rdy_n,
  input                                         cfg_interrupt_assert_n,
  input  [7:0]                                  cfg_interrupt_di,
  output [7:0]                                  cfg_interrupt_do,
  output [2:0]                                  cfg_interrupt_mmenable,
  output                                        cfg_interrupt_msienable,
  output                                        cfg_interrupt_msixenable,
  output                                        cfg_interrupt_msixfm,
  input                                         cfg_trn_pending_n,
  input                                         cfg_pm_send_pme_to_n,
  output [15:0]                                 cfg_status,
  output [15:0]                                 cfg_command,
  output [15:0]                                 cfg_dstatus,
  output [15:0]                                 cfg_dcommand,
  output [15:0]                                 cfg_lstatus,
  output [15:0]                                 cfg_lcommand,
  output [15:0]                                 cfg_dcommand2,
  output  [2:0]                                 cfg_pcie_link_state_n,
  input  [63:0]                                 cfg_dsn,
  output                                        cfg_pmcsr_pme_en,
  output                                        cfg_pmcsr_pme_status,
  output [1:0]                                  cfg_pmcsr_powerstate,

  output                                        cfg_msg_received,
  output [15:0]                                 cfg_msg_data,
  output                                        cfg_msg_received_err_cor,
  output                                        cfg_msg_received_err_non_fatal,
  output                                        cfg_msg_received_err_fatal,
  output                                        cfg_msg_received_pme_to_ack,
  output                                        cfg_msg_received_assert_inta,
  output                                        cfg_msg_received_assert_intb,
  output                                        cfg_msg_received_assert_intc,
  output                                        cfg_msg_received_assert_intd,
  output                                        cfg_msg_received_deassert_inta,
  output                                        cfg_msg_received_deassert_intb,
  output                                        cfg_msg_received_deassert_intc,
  output                                        cfg_msg_received_deassert_intd,

  input   [7:0]                                 cfg_ds_bus_number,
  input   [4:0]                                 cfg_ds_device_number,

  //-------------------------------------------------------
  // 4. Physical Layer Control and Status (PL) Interface
  //-------------------------------------------------------

  output [2:0]                                  pl_initial_link_width,
  output [1:0]                                  pl_lane_reversal_mode,
  output                                        pl_link_gen2_capable,
  output                                        pl_link_partner_gen2_supported,
  output                                        pl_link_upcfg_capable,
  output [5:0]                                  pl_ltssm_state,
  output                                        pl_sel_link_rate,
  output [1:0]                                  pl_sel_link_width,
  input                                         pl_directed_link_auton,
  input  [1:0]                                  pl_directed_link_change,
  input                                         pl_directed_link_speed,
  input  [1:0]                                  pl_directed_link_width,
  input                                         pl_upstream_prefer_deemph,
  input                                         pl_transmit_hot_rst,


  //-------------------------------------------------------
  // 5. PCIe DRP (PCIe DRP) Interface
  //-------------------------------------------------------

  input                                         pcie_drp_clk,
  input                                         pcie_drp_den,
  input                                         pcie_drp_dwe,
  input  [8:0]                                  pcie_drp_daddr,
  input  [15:0]                                 pcie_drp_di,
  output [15:0]                                 pcie_drp_do,
  output                                        pcie_drp_drdy,

  //-------------------------------------------------------
  // 6. System  (SYS) Interface
  //-------------------------------------------------------

  input                                         sys_clk,
  input                                         sys_reset_n

);

  localparam                                    LP_LINK_CAP_LINK_BANDWIDTH_NOTIFICATION_CAP =
                                                   ((LINK_CAP_MAX_LINK_WIDTH > 6'h01) || (LINK_CAP_MAX_LINK_SPEED > 4'h1)) ? "TRUE" : "FALSE";


  wire                                          rx_func_level_reset_n;

  wire                                          cfg_cmd_bme;
  wire                                          cfg_cmd_intdis;
  wire                                          cfg_cmd_io_en;
  wire                                          cfg_cmd_mem_en;
  wire                                          cfg_cmd_serr_en;
  wire                                          cfg_dev_control_aux_power_en ;
  wire                                          cfg_dev_control_corr_err_reporting_en ;
  wire                                          cfg_dev_control_enable_relaxed_order ;
  wire                                          cfg_dev_control_ext_tag_en ;
  wire                                          cfg_dev_control_fatal_err_reporting_en ;
  wire [2:0]                                    cfg_dev_control_maxpayload ;
  wire [2:0]                                    cfg_dev_control_max_read_req ;
  wire                                          cfg_dev_control_non_fatal_reporting_en ;
  wire                                          cfg_dev_control_nosnoop_en ;
  wire                                          cfg_dev_control_phantom_en ;
  wire                                          cfg_dev_control_ur_err_reporting_en ;
  wire                                          cfg_dev_control2_cpltimeout_dis ;
  wire [3:0]                                    cfg_dev_control2_cpltimeout_val ;
  wire                                          cfg_dev_status_corr_err_detected ;
  wire                                          cfg_dev_status_fatal_err_detected ;
  wire                                          cfg_dev_status_nonfatal_err_detected ;
  wire                                          cfg_dev_status_ur_detected ;
  wire                                          cfg_link_control_auto_bandwidth_int_en ;
  wire                                          cfg_link_control_bandwidth_int_en ;
  wire                                          cfg_link_control_hw_auto_width_dis ;
  wire                                          cfg_link_control_clock_pm_en ;
  wire                                          cfg_link_control_extended_sync ;
  wire                                          cfg_link_control_common_clock ;
  wire                                          cfg_link_control_retrain_link ;
  wire                                          cfg_link_control_linkdisable ;
  wire                                          cfg_link_control_rcb ;
  wire [1:0]                                    cfg_link_control_aspm_control ;
  wire                                          cfg_link_status_auto_bandwidth_status ;
  wire                                          cfg_link_status_bandwidth_status ;
  wire                                          cfg_link_status_dll_active ;
  wire                                          cfg_link_status_link_training ;
  wire [3:0]                                    cfg_link_status_negotiated_link_width ;
  wire [1:0]                                    cfg_link_status_current_speed ;

  wire                                          sys_reset_n_d;
  wire                                          phy_rdy_n;

  wire                                          trn_lnk_up_n_int;
  wire                                          trn_lnk_up_n_int1;

  wire                                          trn_reset_n_int;
  wire                                          trn_reset_n_int1;


  wire                                          TxOutClk;
  wire                                          TxOutClk_bufg;

  // assigns to outputs

  assign                                        cfg_status = {16'b0};

  assign                                        cfg_command = {5'b0,
                                                               cfg_cmd_intdis,
                                                               1'b0,
                                                               cfg_cmd_serr_en,
                                                               5'b0,
                                                               cfg_cmd_bme,
                                                               cfg_cmd_mem_en,
                                                               cfg_cmd_io_en};

  assign                                        cfg_dstatus = {10'h0,
                                                               cfg_trn_pending_n,
                                                               1'b0,
                                                               cfg_dev_status_ur_detected,
                                                               cfg_dev_status_fatal_err_detected,
                                                               cfg_dev_status_nonfatal_err_detected,
                                                               cfg_dev_status_corr_err_detected};

  assign                                        cfg_dcommand = {1'b0,
                                                               cfg_dev_control_max_read_req,
                                                               cfg_dev_control_nosnoop_en,
                                                               cfg_dev_control_aux_power_en,
                                                               cfg_dev_control_phantom_en,
                                                               cfg_dev_control_ext_tag_en,
                                                               cfg_dev_control_maxpayload,
                                                               cfg_dev_control_enable_relaxed_order,
                                                               cfg_dev_control_ur_err_reporting_en,
                                                               cfg_dev_control_fatal_err_reporting_en,
                                                               cfg_dev_control_non_fatal_reporting_en,
                                                               cfg_dev_control_corr_err_reporting_en };

  assign                                        cfg_lstatus = {cfg_link_status_auto_bandwidth_status,
                                                               cfg_link_status_bandwidth_status,
                                                               cfg_link_status_dll_active,
                                                               (LINK_STATUS_SLOT_CLOCK_CONFIG == "TRUE") ? 1'b1 : 1'b0,
                                                               cfg_link_status_link_training,
                                                               1'b0,
                                                               {2'b00, cfg_link_status_negotiated_link_width},
                                                               {2'b00, cfg_link_status_current_speed} };

  assign                                        cfg_lcommand = {cfg_link_control_auto_bandwidth_int_en,
                                                                cfg_link_control_bandwidth_int_en,
                                                                cfg_link_control_hw_auto_width_dis,
                                                                cfg_link_control_clock_pm_en,
                                                                cfg_link_control_extended_sync,
                                                                cfg_link_control_common_clock,
                                                                cfg_link_control_retrain_link,
                                                                cfg_link_control_linkdisable,
                                                                cfg_link_control_rcb,
                                                                1'b0,
                                                                cfg_link_control_aspm_control};

  assign                                        cfg_dcommand2 = {11'b0,
                                                                 cfg_dev_control2_cpltimeout_dis,
                                                                 cfg_dev_control2_cpltimeout_val};

  // Generate trn_lnk_up_n

FDCP #(

  .INIT(1'b1)

) trn_lnk_up_n_i (

  .Q (trn_lnk_up_n),
  .D (trn_lnk_up_n_int1),
  .C (trn_clk),
  .CLR (1'b0),
  .PRE (1'b0)

);

FDCP #(

  .INIT(1'b1)

) trn_lnk_up_n_int_i (

  .Q (trn_lnk_up_n_int1),
  .D (trn_lnk_up_n_int),
  .C (trn_clk),
  .CLR (1'b0),
  .PRE (1'b0)

);


  // Generate trn_reset_n

FDCP #(

  .INIT(1'b0)

) trn_reset_n_i (

  .Q (trn_reset_n),
  .D (trn_reset_n_int1 & ~phy_rdy_n),
  .C (trn_clk),
  .CLR (~sys_reset_n_d),
  .PRE (1'b0)

);

FDCP #(

  .INIT(1'b0)

) trn_reset_n_int_i (

  .Q (trn_reset_n_int1 ),
  .D (trn_reset_n_int & ~phy_rdy_n),
  .C (trn_clk),
  .CLR (~sys_reset_n_d),
  .PRE (1'b0)

);



//-------------------------------------------------------
// PCI Express Reset Delay Module
//-------------------------------------------------------

pcie_reset_delay_v6 #(

  .PL_FAST_TRAIN          ( PL_FAST_TRAIN ),
  .REF_CLK_FREQ           ( REF_CLK_FREQ )

)
pcie_reset_delay_i (

  .ref_clk                ( TxOutClk_bufg ),
  .sys_reset_n            ( sys_reset_n ),
  .delayed_sys_reset_n    ( sys_reset_n_d )

);

//-------------------------------------------------------
// PCI Express Clocking Module
//-------------------------------------------------------

pcie_clocking_v6 #(

  .IS_ENDPOINT("FALSE"),
  .CAP_LINK_WIDTH(LINK_CAP_MAX_LINK_WIDTH),
  .CAP_LINK_SPEED(LINK_CAP_MAX_LINK_SPEED),
  .REF_CLK_FREQ(REF_CLK_FREQ),
  .USER_CLK_FREQ(USER_CLK_FREQ)

)
pcie_clocking_i (

  .sys_clk                 ( TxOutClk ),
  .gt_pll_lock             ( gt_pll_lock ),
  .sel_lnk_rate            ( pl_sel_link_rate ),
  .sel_lnk_width           ( pl_sel_link_width ),

  .sys_clk_bufg            ( TxOutClk_bufg ),
  .pipe_clk                ( pipe_clk ),
  .block_clk               ( ),
  .user_clk                ( user_clk ),
  .drp_clk                 ( drp_clk ),
  .clock_locked            ( clock_locked )

);

//-------------------------------------------------------
// Virtex6 PCI Express Block Module
//-------------------------------------------------------

pcie_2_0_v6_rp #(

  .REF_CLK_FREQ ( REF_CLK_FREQ ),
  .PIPE_PIPELINE_STAGES ( PIPE_PIPELINE_STAGES ),
  .AER_BASE_PTR ( AER_BASE_PTR ),
  .AER_CAP_ECRC_CHECK_CAPABLE ( AER_CAP_ECRC_CHECK_CAPABLE ),
  .AER_CAP_ECRC_GEN_CAPABLE ( AER_CAP_ECRC_GEN_CAPABLE ),
  .AER_CAP_ID ( AER_CAP_ID ),
  .AER_CAP_INT_MSG_NUM_MSI ( AER_CAP_INT_MSG_NUM_MSI ),
  .AER_CAP_INT_MSG_NUM_MSIX ( AER_CAP_INT_MSG_NUM_MSIX ),
  .AER_CAP_NEXTPTR ( AER_CAP_NEXTPTR ),
  .AER_CAP_ON ( AER_CAP_ON ),
  .AER_CAP_PERMIT_ROOTERR_UPDATE ( AER_CAP_PERMIT_ROOTERR_UPDATE ),
  .AER_CAP_VERSION ( AER_CAP_VERSION ),
  .ALLOW_X8_GEN2 ( ALLOW_X8_GEN2 ),
  .BAR0 ( BAR0 ),
  .BAR1 ( BAR1 ),
  .BAR2 ( BAR2 ),
  .BAR3 ( BAR3 ),
  .BAR4 ( BAR4 ),
  .BAR5 ( BAR5 ),
  .CAPABILITIES_PTR ( CAPABILITIES_PTR ),
  .CARDBUS_CIS_POINTER ( CARDBUS_CIS_POINTER ),
  .CLASS_CODE ( CLASS_CODE ),
  .CMD_INTX_IMPLEMENTED ( CMD_INTX_IMPLEMENTED ),
  .CPL_TIMEOUT_DISABLE_SUPPORTED ( CPL_TIMEOUT_DISABLE_SUPPORTED ),
  .CPL_TIMEOUT_RANGES_SUPPORTED ( CPL_TIMEOUT_RANGES_SUPPORTED ),
  .CRM_MODULE_RSTS ( CRM_MODULE_RSTS ),
  .DEV_CAP_ENABLE_SLOT_PWR_LIMIT_SCALE ( DEV_CAP_ENABLE_SLOT_PWR_LIMIT_SCALE ),
  .DEV_CAP_ENABLE_SLOT_PWR_LIMIT_VALUE ( DEV_CAP_ENABLE_SLOT_PWR_LIMIT_VALUE ),
  .DEV_CAP_ENDPOINT_L0S_LATENCY ( DEV_CAP_ENDPOINT_L0S_LATENCY ),
  .DEV_CAP_ENDPOINT_L1_LATENCY ( DEV_CAP_ENDPOINT_L1_LATENCY ),
  .DEV_CAP_EXT_TAG_SUPPORTED ( DEV_CAP_EXT_TAG_SUPPORTED ),
  .DEV_CAP_FUNCTION_LEVEL_RESET_CAPABLE ( DEV_CAP_FUNCTION_LEVEL_RESET_CAPABLE ),
  .DEV_CAP_MAX_PAYLOAD_SUPPORTED ( DEV_CAP_MAX_PAYLOAD_SUPPORTED ),
  .DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT ( DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT ),
  .DEV_CAP_ROLE_BASED_ERROR ( DEV_CAP_ROLE_BASED_ERROR ),
  .DEV_CAP_RSVD_14_12 ( DEV_CAP_RSVD_14_12 ),
  .DEV_CAP_RSVD_17_16 ( DEV_CAP_RSVD_17_16 ),
  .DEV_CAP_RSVD_31_29 ( DEV_CAP_RSVD_31_29 ),
  .DEV_CONTROL_AUX_POWER_SUPPORTED ( DEV_CONTROL_AUX_POWER_SUPPORTED ),
  .DEVICE_ID ( DEVICE_ID ),
  .DISABLE_ASPM_L1_TIMER ( DISABLE_ASPM_L1_TIMER ),
  .DISABLE_BAR_FILTERING ( DISABLE_BAR_FILTERING ),
  .DISABLE_ID_CHECK ( DISABLE_ID_CHECK ),
  .DISABLE_LANE_REVERSAL ( DISABLE_LANE_REVERSAL ),
  .DISABLE_RX_TC_FILTER ( DISABLE_RX_TC_FILTER ),
  .DISABLE_SCRAMBLING ( DISABLE_SCRAMBLING ),
  .DNSTREAM_LINK_NUM ( DNSTREAM_LINK_NUM ),
  .DSN_BASE_PTR ( DSN_BASE_PTR ),
  .DSN_CAP_ID ( DSN_CAP_ID ),
  .DSN_CAP_NEXTPTR ( DSN_CAP_NEXTPTR ),
  .DSN_CAP_ON ( DSN_CAP_ON ),
  .DSN_CAP_VERSION ( DSN_CAP_VERSION ),
  .ENABLE_MSG_ROUTE ( ENABLE_MSG_ROUTE ),
  .ENABLE_RX_TD_ECRC_TRIM ( ENABLE_RX_TD_ECRC_TRIM ),
  .ENTER_RVRY_EI_L0 ( ENTER_RVRY_EI_L0 ),
  .EXPANSION_ROM ( EXPANSION_ROM ),
  .EXT_CFG_CAP_PTR ( EXT_CFG_CAP_PTR ),
  .EXT_CFG_XP_CAP_PTR ( EXT_CFG_XP_CAP_PTR ),
  .HEADER_TYPE ( HEADER_TYPE ),
  .INFER_EI ( INFER_EI ),
  .INTERRUPT_PIN ( INTERRUPT_PIN ),
  .IS_SWITCH ( IS_SWITCH ),
  .LAST_CONFIG_DWORD ( LAST_CONFIG_DWORD ),
  .LINK_CAP_ASPM_SUPPORT ( LINK_CAP_ASPM_SUPPORT ),
  .LINK_CAP_CLOCK_POWER_MANAGEMENT ( LINK_CAP_CLOCK_POWER_MANAGEMENT ),
  .LINK_CAP_DLL_LINK_ACTIVE_REPORTING_CAP ( LINK_CAP_DLL_LINK_ACTIVE_REPORTING_CAP ),
  .LINK_CAP_LINK_BANDWIDTH_NOTIFICATION_CAP ( LP_LINK_CAP_LINK_BANDWIDTH_NOTIFICATION_CAP ),
  .LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN1 ( LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN1 ),
  .LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN2 ( LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN2 ),
  .LINK_CAP_L0S_EXIT_LATENCY_GEN1 ( LINK_CAP_L0S_EXIT_LATENCY_GEN1 ),
  .LINK_CAP_L0S_EXIT_LATENCY_GEN2 ( LINK_CAP_L0S_EXIT_LATENCY_GEN2 ),
  .LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN1 ( LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN1 ),
  .LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN2 ( LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN2 ),
  .LINK_CAP_L1_EXIT_LATENCY_GEN1 ( LINK_CAP_L1_EXIT_LATENCY_GEN1 ),
  .LINK_CAP_L1_EXIT_LATENCY_GEN2 ( LINK_CAP_L1_EXIT_LATENCY_GEN2 ),
  .LINK_CAP_MAX_LINK_SPEED ( LINK_CAP_MAX_LINK_SPEED ),
  .LINK_CAP_MAX_LINK_WIDTH ( LINK_CAP_MAX_LINK_WIDTH ),
  .LINK_CAP_RSVD_23_22 ( LINK_CAP_RSVD_23_22 ),
  .LINK_CAP_SURPRISE_DOWN_ERROR_CAPABLE ( LINK_CAP_SURPRISE_DOWN_ERROR_CAPABLE ),
  .LINK_CONTROL_RCB ( LINK_CONTROL_RCB ),
  .LINK_CTRL2_DEEMPHASIS ( LINK_CTRL2_DEEMPHASIS ),
  .LINK_CTRL2_HW_AUTONOMOUS_SPEED_DISABLE ( LINK_CTRL2_HW_AUTONOMOUS_SPEED_DISABLE ),
  .LINK_CTRL2_TARGET_LINK_SPEED ( LINK_CTRL2_TARGET_LINK_SPEED ),
  .LINK_STATUS_SLOT_CLOCK_CONFIG ( LINK_STATUS_SLOT_CLOCK_CONFIG ),
  .LL_ACK_TIMEOUT ( LL_ACK_TIMEOUT ),
  .LL_ACK_TIMEOUT_EN ( LL_ACK_TIMEOUT_EN ),
  .LL_ACK_TIMEOUT_FUNC ( LL_ACK_TIMEOUT_FUNC ),
  .LL_REPLAY_TIMEOUT ( LL_REPLAY_TIMEOUT ),
  .LL_REPLAY_TIMEOUT_EN ( LL_REPLAY_TIMEOUT_EN ),
  .LL_REPLAY_TIMEOUT_FUNC ( LL_REPLAY_TIMEOUT_FUNC ),
  .LTSSM_MAX_LINK_WIDTH ( LTSSM_MAX_LINK_WIDTH ),
  .MSI_BASE_PTR ( MSI_BASE_PTR ),
  .MSI_CAP_ID ( MSI_CAP_ID ),
  .MSI_CAP_MULTIMSGCAP ( MSI_CAP_MULTIMSGCAP ),
  .MSI_CAP_MULTIMSG_EXTENSION ( MSI_CAP_MULTIMSG_EXTENSION ),
  .MSI_CAP_NEXTPTR ( MSI_CAP_NEXTPTR ),
  .MSI_CAP_ON ( MSI_CAP_ON ),
  .MSI_CAP_PER_VECTOR_MASKING_CAPABLE ( MSI_CAP_PER_VECTOR_MASKING_CAPABLE ),
  .MSI_CAP_64_BIT_ADDR_CAPABLE ( MSI_CAP_64_BIT_ADDR_CAPABLE ),
  .MSIX_BASE_PTR ( MSIX_BASE_PTR ),
  .MSIX_CAP_ID ( MSIX_CAP_ID ),
  .MSIX_CAP_NEXTPTR ( MSIX_CAP_NEXTPTR ),
  .MSIX_CAP_ON ( MSIX_CAP_ON ),
  .MSIX_CAP_PBA_BIR ( MSIX_CAP_PBA_BIR ),
  .MSIX_CAP_PBA_OFFSET ( MSIX_CAP_PBA_OFFSET ),
  .MSIX_CAP_TABLE_BIR ( MSIX_CAP_TABLE_BIR ),
  .MSIX_CAP_TABLE_OFFSET ( MSIX_CAP_TABLE_OFFSET ),
  .MSIX_CAP_TABLE_SIZE ( MSIX_CAP_TABLE_SIZE ),
  .N_FTS_COMCLK_GEN1 ( N_FTS_COMCLK_GEN1 ),
  .N_FTS_COMCLK_GEN2 ( N_FTS_COMCLK_GEN2 ),
  .N_FTS_GEN1 ( N_FTS_GEN1 ),
  .N_FTS_GEN2 ( N_FTS_GEN2 ),
  .PCIE_BASE_PTR ( PCIE_BASE_PTR ),
  .PCIE_CAP_CAPABILITY_ID ( PCIE_CAP_CAPABILITY_ID ),
  .PCIE_CAP_CAPABILITY_VERSION ( PCIE_CAP_CAPABILITY_VERSION ),
  .PCIE_CAP_DEVICE_PORT_TYPE ( PCIE_CAP_DEVICE_PORT_TYPE ),
  .PCIE_CAP_INT_MSG_NUM ( PCIE_CAP_INT_MSG_NUM ),
  .PCIE_CAP_NEXTPTR ( PCIE_CAP_NEXTPTR ),
  .PCIE_CAP_ON ( PCIE_CAP_ON ),
  .PCIE_CAP_RSVD_15_14 ( PCIE_CAP_RSVD_15_14 ),
  .PCIE_CAP_SLOT_IMPLEMENTED ( PCIE_CAP_SLOT_IMPLEMENTED ),
  .PCIE_REVISION ( PCIE_REVISION ),
  .PGL0_LANE ( PGL0_LANE ),
  .PGL1_LANE ( PGL1_LANE ),
  .PGL2_LANE ( PGL2_LANE ),
  .PGL3_LANE ( PGL3_LANE ),
  .PGL4_LANE ( PGL4_LANE ),
  .PGL5_LANE ( PGL5_LANE ),
  .PGL6_LANE ( PGL6_LANE ),
  .PGL7_LANE ( PGL7_LANE ),
  .PL_AUTO_CONFIG ( PL_AUTO_CONFIG ),
  .PL_FAST_TRAIN ( PL_FAST_TRAIN ),
  .PM_BASE_PTR ( PM_BASE_PTR ),
  .PM_CAP_AUXCURRENT ( PM_CAP_AUXCURRENT ),
  .PM_CAP_DSI ( PM_CAP_DSI ),
  .PM_CAP_D1SUPPORT ( PM_CAP_D1SUPPORT ),
  .PM_CAP_D2SUPPORT ( PM_CAP_D2SUPPORT ),
  .PM_CAP_ID ( PM_CAP_ID ),
  .PM_CAP_NEXTPTR ( PM_CAP_NEXTPTR ),
  .PM_CAP_ON ( PM_CAP_ON ),
  .PM_CAP_PME_CLOCK ( PM_CAP_PME_CLOCK ),
  .PM_CAP_PMESUPPORT ( PM_CAP_PMESUPPORT ),
  .PM_CAP_RSVD_04 ( PM_CAP_RSVD_04 ),
  .PM_CAP_VERSION ( PM_CAP_VERSION ),
  .PM_CSR_BPCCEN ( PM_CSR_BPCCEN ),
  .PM_CSR_B2B3 ( PM_CSR_B2B3 ),
  .PM_CSR_NOSOFTRST ( PM_CSR_NOSOFTRST ),
  .PM_DATA_SCALE0 ( PM_DATA_SCALE0 ),
  .PM_DATA_SCALE1 ( PM_DATA_SCALE1 ),
  .PM_DATA_SCALE2 ( PM_DATA_SCALE2 ),
  .PM_DATA_SCALE3 ( PM_DATA_SCALE3 ),
  .PM_DATA_SCALE4 ( PM_DATA_SCALE4 ),
  .PM_DATA_SCALE5 ( PM_DATA_SCALE5 ),
  .PM_DATA_SCALE6 ( PM_DATA_SCALE6 ),
  .PM_DATA_SCALE7 ( PM_DATA_SCALE7 ),
  .PM_DATA0 ( PM_DATA0 ),
  .PM_DATA1 ( PM_DATA1 ),
  .PM_DATA2 ( PM_DATA2 ),
  .PM_DATA3 ( PM_DATA3 ),
  .PM_DATA4 ( PM_DATA4 ),
  .PM_DATA5 ( PM_DATA5 ),
  .PM_DATA6 ( PM_DATA6 ),
  .PM_DATA7 ( PM_DATA7 ),
  .RECRC_CHK ( RECRC_CHK ),
  .RECRC_CHK_TRIM ( RECRC_CHK_TRIM ),
  .REVISION_ID ( REVISION_ID ),
  .ROOT_CAP_CRS_SW_VISIBILITY ( ROOT_CAP_CRS_SW_VISIBILITY ),
  .SELECT_DLL_IF ( SELECT_DLL_IF ),
  .SLOT_CAP_ATT_BUTTON_PRESENT ( SLOT_CAP_ATT_BUTTON_PRESENT ),
  .SLOT_CAP_ATT_INDICATOR_PRESENT ( SLOT_CAP_ATT_INDICATOR_PRESENT ),
  .SLOT_CAP_ELEC_INTERLOCK_PRESENT ( SLOT_CAP_ELEC_INTERLOCK_PRESENT ),
  .SLOT_CAP_HOTPLUG_CAPABLE ( SLOT_CAP_HOTPLUG_CAPABLE ),
  .SLOT_CAP_HOTPLUG_SURPRISE ( SLOT_CAP_HOTPLUG_SURPRISE ),
  .SLOT_CAP_MRL_SENSOR_PRESENT ( SLOT_CAP_MRL_SENSOR_PRESENT ),
  .SLOT_CAP_NO_CMD_COMPLETED_SUPPORT ( SLOT_CAP_NO_CMD_COMPLETED_SUPPORT ),
  .SLOT_CAP_PHYSICAL_SLOT_NUM ( SLOT_CAP_PHYSICAL_SLOT_NUM ),
  .SLOT_CAP_POWER_CONTROLLER_PRESENT ( SLOT_CAP_POWER_CONTROLLER_PRESENT ),
  .SLOT_CAP_POWER_INDICATOR_PRESENT ( SLOT_CAP_POWER_INDICATOR_PRESENT ),
  .SLOT_CAP_SLOT_POWER_LIMIT_SCALE ( SLOT_CAP_SLOT_POWER_LIMIT_SCALE ),
  .SLOT_CAP_SLOT_POWER_LIMIT_VALUE ( SLOT_CAP_SLOT_POWER_LIMIT_VALUE ),
  .SPARE_BIT0 ( SPARE_BIT0 ),
  .SPARE_BIT1 ( SPARE_BIT1 ),
  .SPARE_BIT2 ( SPARE_BIT2 ),
  .SPARE_BIT3 ( SPARE_BIT3 ),
  .SPARE_BIT4 ( SPARE_BIT4 ),
  .SPARE_BIT5 ( SPARE_BIT5 ),
  .SPARE_BIT6 ( SPARE_BIT6 ),
  .SPARE_BIT7 ( SPARE_BIT7 ),
  .SPARE_BIT8 ( SPARE_BIT8 ),
  .SPARE_BYTE0 ( SPARE_BYTE0 ),
  .SPARE_BYTE1 ( SPARE_BYTE1 ),
  .SPARE_BYTE2 ( SPARE_BYTE2 ),
  .SPARE_BYTE3 ( SPARE_BYTE3 ),
  .SPARE_WORD0 ( SPARE_WORD0 ),
  .SPARE_WORD1 ( SPARE_WORD1 ),
  .SPARE_WORD2 ( SPARE_WORD2 ),
  .SPARE_WORD3 ( SPARE_WORD3 ),
  .SUBSYSTEM_ID ( SUBSYSTEM_ID ),
  .SUBSYSTEM_VENDOR_ID ( SUBSYSTEM_VENDOR_ID ),
  .TL_RBYPASS ( TL_RBYPASS ),
  .TL_RX_RAM_RADDR_LATENCY ( TL_RX_RAM_RADDR_LATENCY ),
  .TL_RX_RAM_RDATA_LATENCY ( TL_RX_RAM_RDATA_LATENCY ),
  .TL_RX_RAM_WRITE_LATENCY ( TL_RX_RAM_WRITE_LATENCY ),
  .TL_TFC_DISABLE ( TL_TFC_DISABLE ),
  .TL_TX_CHECKS_DISABLE ( TL_TX_CHECKS_DISABLE ),
  .TL_TX_RAM_RADDR_LATENCY ( TL_TX_RAM_RADDR_LATENCY ),
  .TL_TX_RAM_RDATA_LATENCY ( TL_TX_RAM_RDATA_LATENCY ),
  .TL_TX_RAM_WRITE_LATENCY ( TL_TX_RAM_WRITE_LATENCY ),
  .UPCONFIG_CAPABLE ( UPCONFIG_CAPABLE ),
  .UPSTREAM_FACING ( UPSTREAM_FACING ),
  .EXIT_LOOPBACK_ON_EI ( EXIT_LOOPBACK_ON_EI ),
  .UR_INV_REQ ( UR_INV_REQ ),
  .USER_CLK_FREQ ( USER_CLK_FREQ ),
  .VC_BASE_PTR ( VC_BASE_PTR ),
  .VC_CAP_ID ( VC_CAP_ID ),
  .VC_CAP_NEXTPTR ( VC_CAP_NEXTPTR ),
  .VC_CAP_ON ( VC_CAP_ON ),
  .VC_CAP_REJECT_SNOOP_TRANSACTIONS ( VC_CAP_REJECT_SNOOP_TRANSACTIONS ),
  .VC_CAP_VERSION ( VC_CAP_VERSION ),
  .VC0_CPL_INFINITE ( VC0_CPL_INFINITE ),
  .VC0_RX_RAM_LIMIT ( VC0_RX_RAM_LIMIT ),
  .VC0_TOTAL_CREDITS_CD ( VC0_TOTAL_CREDITS_CD ),
  .VC0_TOTAL_CREDITS_CH ( VC0_TOTAL_CREDITS_CH ),
  .VC0_TOTAL_CREDITS_NPH ( VC0_TOTAL_CREDITS_NPH ),
  .VC0_TOTAL_CREDITS_PD ( VC0_TOTAL_CREDITS_PD ),
  .VC0_TOTAL_CREDITS_PH ( VC0_TOTAL_CREDITS_PH ),
  .VC0_TX_LASTPACKET ( VC0_TX_LASTPACKET ),
  .VENDOR_ID ( VENDOR_ID ),
  .VSEC_BASE_PTR ( VSEC_BASE_PTR ),
  .VSEC_CAP_HDR_ID ( VSEC_CAP_HDR_ID ),
  .VSEC_CAP_HDR_LENGTH ( VSEC_CAP_HDR_LENGTH ),
  .VSEC_CAP_HDR_REVISION ( VSEC_CAP_HDR_REVISION ),
  .VSEC_CAP_ID ( VSEC_CAP_ID ),
  .VSEC_CAP_IS_LINK_VISIBLE ( VSEC_CAP_IS_LINK_VISIBLE ),
  .VSEC_CAP_NEXTPTR ( VSEC_CAP_NEXTPTR ),
  .VSEC_CAP_ON ( VSEC_CAP_ON ),
  .VSEC_CAP_VERSION ( VSEC_CAP_VERSION )

)
pcie_2_0_i (

  .PCIEXPRXN( pci_exp_rxn ),
  .PCIEXPRXP( pci_exp_rxp ),
  .PCIEXPTXN( pci_exp_txn ),
  .PCIEXPTXP( pci_exp_txp ),

  .SYSCLK( sys_clk ),
  .TRNLNKUPN( trn_lnk_up_n_int ),
  .TRNCLK( trn_clk ),

  .FUNDRSTN (sys_reset_n_d),
  .PHYRDYN( phy_rdy_n ),

  .LNKCLKEN ( ),
  .USERRSTN( trn_reset_n_int ),
  .RECEIVEDFUNCLVLRSTN( rx_func_level_reset_n ),
  .SYSRSTN( ~phy_rdy_n ),
  .PLRSTN( 1'b1 ),
  .DLRSTN( 1'b1 ),
  .TLRSTN( 1'b1 ),
  .FUNCLVLRSTN( (DS_PORT_HOT_RST == "TRUE") ? ~pl_transmit_hot_rst : 1'b1 ),
  .CMRSTN( (DS_PORT_HOT_RST == "TRUE") ? ~pl_transmit_hot_rst : 1'b1 ),
  .CMSTICKYRSTN( 1'b1 ),

  .TRNRBARHITN( trn_rbar_hit_n ),
  .TRNRD( trn_rd ),
  .TRNRECRCERRN( trn_recrc_err_n ),
  .TRNREOFN( trn_reof_n ),
  .TRNRERRFWDN( trn_rerrfwd_n ),
  .TRNRREMN( trn_rrem_n ),
  .TRNRSOFN( trn_rsof_n ),
  .TRNRSRCDSCN( trn_rsrc_dsc_n ),
  .TRNRSRCRDYN( trn_rsrc_rdy_n ),
  .TRNRDSTRDYN( trn_rdst_rdy_n ),
  .TRNRNPOKN( trn_rnp_ok_n ),

  .TRNTBUFAV( trn_tbuf_av ),
  .TRNTCFGREQN( trn_tcfg_req_n ),
  .TRNTDLLPDSTRDYN( ),
  .TRNTDSTRDYN( trn_tdst_rdy_n ),
  .TRNTERRDROPN( trn_terr_drop_n ),
  .TRNTCFGGNTN( trn_tcfg_gnt_n ),
  .TRNTD( trn_td ),
  .TRNTDLLPDATA( 32'b0 ),
  .TRNTDLLPSRCRDYN( 1'b1 ),
  .TRNTECRCGENN( 1'b1 ),
  .TRNTEOFN( trn_teof_n ),
  .TRNTERRFWDN( trn_terrfwd_n ),
  .TRNTREMN( trn_trem_n ),
  .TRNTSOFN( trn_tsof_n ),
  .TRNTSRCDSCN( trn_tsrc_dsc_n ),
  .TRNTSRCRDYN( trn_tsrc_rdy_n ),
  .TRNTSTRN( trn_tstr_n ),

  .TRNFCCPLD( trn_fc_cpld ),
  .TRNFCCPLH( trn_fc_cplh ),
  .TRNFCNPD( trn_fc_npd ),
  .TRNFCNPH( trn_fc_nph ),
  .TRNFCPD( trn_fc_pd ),
  .TRNFCPH( trn_fc_ph ),
  .TRNFCSEL( trn_fc_sel ),

  .CFGAERECRCCHECKEN(),
  .CFGAERECRCGENEN(),
  .CFGCOMMANDBUSMASTERENABLE( cfg_cmd_bme ),
  .CFGCOMMANDINTERRUPTDISABLE( cfg_cmd_intdis ),
  .CFGCOMMANDIOENABLE( cfg_cmd_io_en ),
  .CFGCOMMANDMEMENABLE( cfg_cmd_mem_en ),
  .CFGCOMMANDSERREN( cfg_cmd_serr_en ),
  .CFGDEVCONTROLAUXPOWEREN( cfg_dev_control_aux_power_en ),
  .CFGDEVCONTROLCORRERRREPORTINGEN( cfg_dev_control_corr_err_reporting_en ),
  .CFGDEVCONTROLENABLERO( cfg_dev_control_enable_relaxed_order ),
  .CFGDEVCONTROLEXTTAGEN( cfg_dev_control_ext_tag_en ),
  .CFGDEVCONTROLFATALERRREPORTINGEN( cfg_dev_control_fatal_err_reporting_en ),
  .CFGDEVCONTROLMAXPAYLOAD( cfg_dev_control_maxpayload ),
  .CFGDEVCONTROLMAXREADREQ( cfg_dev_control_max_read_req ),
  .CFGDEVCONTROLNONFATALREPORTINGEN( cfg_dev_control_non_fatal_reporting_en ),
  .CFGDEVCONTROLNOSNOOPEN( cfg_dev_control_nosnoop_en ),
  .CFGDEVCONTROLPHANTOMEN( cfg_dev_control_phantom_en ),
  .CFGDEVCONTROLURERRREPORTINGEN( cfg_dev_control_ur_err_reporting_en ),
  .CFGDEVCONTROL2CPLTIMEOUTDIS( cfg_dev_control2_cpltimeout_dis ),
  .CFGDEVCONTROL2CPLTIMEOUTVAL( cfg_dev_control2_cpltimeout_val ),
  .CFGDEVSTATUSCORRERRDETECTED( cfg_dev_status_corr_err_detected ),
  .CFGDEVSTATUSFATALERRDETECTED( cfg_dev_status_fatal_err_detected ),
  .CFGDEVSTATUSNONFATALERRDETECTED( cfg_dev_status_nonfatal_err_detected ),
  .CFGDEVSTATUSURDETECTED( cfg_dev_status_ur_detected ),
  .CFGDO( cfg_do ),
  .CFGERRAERHEADERLOGSETN(),
  .CFGERRCPLRDYN( cfg_err_cpl_rdy_n ),
  .CFGINTERRUPTDO( cfg_interrupt_do ),
  .CFGINTERRUPTMMENABLE( cfg_interrupt_mmenable ),
  .CFGINTERRUPTMSIENABLE( cfg_interrupt_msienable ),
  .CFGINTERRUPTMSIXENABLE( cfg_interrupt_msixenable ),
  .CFGINTERRUPTMSIXFM( cfg_interrupt_msixfm ),
  .CFGINTERRUPTRDYN( cfg_interrupt_rdy_n ),
  .CFGLINKCONTROLRCB( cfg_link_control_rcb ),
  .CFGLINKCONTROLASPMCONTROL( cfg_link_control_aspm_control ),
  .CFGLINKCONTROLAUTOBANDWIDTHINTEN( cfg_link_control_auto_bandwidth_int_en ),
  .CFGLINKCONTROLBANDWIDTHINTEN( cfg_link_control_bandwidth_int_en ),
  .CFGLINKCONTROLCLOCKPMEN( cfg_link_control_clock_pm_en ),
  .CFGLINKCONTROLCOMMONCLOCK( cfg_link_control_common_clock ),
  .CFGLINKCONTROLEXTENDEDSYNC( cfg_link_control_extended_sync ),
  .CFGLINKCONTROLHWAUTOWIDTHDIS( cfg_link_control_hw_auto_width_dis ),
  .CFGLINKCONTROLLINKDISABLE( cfg_link_control_linkdisable ),
  .CFGLINKCONTROLRETRAINLINK( cfg_link_control_retrain_link ),
  .CFGLINKSTATUSAUTOBANDWIDTHSTATUS( cfg_link_status_auto_bandwidth_status ),
  .CFGLINKSTATUSBANDWITHSTATUS( cfg_link_status_bandwidth_status ),
  .CFGLINKSTATUSCURRENTSPEED( cfg_link_status_current_speed ),
  .CFGLINKSTATUSDLLACTIVE( cfg_link_status_dll_active ),
  .CFGLINKSTATUSLINKTRAINING( cfg_link_status_link_training ),
  .CFGLINKSTATUSNEGOTIATEDWIDTH( cfg_link_status_negotiated_link_width ),
  .CFGMSGDATA( cfg_msg_data ),
  .CFGMSGRECEIVED( cfg_msg_received ),
  .CFGMSGRECEIVEDASSERTINTA( cfg_msg_received_assert_inta ),
  .CFGMSGRECEIVEDASSERTINTB( cfg_msg_received_assert_intb ),
  .CFGMSGRECEIVEDASSERTINTC( cfg_msg_received_assert_intc ),
  .CFGMSGRECEIVEDASSERTINTD( cfg_msg_received_assert_intd ),
  .CFGMSGRECEIVEDDEASSERTINTA( cfg_msg_received_deassert_inta ),
  .CFGMSGRECEIVEDDEASSERTINTB( cfg_msg_received_deassert_intb ),
  .CFGMSGRECEIVEDDEASSERTINTC( cfg_msg_received_deassert_intc ),
  .CFGMSGRECEIVEDDEASSERTINTD( cfg_msg_received_deassert_intd ),
  .CFGMSGRECEIVEDERRCOR(cfg_msg_received_err_cor),
  .CFGMSGRECEIVEDERRFATAL(cfg_msg_received_err_fatal),
  .CFGMSGRECEIVEDERRNONFATAL(cfg_msg_received_err_non_fatal),
  .CFGMSGRECEIVEDPMASNAK(),
  .CFGMSGRECEIVEDPMETO( ),
  .CFGMSGRECEIVEDPMETOACK(cfg_msg_received_pme_to_ack),
  .CFGMSGRECEIVEDPMPME(),
  .CFGMSGRECEIVEDSETSLOTPOWERLIMIT(),
  .CFGMSGRECEIVEDUNLOCK(),
  .CFGPCIELINKSTATE( cfg_pcie_link_state_n ),
  .CFGPMRCVASREQL1N(),
  .CFGPMRCVENTERL1N(),
  .CFGPMRCVENTERL23N(),
  .CFGPMRCVREQACKN(),
  .CFGPMCSRPMEEN ( cfg_pmcsr_pme_en ),
  .CFGPMCSRPMESTATUS ( cfg_pmcsr_pme_status ),
  .CFGPMCSRPOWERSTATE ( cfg_pmcsr_powerstate ),
  .CFGRDWRDONEN( cfg_rd_wr_done_n ),
  .CFGSLOTCONTROLELECTROMECHILCTLPULSE(),
  .CFGTRANSACTION(),
  .CFGTRANSACTIONADDR(),
  .CFGTRANSACTIONTYPE(),
  .CFGVCTCVCMAP(),
  .CFGBYTEENN( cfg_byte_en_n ),
  .CFGDI( cfg_di ),
  .CFGDSBUSNUMBER( cfg_ds_bus_number),
  .CFGDSDEVICENUMBER( cfg_ds_device_number ),
  .CFGDSFUNCTIONNUMBER( 3'b000 ),
  .CFGDSN( cfg_dsn ),
  .CFGDWADDR( cfg_dwaddr ),
  .CFGERRACSN( 1'b1 ),
  .CFGERRAERHEADERLOG( 128'h0 ),
  .CFGERRCORN( cfg_err_cor_n ),
  .CFGERRCPLABORTN( cfg_err_cpl_abort_n ),
  .CFGERRCPLTIMEOUTN( cfg_err_cpl_timeout_n ),
  .CFGERRCPLUNEXPECTN( cfg_err_cpl_unexpect_n ),
  .CFGERRECRCN( cfg_err_ecrc_n ),
  .CFGERRLOCKEDN( cfg_err_locked_n ),
  .CFGERRPOSTEDN( cfg_err_posted_n ),
  .CFGERRTLPCPLHEADER( cfg_err_tlp_cpl_header ),
  .CFGERRURN( cfg_err_ur_n ),
  .CFGINTERRUPTASSERTN( cfg_interrupt_assert_n ),
  .CFGINTERRUPTDI( cfg_interrupt_di ),
  .CFGINTERRUPTN( cfg_interrupt_n ),
  .CFGPMDIRECTASPML1N( 1'b1 ),
  .CFGPMSENDPMACKN( 1'b1 ),
  .CFGPMSENDPMETON( cfg_pm_send_pme_to_n ),
  .CFGPMSENDPMNAKN( 1'b1 ),
  .CFGPMTURNOFFOKN( 1'b1 ),
  .CFGPMWAKEN( ),
  .CFGPORTNUMBER( 8'h0 ),
  .CFGRDENN( cfg_rd_en_n ),
  .CFGTRNPENDINGN( cfg_trn_pending_n ),
  .CFGWRENN( cfg_wr_en_n ),
  .CFGWRREADONLYN( 1'b1 ),
  .CFGWRRW1CASRWN( 1'b1 ),

  .PLINITIALLINKWIDTH( pl_initial_link_width ),
  .PLLANEREVERSALMODE( pl_lane_reversal_mode ),
  .PLLINKGEN2CAP( pl_link_gen2_capable ),
  .PLLINKPARTNERGEN2SUPPORTED( pl_link_partner_gen2_supported ),
  .PLLINKUPCFGCAP( pl_link_upcfg_capable ),
  .PLLTSSMSTATE( pl_ltssm_state ),
  .PLPHYLNKUPN( pl_phy_lnk_up_n ),                            // Debug
  .PLRECEIVEDHOTRST( ),
  .PLRXPMSTATE(),                                             // Debug
  .PLSELLNKRATE( pl_sel_link_rate ),
  .PLSELLNKWIDTH( pl_sel_link_width ),
  .PLTXPMSTATE(),                                             // Debug
  .PLDIRECTEDLINKAUTON( pl_directed_link_auton ),
  .PLDIRECTEDLINKCHANGE( pl_directed_link_change ),
  .PLDIRECTEDLINKSPEED( pl_directed_link_speed ),
  .PLDIRECTEDLINKWIDTH( pl_directed_link_width ),
  .PLDOWNSTREAMDEEMPHSOURCE( 1'b1 ),
  .PLUPSTREAMPREFERDEEMPH( pl_upstream_prefer_deemph ),
  .PLTRANSMITHOTRST( pl_transmit_hot_rst ),

  .DBGSCLRA(),
  .DBGSCLRB(),
  .DBGSCLRC(),
  .DBGSCLRD(),
  .DBGSCLRE(),
  .DBGSCLRF(),
  .DBGSCLRG(),
  .DBGSCLRH(),
  .DBGSCLRI(),
  .DBGSCLRJ(),
  .DBGSCLRK(),
  .DBGVECA(),
  .DBGVECB(),
  .DBGVECC(),
  .PLDBGVEC(),
  .DBGMODE( 2'b0 ),
  .DBGSUBMODE( 1'b0 ),
  .PLDBGMODE( 3'b0 ),

  .PCIEDRPDO( pcie_drp_do ),
  .PCIEDRPDRDY( pcie_drp_drdy ),
  .PCIEDRPCLK( pcie_drp_clk ),
  .PCIEDRPDADDR( pcie_drp_daddr ),
  .PCIEDRPDEN( pcie_drp_den ),
  .PCIEDRPDI( pcie_drp_di ),
  .PCIEDRPDWE( pcie_drp_dwe ),

  .GTPLLLOCK( gt_pll_lock ),
  .PIPECLK( pipe_clk ),
  .USERCLK( user_clk ),
  .DRPCLK( drp_clk ),
  .CLOCKLOCKED( clock_locked ),
  .TxOutClk(TxOutClk)

);

endmodule


module pcie_2_0_v6_rp #(
    parameter        REF_CLK_FREQ = 0,                        // 0 - 100 MHz, 1 - 125 MHz, 2 - 250 MHz
    parameter        PIPE_PIPELINE_STAGES = 0,                // 0 - 0 stages, 1 - 1 stage, 2 - 2 stages
    parameter        AER_BASE_PTR = 12'h128,
    parameter        AER_CAP_ECRC_CHECK_CAPABLE = "FALSE",
    parameter        AER_CAP_ECRC_GEN_CAPABLE = "FALSE",
    parameter        AER_CAP_ID = 16'h0001,
    parameter        AER_CAP_INT_MSG_NUM_MSI = 5'h0a,
    parameter        AER_CAP_INT_MSG_NUM_MSIX = 5'h15,
    parameter        AER_CAP_NEXTPTR = 12'h160,
    parameter        AER_CAP_ON = "FALSE",
    parameter        AER_CAP_PERMIT_ROOTERR_UPDATE = "TRUE",
    parameter        AER_CAP_VERSION = 4'h1,
    parameter        ALLOW_X8_GEN2 = "FALSE",
    parameter        BAR0 = 32'hffffff00,
    parameter        BAR1 = 32'hffff0000,
    parameter        BAR2 = 32'hffff000c,
    parameter        BAR3 = 32'hffffffff,
    parameter        BAR4 = 32'h00000000,
    parameter        BAR5 = 32'h00000000,
    parameter        CAPABILITIES_PTR = 8'h40,
    parameter        CARDBUS_CIS_POINTER = 32'h00000000,
    parameter        CLASS_CODE = 24'h000000,
    parameter        CMD_INTX_IMPLEMENTED = "TRUE",
    parameter        CPL_TIMEOUT_DISABLE_SUPPORTED = "FALSE",
    parameter        CPL_TIMEOUT_RANGES_SUPPORTED = 4'h0,
    parameter        CRM_MODULE_RSTS = 7'h00,
    parameter        DEV_CAP_ENABLE_SLOT_PWR_LIMIT_SCALE = "TRUE",
    parameter        DEV_CAP_ENABLE_SLOT_PWR_LIMIT_VALUE = "TRUE",
    parameter        DEV_CAP_ENDPOINT_L0S_LATENCY = 0,
    parameter        DEV_CAP_ENDPOINT_L1_LATENCY = 0,
    parameter        DEV_CAP_EXT_TAG_SUPPORTED = "TRUE",
    parameter        DEV_CAP_FUNCTION_LEVEL_RESET_CAPABLE = "FALSE",
    parameter        DEV_CAP_MAX_PAYLOAD_SUPPORTED = 2,
    parameter        DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT = 0,
    parameter        DEV_CAP_ROLE_BASED_ERROR = "TRUE",
    parameter        DEV_CAP_RSVD_14_12 = 0,
    parameter        DEV_CAP_RSVD_17_16 = 0,
    parameter        DEV_CAP_RSVD_31_29 = 0,
    parameter        DEV_CONTROL_AUX_POWER_SUPPORTED = "FALSE",
    parameter        DEVICE_ID = 16'h0007,
    parameter        DISABLE_ASPM_L1_TIMER = "FALSE",
    parameter        DISABLE_BAR_FILTERING = "FALSE",
    parameter        DISABLE_ID_CHECK = "FALSE",
    parameter        DISABLE_LANE_REVERSAL = "FALSE",
    parameter        DISABLE_RX_TC_FILTER = "FALSE",
    parameter        DISABLE_SCRAMBLING = "FALSE",
    parameter        DNSTREAM_LINK_NUM = 8'h00,
    parameter        DSN_BASE_PTR = 12'h100,
    parameter        DSN_CAP_ID = 16'h0003,
    parameter        DSN_CAP_NEXTPTR = 12'h000,
    parameter        DSN_CAP_ON = "TRUE",
    parameter        DSN_CAP_VERSION = 4'h1,
    parameter        ENABLE_MSG_ROUTE = 11'h000,
    parameter        ENABLE_RX_TD_ECRC_TRIM = "FALSE",
    parameter        ENTER_RVRY_EI_L0 = "TRUE",
    parameter        EXPANSION_ROM = 32'hfffff001,
    parameter        EXT_CFG_CAP_PTR = 6'h3f,
    parameter        EXT_CFG_XP_CAP_PTR = 10'h3ff,
    parameter        HEADER_TYPE = 8'h00,
    parameter        INFER_EI = 5'h00,
    parameter        INTERRUPT_PIN = 8'h01,
    parameter        IS_SWITCH = "FALSE",
    parameter        LAST_CONFIG_DWORD = 10'h042,
    parameter        LINK_CAP_ASPM_SUPPORT = 1,
    parameter        LINK_CAP_CLOCK_POWER_MANAGEMENT = "FALSE",
    parameter        LINK_CAP_DLL_LINK_ACTIVE_REPORTING_CAP = "FALSE",
    parameter        LINK_CAP_LINK_BANDWIDTH_NOTIFICATION_CAP = "FALSE",
    parameter        LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN1 = 7,
    parameter        LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN2 = 7,
    parameter        LINK_CAP_L0S_EXIT_LATENCY_GEN1 = 7,
    parameter        LINK_CAP_L0S_EXIT_LATENCY_GEN2 = 7,
    parameter        LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN1 = 7,
    parameter        LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN2 = 7,
    parameter        LINK_CAP_L1_EXIT_LATENCY_GEN1 = 7,
    parameter        LINK_CAP_L1_EXIT_LATENCY_GEN2 = 7,
    parameter        LINK_CAP_MAX_LINK_SPEED = 4'h1,
    parameter        LINK_CAP_MAX_LINK_WIDTH = 6'h08,
    parameter        LINK_CAP_RSVD_23_22 = 0,
    parameter        LINK_CAP_SURPRISE_DOWN_ERROR_CAPABLE = "FALSE",
    parameter        LINK_CONTROL_RCB = 0,
    parameter        LINK_CTRL2_DEEMPHASIS = "FALSE",
    parameter        LINK_CTRL2_HW_AUTONOMOUS_SPEED_DISABLE = "FALSE",
    parameter        LINK_CTRL2_TARGET_LINK_SPEED = 4'h0,
    parameter        LINK_STATUS_SLOT_CLOCK_CONFIG = "TRUE",
    parameter        LL_ACK_TIMEOUT = 15'h0204,
    parameter        LL_ACK_TIMEOUT_EN = "FALSE",
    parameter        LL_ACK_TIMEOUT_FUNC = 0,
    parameter        LL_REPLAY_TIMEOUT = 15'h060d,
    parameter        LL_REPLAY_TIMEOUT_EN = "FALSE",
    parameter        LL_REPLAY_TIMEOUT_FUNC = 0,
    parameter        LTSSM_MAX_LINK_WIDTH = LINK_CAP_MAX_LINK_WIDTH,
    parameter        MSI_BASE_PTR = 8'h48,
    parameter        MSI_CAP_ID = 8'h05,
    parameter        MSI_CAP_MULTIMSGCAP = 0,
    parameter        MSI_CAP_MULTIMSG_EXTENSION = 0,
    parameter        MSI_CAP_NEXTPTR = 8'h60,
    parameter        MSI_CAP_ON = "FALSE",
    parameter        MSI_CAP_PER_VECTOR_MASKING_CAPABLE = "TRUE",
    parameter        MSI_CAP_64_BIT_ADDR_CAPABLE = "TRUE",
    parameter        MSIX_BASE_PTR = 8'h9c,
    parameter        MSIX_CAP_ID = 8'h11,
    parameter        MSIX_CAP_NEXTPTR = 8'h00,
    parameter        MSIX_CAP_ON = "FALSE",
    parameter        MSIX_CAP_PBA_BIR = 0,
    parameter        MSIX_CAP_PBA_OFFSET = 29'h00000050,
    parameter        MSIX_CAP_TABLE_BIR = 0,
    parameter        MSIX_CAP_TABLE_OFFSET = 29'h00000040,
    parameter        MSIX_CAP_TABLE_SIZE = 11'h000,
    parameter        N_FTS_COMCLK_GEN1 = 255,
    parameter        N_FTS_COMCLK_GEN2 = 255,
    parameter        N_FTS_GEN1 = 255,
    parameter        N_FTS_GEN2 = 255,
    parameter        PCIE_BASE_PTR = 8'h60,
    parameter        PCIE_CAP_CAPABILITY_ID = 8'h10,
    parameter        PCIE_CAP_CAPABILITY_VERSION = 4'h2,
    parameter        PCIE_CAP_DEVICE_PORT_TYPE = 4'h0,
    parameter        PCIE_CAP_INT_MSG_NUM = 5'h00,
    parameter        PCIE_CAP_NEXTPTR = 8'h00,
    parameter        PCIE_CAP_ON = "TRUE",
    parameter        PCIE_CAP_RSVD_15_14 = 0,
    parameter        PCIE_CAP_SLOT_IMPLEMENTED = "FALSE",
    parameter        PCIE_REVISION = 2,
    parameter        PGL0_LANE = 0,
    parameter        PGL1_LANE = 1,
    parameter        PGL2_LANE = 2,
    parameter        PGL3_LANE = 3,
    parameter        PGL4_LANE = 4,
    parameter        PGL5_LANE = 5,
    parameter        PGL6_LANE = 6,
    parameter        PGL7_LANE = 7,
    parameter        PL_AUTO_CONFIG = 0,
    parameter        PL_FAST_TRAIN = "FALSE",
    parameter        PM_BASE_PTR = 8'h40,
    parameter        PM_CAP_AUXCURRENT = 0,
    parameter        PM_CAP_DSI = "FALSE",
    parameter        PM_CAP_D1SUPPORT = "TRUE",
    parameter        PM_CAP_D2SUPPORT = "TRUE",
    parameter        PM_CAP_ID = 8'h01,
    parameter        PM_CAP_NEXTPTR = 8'h48,
    parameter        PM_CAP_ON = "TRUE",
    parameter        PM_CAP_PME_CLOCK = "FALSE",
    parameter        PM_CAP_PMESUPPORT = 5'h0f,
    parameter        PM_CAP_RSVD_04 = 0,
    parameter        PM_CAP_VERSION = 3,
    parameter        PM_CSR_BPCCEN = "FALSE",
    parameter        PM_CSR_B2B3 = "FALSE",
    parameter        PM_CSR_NOSOFTRST = "TRUE",
    parameter        PM_DATA_SCALE0 = 2'h1,
    parameter        PM_DATA_SCALE1 = 2'h1,
    parameter        PM_DATA_SCALE2 = 2'h1,
    parameter        PM_DATA_SCALE3 = 2'h1,
    parameter        PM_DATA_SCALE4 = 2'h1,
    parameter        PM_DATA_SCALE5 = 2'h1,
    parameter        PM_DATA_SCALE6 = 2'h1,
    parameter        PM_DATA_SCALE7 = 2'h1,
    parameter        PM_DATA0 = 8'h01,
    parameter        PM_DATA1 = 8'h01,
    parameter        PM_DATA2 = 8'h01,
    parameter        PM_DATA3 = 8'h01,
    parameter        PM_DATA4 = 8'h01,
    parameter        PM_DATA5 = 8'h01,
    parameter        PM_DATA6 = 8'h01,
    parameter        PM_DATA7 = 8'h01,
    parameter        RECRC_CHK = 0,
    parameter        RECRC_CHK_TRIM = "FALSE",
    parameter        REVISION_ID = 8'h00,
    parameter        ROOT_CAP_CRS_SW_VISIBILITY = "FALSE",
    parameter        SELECT_DLL_IF = "FALSE",
    parameter        SLOT_CAP_ATT_BUTTON_PRESENT = "FALSE",
    parameter        SLOT_CAP_ATT_INDICATOR_PRESENT = "FALSE",
    parameter        SLOT_CAP_ELEC_INTERLOCK_PRESENT = "FALSE",
    parameter        SLOT_CAP_HOTPLUG_CAPABLE = "FALSE",
    parameter        SLOT_CAP_HOTPLUG_SURPRISE = "FALSE",
    parameter        SLOT_CAP_MRL_SENSOR_PRESENT = "FALSE",
    parameter        SLOT_CAP_NO_CMD_COMPLETED_SUPPORT = "FALSE",
    parameter        SLOT_CAP_PHYSICAL_SLOT_NUM = 13'h0000,
    parameter        SLOT_CAP_POWER_CONTROLLER_PRESENT = "FALSE",
    parameter        SLOT_CAP_POWER_INDICATOR_PRESENT = "FALSE",
    parameter        SLOT_CAP_SLOT_POWER_LIMIT_SCALE = 0,
    parameter        SLOT_CAP_SLOT_POWER_LIMIT_VALUE = 8'h00,
    parameter        SPARE_BIT0 = 0,
    parameter        SPARE_BIT1 = 0,
    parameter        SPARE_BIT2 = 0,
    parameter        SPARE_BIT3 = 0,
    parameter        SPARE_BIT4 = 0,
    parameter        SPARE_BIT5 = 0,
    parameter        SPARE_BIT6 = 0,
    parameter        SPARE_BIT7 = 0,
    parameter        SPARE_BIT8 = 0,
    parameter        SPARE_BYTE0 = 8'h00,
    parameter        SPARE_BYTE1 = 8'h00,
    parameter        SPARE_BYTE2 = 8'h00,
    parameter        SPARE_BYTE3 = 8'h00,
    parameter        SPARE_WORD0 = 32'h00000000,
    parameter        SPARE_WORD1 = 32'h00000000,
    parameter        SPARE_WORD2 = 32'h00000000,
    parameter        SPARE_WORD3 = 32'h00000000,
    parameter        SUBSYSTEM_ID = 16'h0007,
    parameter        SUBSYSTEM_VENDOR_ID = 16'h10ee,
    parameter        TL_RBYPASS = "FALSE",
    parameter        TL_RX_RAM_RADDR_LATENCY = 0,
    parameter        TL_RX_RAM_RDATA_LATENCY = 2,
    parameter        TL_RX_RAM_WRITE_LATENCY = 0,
    parameter        TL_TFC_DISABLE = "FALSE",
    parameter        TL_TX_CHECKS_DISABLE = "FALSE",
    parameter        TL_TX_RAM_RADDR_LATENCY = 0,
    parameter        TL_TX_RAM_RDATA_LATENCY = 2,
    parameter        TL_TX_RAM_WRITE_LATENCY = 0,
    parameter        UPCONFIG_CAPABLE = "TRUE",
    parameter        UPSTREAM_FACING = "TRUE",
    parameter        EXIT_LOOPBACK_ON_EI = "TRUE",
    parameter        UR_INV_REQ = "TRUE",
    parameter        USER_CLK_FREQ = 3,
    parameter        VC_BASE_PTR = 12'h10c,
    parameter        VC_CAP_ID = 16'h0002,
    parameter        VC_CAP_NEXTPTR = 12'h000,
    parameter        VC_CAP_ON = "FALSE",
    parameter        VC_CAP_REJECT_SNOOP_TRANSACTIONS = "FALSE",
    parameter        VC_CAP_VERSION = 4'h1,
    parameter        VC0_CPL_INFINITE = "TRUE",
    parameter        VC0_RX_RAM_LIMIT = 13'h03ff,
    parameter        VC0_TOTAL_CREDITS_CD = 127,
    parameter        VC0_TOTAL_CREDITS_CH = 31,
    parameter        VC0_TOTAL_CREDITS_NPH = 12,
    parameter        VC0_TOTAL_CREDITS_PD = 288,
    parameter        VC0_TOTAL_CREDITS_PH = 32,
    parameter        VC0_TX_LASTPACKET = 31,
    parameter        VENDOR_ID = 16'h10ee,
    parameter        VSEC_BASE_PTR = 12'h160,
    parameter        VSEC_CAP_HDR_ID = 16'h1234,
    parameter        VSEC_CAP_HDR_LENGTH = 12'h018,
    parameter        VSEC_CAP_HDR_REVISION = 4'h1,
    parameter        VSEC_CAP_ID = 16'h000b,
    parameter        VSEC_CAP_IS_LINK_VISIBLE = "TRUE",
    parameter        VSEC_CAP_NEXTPTR = 12'h000,
    parameter        VSEC_CAP_ON = "FALSE",
    parameter        VSEC_CAP_VERSION = 4'h1

)
(

    input            [(LINK_CAP_MAX_LINK_WIDTH - 1) : 0]  PCIEXPRXN,
    input            [(LINK_CAP_MAX_LINK_WIDTH - 1) : 0]  PCIEXPRXP,
    output           [(LINK_CAP_MAX_LINK_WIDTH - 1) : 0]  PCIEXPTXN,
    output           [(LINK_CAP_MAX_LINK_WIDTH - 1) : 0]  PCIEXPTXP,

    input            SYSCLK,
    input            FUNDRSTN,

    output           TRNLNKUPN,
    output           TRNCLK,

    output           PHYRDYN,
    output           USERRSTN,
    output           RECEIVEDFUNCLVLRSTN,
    output           LNKCLKEN,
    input            SYSRSTN,
    input            PLRSTN,
    input            DLRSTN,
    input            TLRSTN,
    input            FUNCLVLRSTN,
    input            CMRSTN,
    input            CMSTICKYRSTN,

    output [6:0]     TRNRBARHITN,
    output [63:0]    TRNRD,
    output           TRNRECRCERRN,
    output           TRNREOFN,
    output           TRNRERRFWDN,
    output           TRNRREMN,
    output           TRNRSOFN,
    output           TRNRSRCDSCN,
    output           TRNRSRCRDYN,
    input            TRNRDSTRDYN,
    input            TRNRNPOKN,

    output [5:0]     TRNTBUFAV,
    output           TRNTCFGREQN,
    output           TRNTDLLPDSTRDYN,
    output           TRNTDSTRDYN,
    output           TRNTERRDROPN,
    input            TRNTCFGGNTN,
    input  [63:0]    TRNTD,
    input  [31:0]    TRNTDLLPDATA,
    input            TRNTDLLPSRCRDYN,
    input            TRNTECRCGENN,
    input            TRNTEOFN,
    input            TRNTERRFWDN,
    input            TRNTREMN,
    input            TRNTSOFN,
    input            TRNTSRCDSCN,
    input            TRNTSRCRDYN,
    input            TRNTSTRN,

    output [11:0]    TRNFCCPLD,
    output [7:0]     TRNFCCPLH,
    output [11:0]    TRNFCNPD,
    output [7:0]     TRNFCNPH,
    output [11:0]    TRNFCPD,
    output [7:0]     TRNFCPH,
    input  [2:0]     TRNFCSEL,

    output           CFGAERECRCCHECKEN,
    output           CFGAERECRCGENEN,
    output           CFGCOMMANDBUSMASTERENABLE,
    output           CFGCOMMANDINTERRUPTDISABLE,
    output           CFGCOMMANDIOENABLE,
    output           CFGCOMMANDMEMENABLE,
    output           CFGCOMMANDSERREN,
    output           CFGDEVCONTROLAUXPOWEREN,
    output           CFGDEVCONTROLCORRERRREPORTINGEN,
    output           CFGDEVCONTROLENABLERO,
    output           CFGDEVCONTROLEXTTAGEN,
    output           CFGDEVCONTROLFATALERRREPORTINGEN,
    output [2:0]     CFGDEVCONTROLMAXPAYLOAD,
    output [2:0]     CFGDEVCONTROLMAXREADREQ,
    output           CFGDEVCONTROLNONFATALREPORTINGEN,
    output           CFGDEVCONTROLNOSNOOPEN,
    output           CFGDEVCONTROLPHANTOMEN,
    output           CFGDEVCONTROLURERRREPORTINGEN,
    output           CFGDEVCONTROL2CPLTIMEOUTDIS,
    output [3:0]     CFGDEVCONTROL2CPLTIMEOUTVAL,
    output           CFGDEVSTATUSCORRERRDETECTED,
    output           CFGDEVSTATUSFATALERRDETECTED,
    output           CFGDEVSTATUSNONFATALERRDETECTED,
    output           CFGDEVSTATUSURDETECTED,
    output [31:0]    CFGDO,
    output           CFGERRAERHEADERLOGSETN,
    output           CFGERRCPLRDYN,
    output [7:0]     CFGINTERRUPTDO,
    output [2:0]     CFGINTERRUPTMMENABLE,
    output           CFGINTERRUPTMSIENABLE,
    output           CFGINTERRUPTMSIXENABLE,
    output           CFGINTERRUPTMSIXFM,
    output           CFGINTERRUPTRDYN,
    output           CFGLINKCONTROLRCB,
    output [1:0]     CFGLINKCONTROLASPMCONTROL,
    output           CFGLINKCONTROLAUTOBANDWIDTHINTEN,
    output           CFGLINKCONTROLBANDWIDTHINTEN,
    output           CFGLINKCONTROLCLOCKPMEN,
    output           CFGLINKCONTROLCOMMONCLOCK,
    output           CFGLINKCONTROLEXTENDEDSYNC,
    output           CFGLINKCONTROLHWAUTOWIDTHDIS,
    output           CFGLINKCONTROLLINKDISABLE,
    output           CFGLINKCONTROLRETRAINLINK,
    output           CFGLINKSTATUSAUTOBANDWIDTHSTATUS,
    output           CFGLINKSTATUSBANDWITHSTATUS,
    output [1:0]     CFGLINKSTATUSCURRENTSPEED,
    output           CFGLINKSTATUSDLLACTIVE,
    output           CFGLINKSTATUSLINKTRAINING,
    output [3:0]     CFGLINKSTATUSNEGOTIATEDWIDTH,
    output [15:0]    CFGMSGDATA,
    output           CFGMSGRECEIVED,
    output           CFGMSGRECEIVEDASSERTINTA,
    output           CFGMSGRECEIVEDASSERTINTB,
    output           CFGMSGRECEIVEDASSERTINTC,
    output           CFGMSGRECEIVEDASSERTINTD,
    output           CFGMSGRECEIVEDDEASSERTINTA,
    output           CFGMSGRECEIVEDDEASSERTINTB,
    output           CFGMSGRECEIVEDDEASSERTINTC,
    output           CFGMSGRECEIVEDDEASSERTINTD,
    output           CFGMSGRECEIVEDERRCOR,
    output           CFGMSGRECEIVEDERRFATAL,
    output           CFGMSGRECEIVEDERRNONFATAL,
    output           CFGMSGRECEIVEDPMASNAK,
    output           CFGMSGRECEIVEDPMETO,
    output           CFGMSGRECEIVEDPMETOACK,
    output           CFGMSGRECEIVEDPMPME,
    output           CFGMSGRECEIVEDSETSLOTPOWERLIMIT,
    output           CFGMSGRECEIVEDUNLOCK,
    output [2:0]     CFGPCIELINKSTATE,
    output           CFGPMRCVASREQL1N,
    output           CFGPMRCVENTERL1N,
    output           CFGPMRCVENTERL23N,
    output           CFGPMRCVREQACKN,
    output           CFGPMCSRPMEEN,
    output           CFGPMCSRPMESTATUS,
    output [1:0]     CFGPMCSRPOWERSTATE,

    output           CFGRDWRDONEN,
    output           CFGSLOTCONTROLELECTROMECHILCTLPULSE,
    output           CFGTRANSACTION,
    output [6:0]     CFGTRANSACTIONADDR,
    output           CFGTRANSACTIONTYPE,
    output [6:0]     CFGVCTCVCMAP,
    input  [3:0]     CFGBYTEENN,
    input  [31:0]    CFGDI,
    input  [7:0]     CFGDSBUSNUMBER,
    input  [4:0]     CFGDSDEVICENUMBER,
    input  [2:0]     CFGDSFUNCTIONNUMBER,
    input  [63:0]    CFGDSN,
    input  [9:0]     CFGDWADDR,
    input            CFGERRACSN,
    input  [127:0]   CFGERRAERHEADERLOG,
    input            CFGERRCORN,
    input            CFGERRCPLABORTN,
    input            CFGERRCPLTIMEOUTN,
    input            CFGERRCPLUNEXPECTN,
    input            CFGERRECRCN,
    input            CFGERRLOCKEDN,
    input            CFGERRPOSTEDN,
    input  [47:0]    CFGERRTLPCPLHEADER,
    input            CFGERRURN,
    input            CFGINTERRUPTASSERTN,
    input  [7:0]     CFGINTERRUPTDI,
    input            CFGINTERRUPTN,
    input            CFGPMDIRECTASPML1N,
    input            CFGPMSENDPMACKN,
    input            CFGPMSENDPMETON,
    input            CFGPMSENDPMNAKN,
    input            CFGPMTURNOFFOKN,
    input            CFGPMWAKEN,
    input  [7:0]     CFGPORTNUMBER,
    input            CFGRDENN,
    input            CFGTRNPENDINGN,
    input            CFGWRENN,
    input            CFGWRREADONLYN,
    input            CFGWRRW1CASRWN,

    output [2:0]     PLINITIALLINKWIDTH,
    output [1:0]     PLLANEREVERSALMODE,
    output           PLLINKGEN2CAP,
    output           PLLINKPARTNERGEN2SUPPORTED,
    output           PLLINKUPCFGCAP,
    output [5:0]     PLLTSSMSTATE,
    output           PLPHYLNKUPN,
    output           PLRECEIVEDHOTRST,
    output [1:0]     PLRXPMSTATE,
    output           PLSELLNKRATE,
    output [1:0]     PLSELLNKWIDTH,
    output [2:0]     PLTXPMSTATE,
    input            PLDIRECTEDLINKAUTON,
    input  [1:0]     PLDIRECTEDLINKCHANGE,
    input            PLDIRECTEDLINKSPEED,
    input  [1:0]     PLDIRECTEDLINKWIDTH,
    input            PLDOWNSTREAMDEEMPHSOURCE,
    input            PLUPSTREAMPREFERDEEMPH,
    input            PLTRANSMITHOTRST,

    output           DBGSCLRA,
    output           DBGSCLRB,
    output           DBGSCLRC,
    output           DBGSCLRD,
    output           DBGSCLRE,
    output           DBGSCLRF,
    output           DBGSCLRG,
    output           DBGSCLRH,
    output           DBGSCLRI,
    output           DBGSCLRJ,
    output           DBGSCLRK,
    output [63:0]    DBGVECA,
    output [63:0]    DBGVECB,
    output [11:0]    DBGVECC,
    output [11:0]    PLDBGVEC,
    input  [1:0]     DBGMODE,
    input            DBGSUBMODE,
    input  [2:0]     PLDBGMODE,
    output [15:0]    PCIEDRPDO,
    output           PCIEDRPDRDY,
    input            PCIEDRPCLK,
    input  [8:0]     PCIEDRPDADDR,
    input            PCIEDRPDEN,
    input  [15:0]    PCIEDRPDI,
    input            PCIEDRPDWE,

    output           GTPLLLOCK,
    input            PIPECLK,
    input            USERCLK,
    input            DRPCLK,
    input            CLOCKLOCKED,
    output           TxOutClk


    );

    // wire declarations

    wire             LL2BADDLLPERRN;
    wire             LL2BADTLPERRN;
    wire             LL2PROTOCOLERRN;
    wire             LL2REPLAYROERRN;
    wire             LL2REPLAYTOERRN;
    wire             LL2SUSPENDOKN;
    wire             LL2TFCINIT1SEQN;
    wire             LL2TFCINIT2SEQN;
    wire [12:0]      MIMRXRADDR;
    wire             MIMRXRCE;
    wire             MIMRXREN;
    wire [12:0]      MIMRXWADDR;
    wire [67:0]      MIMRXWDATA;
    wire             MIMRXWEN;
    wire [12:0]      MIMTXRADDR;
    wire             MIMTXRCE;
    wire             MIMTXREN;
    wire [12:0]      MIMTXWADDR;
    wire [68:0]      MIMTXWDATA;
    wire             MIMTXWEN;
    wire             PIPERX0POLARITY;
    wire             PIPERX1POLARITY;
    wire             PIPERX2POLARITY;
    wire             PIPERX3POLARITY;
    wire             PIPERX4POLARITY;
    wire             PIPERX5POLARITY;
    wire             PIPERX6POLARITY;
    wire             PIPERX7POLARITY;
    wire             PIPETXDEEMPH;
    wire [2:0]       PIPETXMARGIN;
    wire             PIPETXRATE;
    wire             PIPETXRCVRDET;
    wire             PIPETXRESET;
    wire [1:0]       PIPETX0CHARISK;
    wire             PIPETX0COMPLIANCE;
    wire [15:0]      PIPETX0DATA;
    wire             PIPETX0ELECIDLE;
    wire [1:0]       PIPETX0POWERDOWN;
    wire [1:0]       PIPETX1CHARISK;
    wire             PIPETX1COMPLIANCE;
    wire [15:0]      PIPETX1DATA;
    wire             PIPETX1ELECIDLE;
    wire [1:0]       PIPETX1POWERDOWN;
    wire [1:0]       PIPETX2CHARISK;
    wire             PIPETX2COMPLIANCE;
    wire [15:0]      PIPETX2DATA;
    wire             PIPETX2ELECIDLE;
    wire [1:0]       PIPETX2POWERDOWN;
    wire [1:0]       PIPETX3CHARISK;
    wire             PIPETX3COMPLIANCE;
    wire [15:0]      PIPETX3DATA;
    wire             PIPETX3ELECIDLE;
    wire [1:0]       PIPETX3POWERDOWN;
    wire [1:0]       PIPETX4CHARISK;
    wire             PIPETX4COMPLIANCE;
    wire [15:0]      PIPETX4DATA;
    wire             PIPETX4ELECIDLE;
    wire [1:0]       PIPETX4POWERDOWN;
    wire [1:0]       PIPETX5CHARISK;
    wire             PIPETX5COMPLIANCE;
    wire [15:0]      PIPETX5DATA;
    wire             PIPETX5ELECIDLE;
    wire [1:0]       PIPETX5POWERDOWN;
    wire [1:0]       PIPETX6CHARISK;
    wire             PIPETX6COMPLIANCE;
    wire [15:0]      PIPETX6DATA;
    wire             PIPETX6ELECIDLE;
    wire [1:0]       PIPETX6POWERDOWN;
    wire [1:0]       PIPETX7CHARISK;
    wire             PIPETX7COMPLIANCE;
    wire [15:0]      PIPETX7DATA;
    wire             PIPETX7ELECIDLE;
    wire [1:0]       PIPETX7POWERDOWN;
    wire             PL2LINKUPN;
    wire             PL2RECEIVERERRN;
    wire             PL2RECOVERYN;
    wire             PL2RXELECIDLE;
    wire             PL2SUSPENDOK;
    wire             TL2ASPMSUSPENDCREDITCHECKOKN;
    wire             TL2ASPMSUSPENDREQN;
    wire             TL2PPMSUSPENDOKN;
    wire             LL2SENDASREQL1N = 1'b1;
    wire             LL2SENDENTERL1N = 1'b1;
    wire             LL2SENDENTERL23N = 1'b1;
    wire             LL2SUSPENDNOWN = 1'b1;
    wire             LL2TLPRCVN = 1'b1;
    wire  [71:0]     MIMRXRDATA;
    wire  [71:0]     MIMTXRDATA;
    wire  [4:0]      PL2DIRECTEDLSTATE = 5'b0;
    wire             TL2ASPMSUSPENDCREDITCHECKN;
    wire             TL2PPMSUSPENDREQN;
    wire             PIPERX0CHANISALIGNED;
    wire  [1:0]      PIPERX0CHARISK;
    wire  [15:0]     PIPERX0DATA;
    wire             PIPERX0ELECIDLE;
    wire             PIPERX0PHYSTATUS;
    wire  [2:0]      PIPERX0STATUS;
    wire             PIPERX0VALID;
    wire             PIPERX1CHANISALIGNED;
    wire  [1:0]      PIPERX1CHARISK;
    wire  [15:0]     PIPERX1DATA;
    wire             PIPERX1ELECIDLE;
    wire             PIPERX1PHYSTATUS;
    wire  [2:0]      PIPERX1STATUS;
    wire             PIPERX1VALID;
    wire             PIPERX2CHANISALIGNED;
    wire  [1:0]      PIPERX2CHARISK;
    wire  [15:0]     PIPERX2DATA;
    wire             PIPERX2ELECIDLE;
    wire             PIPERX2PHYSTATUS;
    wire  [2:0]      PIPERX2STATUS;
    wire             PIPERX2VALID;
    wire             PIPERX3CHANISALIGNED;
    wire  [1:0]      PIPERX3CHARISK;
    wire  [15:0]     PIPERX3DATA;
    wire             PIPERX3ELECIDLE;
    wire             PIPERX3PHYSTATUS;
    wire  [2:0]      PIPERX3STATUS;
    wire             PIPERX3VALID;
    wire             PIPERX4CHANISALIGNED;
    wire  [1:0]      PIPERX4CHARISK;
    wire  [15:0]     PIPERX4DATA;
    wire             PIPERX4ELECIDLE;
    wire             PIPERX4PHYSTATUS;
    wire  [2:0]      PIPERX4STATUS;
    wire             PIPERX4VALID;
    wire             PIPERX5CHANISALIGNED;
    wire  [1:0]      PIPERX5CHARISK;
    wire  [15:0]     PIPERX5DATA;
    wire             PIPERX5ELECIDLE;
    wire             PIPERX5PHYSTATUS;
    wire  [2:0]      PIPERX5STATUS;
    wire             PIPERX5VALID;
    wire             PIPERX6CHANISALIGNED;
    wire  [1:0]      PIPERX6CHARISK;
    wire  [15:0]     PIPERX6DATA;
    wire             PIPERX6ELECIDLE;
    wire             PIPERX6PHYSTATUS;
    wire  [2:0]      PIPERX6STATUS;
    wire             PIPERX6VALID;
    wire             PIPERX7CHANISALIGNED;
    wire  [1:0]      PIPERX7CHARISK;
    wire  [15:0]     PIPERX7DATA;
    wire             PIPERX7ELECIDLE;
    wire             PIPERX7PHYSTATUS;
    wire  [2:0]      PIPERX7STATUS;
    wire             PIPERX7VALID;

    wire             PIPERX0POLARITYGT;
    wire             PIPERX1POLARITYGT;
    wire             PIPERX2POLARITYGT;
    wire             PIPERX3POLARITYGT;
    wire             PIPERX4POLARITYGT;
    wire             PIPERX5POLARITYGT;
    wire             PIPERX6POLARITYGT;
    wire             PIPERX7POLARITYGT;
    wire             PIPETXDEEMPHGT;
    wire [2:0]       PIPETXMARGINGT;
    wire             PIPETXRATEGT;
    wire             PIPETXRCVRDETGT;
    wire [1:0]       PIPETX0CHARISKGT;
    wire             PIPETX0COMPLIANCEGT;
    wire [15:0]      PIPETX0DATAGT;
    wire             PIPETX0ELECIDLEGT;
    wire [1:0]       PIPETX0POWERDOWNGT;
    wire [1:0]       PIPETX1CHARISKGT;
    wire             PIPETX1COMPLIANCEGT;
    wire [15:0]      PIPETX1DATAGT;
    wire             PIPETX1ELECIDLEGT;
    wire [1:0]       PIPETX1POWERDOWNGT;
    wire [1:0]       PIPETX2CHARISKGT;
    wire             PIPETX2COMPLIANCEGT;
    wire [15:0]      PIPETX2DATAGT;
    wire             PIPETX2ELECIDLEGT;
    wire [1:0]       PIPETX2POWERDOWNGT;
    wire [1:0]       PIPETX3CHARISKGT;
    wire             PIPETX3COMPLIANCEGT;
    wire [15:0]      PIPETX3DATAGT;
    wire             PIPETX3ELECIDLEGT;
    wire [1:0]       PIPETX3POWERDOWNGT;
    wire [1:0]       PIPETX4CHARISKGT;
    wire             PIPETX4COMPLIANCEGT;
    wire [15:0]      PIPETX4DATAGT;
    wire             PIPETX4ELECIDLEGT;
    wire [1:0]       PIPETX4POWERDOWNGT;
    wire [1:0]       PIPETX5CHARISKGT;
    wire             PIPETX5COMPLIANCEGT;
    wire [15:0]      PIPETX5DATAGT;
    wire             PIPETX5ELECIDLEGT;
    wire [1:0]       PIPETX5POWERDOWNGT;
    wire [1:0]       PIPETX6CHARISKGT;
    wire             PIPETX6COMPLIANCEGT;
    wire [15:0]      PIPETX6DATAGT;
    wire             PIPETX6ELECIDLEGT;
    wire [1:0]       PIPETX6POWERDOWNGT;
    wire [1:0]       PIPETX7CHARISKGT;
    wire             PIPETX7COMPLIANCEGT;
    wire [15:0]      PIPETX7DATAGT;
    wire             PIPETX7ELECIDLEGT;
    wire [1:0]       PIPETX7POWERDOWNGT;

    wire             PIPERX0CHANISALIGNEDGT;
    wire  [1:0]      PIPERX0CHARISKGT;
    wire  [15:0]     PIPERX0DATAGT;
    wire             PIPERX0ELECIDLEGT;
    wire             PIPERX0PHYSTATUSGT;
    wire  [2:0]      PIPERX0STATUSGT;
    wire             PIPERX0VALIDGT;
    wire             PIPERX1CHANISALIGNEDGT;
    wire  [1:0]      PIPERX1CHARISKGT;
    wire  [15:0]     PIPERX1DATAGT;
    wire             PIPERX1ELECIDLEGT;
    wire             PIPERX1PHYSTATUSGT;
    wire  [2:0]      PIPERX1STATUSGT;
    wire             PIPERX1VALIDGT;
    wire             PIPERX2CHANISALIGNEDGT;
    wire  [1:0]      PIPERX2CHARISKGT;
    wire  [15:0]     PIPERX2DATAGT;
    wire             PIPERX2ELECIDLEGT;
    wire             PIPERX2PHYSTATUSGT;
    wire  [2:0]      PIPERX2STATUSGT;
    wire             PIPERX2VALIDGT;
    wire             PIPERX3CHANISALIGNEDGT;
    wire  [1:0]      PIPERX3CHARISKGT;
    wire  [15:0]     PIPERX3DATAGT;
    wire             PIPERX3ELECIDLEGT;
    wire             PIPERX3PHYSTATUSGT;
    wire  [2:0]      PIPERX3STATUSGT;
    wire             PIPERX3VALIDGT;
    wire             PIPERX4CHANISALIGNEDGT;
    wire  [1:0]      PIPERX4CHARISKGT;
    wire  [15:0]     PIPERX4DATAGT;
    wire             PIPERX4ELECIDLEGT;
    wire             PIPERX4PHYSTATUSGT;
    wire  [2:0]      PIPERX4STATUSGT;
    wire             PIPERX4VALIDGT;
    wire             PIPERX5CHANISALIGNEDGT;
    wire  [1:0]      PIPERX5CHARISKGT;
    wire  [15:0]     PIPERX5DATAGT;
    wire             PIPERX5ELECIDLEGT;
    wire             PIPERX5PHYSTATUSGT;
    wire  [2:0]      PIPERX5STATUSGT;
    wire             PIPERX5VALIDGT;
    wire             PIPERX6CHANISALIGNEDGT;
    wire  [1:0]      PIPERX6CHARISKGT;
    wire  [15:0]     PIPERX6DATAGT;
    wire             PIPERX6ELECIDLEGT;
    wire             PIPERX6PHYSTATUSGT;
    wire  [2:0]      PIPERX6STATUSGT;
    wire             PIPERX6VALIDGT;
    wire             PIPERX7CHANISALIGNEDGT;
    wire  [1:0]      PIPERX7CHARISKGT;
    wire  [15:0]     PIPERX7DATAGT;
    wire             PIPERX7ELECIDLEGT;
    wire             PIPERX7PHYSTATUSGT;
    wire  [2:0]      PIPERX7STATUSGT;
    wire             PIPERX7VALIDGT;

    wire             filter_pipe_upconfig_fix_3451;

// Assignments to outputs

    assign TRNCLK = USERCLK;

//-------------------------------------------------------
// Virtex6 PCI Express Block Module
//-------------------------------------------------------

PCIE_2_0 #(

  .AER_BASE_PTR ( AER_BASE_PTR ),
  .AER_CAP_ECRC_CHECK_CAPABLE ( AER_CAP_ECRC_CHECK_CAPABLE ),
  .AER_CAP_ECRC_GEN_CAPABLE ( AER_CAP_ECRC_GEN_CAPABLE ),
  .AER_CAP_ID ( AER_CAP_ID ),
  .AER_CAP_INT_MSG_NUM_MSI ( AER_CAP_INT_MSG_NUM_MSI ),
  .AER_CAP_INT_MSG_NUM_MSIX ( AER_CAP_INT_MSG_NUM_MSIX ),
  .AER_CAP_NEXTPTR ( AER_CAP_NEXTPTR ),
  .AER_CAP_ON ( AER_CAP_ON ),
  .AER_CAP_PERMIT_ROOTERR_UPDATE ( AER_CAP_PERMIT_ROOTERR_UPDATE ),
  .AER_CAP_VERSION ( AER_CAP_VERSION ),
  .ALLOW_X8_GEN2 ( ALLOW_X8_GEN2 ),
  .BAR0 ( BAR0 ),
  .BAR1 ( BAR1 ),
  .BAR2 ( BAR2 ),
  .BAR3 ( BAR3 ),
  .BAR4 ( BAR4 ),
  .BAR5 ( BAR5 ),
  .CAPABILITIES_PTR ( CAPABILITIES_PTR ),
  .CARDBUS_CIS_POINTER ( CARDBUS_CIS_POINTER ),
  .CLASS_CODE ( CLASS_CODE ),
  .CMD_INTX_IMPLEMENTED ( CMD_INTX_IMPLEMENTED ),
  .CPL_TIMEOUT_DISABLE_SUPPORTED ( CPL_TIMEOUT_DISABLE_SUPPORTED ),
  .CPL_TIMEOUT_RANGES_SUPPORTED ( CPL_TIMEOUT_RANGES_SUPPORTED ),
  .CRM_MODULE_RSTS ( CRM_MODULE_RSTS ),
  .DEV_CAP_ENABLE_SLOT_PWR_LIMIT_SCALE ( DEV_CAP_ENABLE_SLOT_PWR_LIMIT_SCALE ),
  .DEV_CAP_ENABLE_SLOT_PWR_LIMIT_VALUE ( DEV_CAP_ENABLE_SLOT_PWR_LIMIT_VALUE ),
  .DEV_CAP_ENDPOINT_L0S_LATENCY ( DEV_CAP_ENDPOINT_L0S_LATENCY ),
  .DEV_CAP_ENDPOINT_L1_LATENCY ( DEV_CAP_ENDPOINT_L1_LATENCY ),
  .DEV_CAP_EXT_TAG_SUPPORTED ( DEV_CAP_EXT_TAG_SUPPORTED ),
  .DEV_CAP_FUNCTION_LEVEL_RESET_CAPABLE ( DEV_CAP_FUNCTION_LEVEL_RESET_CAPABLE ),
  .DEV_CAP_MAX_PAYLOAD_SUPPORTED ( DEV_CAP_MAX_PAYLOAD_SUPPORTED ),
  .DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT ( DEV_CAP_PHANTOM_FUNCTIONS_SUPPORT ),
  .DEV_CAP_ROLE_BASED_ERROR ( DEV_CAP_ROLE_BASED_ERROR ),
  .DEV_CAP_RSVD_14_12 ( DEV_CAP_RSVD_14_12 ),
  .DEV_CAP_RSVD_17_16 ( DEV_CAP_RSVD_17_16 ),
  .DEV_CAP_RSVD_31_29 ( DEV_CAP_RSVD_31_29 ),
  .DEV_CONTROL_AUX_POWER_SUPPORTED ( DEV_CONTROL_AUX_POWER_SUPPORTED ),
  .DEVICE_ID ( DEVICE_ID ),
  .DISABLE_ASPM_L1_TIMER ( DISABLE_ASPM_L1_TIMER ),
  .DISABLE_BAR_FILTERING ( DISABLE_BAR_FILTERING ),
  .DISABLE_ID_CHECK ( DISABLE_ID_CHECK ),
  .DISABLE_LANE_REVERSAL ( DISABLE_LANE_REVERSAL ),
  .DISABLE_RX_TC_FILTER ( DISABLE_RX_TC_FILTER ),
  .DISABLE_SCRAMBLING ( DISABLE_SCRAMBLING ),
  .DNSTREAM_LINK_NUM ( DNSTREAM_LINK_NUM ),
  .DSN_BASE_PTR ( DSN_BASE_PTR ),
  .DSN_CAP_ID ( DSN_CAP_ID ),
  .DSN_CAP_NEXTPTR ( DSN_CAP_NEXTPTR ),
  .DSN_CAP_ON ( DSN_CAP_ON ),
  .DSN_CAP_VERSION ( DSN_CAP_VERSION ),
  .ENABLE_MSG_ROUTE ( ENABLE_MSG_ROUTE ),
  .ENABLE_RX_TD_ECRC_TRIM ( ENABLE_RX_TD_ECRC_TRIM ),
  .ENTER_RVRY_EI_L0 ( ENTER_RVRY_EI_L0 ),
  .EXPANSION_ROM ( EXPANSION_ROM ),
  .EXT_CFG_CAP_PTR ( EXT_CFG_CAP_PTR ),
  .EXT_CFG_XP_CAP_PTR ( EXT_CFG_XP_CAP_PTR ),
  .HEADER_TYPE ( HEADER_TYPE ),
  .INFER_EI ( INFER_EI ),
  .INTERRUPT_PIN ( INTERRUPT_PIN ),
  .IS_SWITCH ( IS_SWITCH ),
  .LAST_CONFIG_DWORD ( LAST_CONFIG_DWORD ),
  .LINK_CAP_ASPM_SUPPORT ( LINK_CAP_ASPM_SUPPORT ),
  .LINK_CAP_CLOCK_POWER_MANAGEMENT ( LINK_CAP_CLOCK_POWER_MANAGEMENT ),
  .LINK_CAP_DLL_LINK_ACTIVE_REPORTING_CAP ( LINK_CAP_DLL_LINK_ACTIVE_REPORTING_CAP ),
  .LINK_CAP_LINK_BANDWIDTH_NOTIFICATION_CAP ( LINK_CAP_LINK_BANDWIDTH_NOTIFICATION_CAP ),
  .LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN1 ( LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN1 ),
  .LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN2 ( LINK_CAP_L0S_EXIT_LATENCY_COMCLK_GEN2 ),
  .LINK_CAP_L0S_EXIT_LATENCY_GEN1 ( LINK_CAP_L0S_EXIT_LATENCY_GEN1 ),
  .LINK_CAP_L0S_EXIT_LATENCY_GEN2 ( LINK_CAP_L0S_EXIT_LATENCY_GEN2 ),
  .LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN1 ( LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN1 ),
  .LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN2 ( LINK_CAP_L1_EXIT_LATENCY_COMCLK_GEN2 ),
  .LINK_CAP_L1_EXIT_LATENCY_GEN1 ( LINK_CAP_L1_EXIT_LATENCY_GEN1 ),
  .LINK_CAP_L1_EXIT_LATENCY_GEN2 ( LINK_CAP_L1_EXIT_LATENCY_GEN2 ),
  .LINK_CAP_MAX_LINK_SPEED ( LINK_CAP_MAX_LINK_SPEED ),
  .LINK_CAP_MAX_LINK_WIDTH ( LINK_CAP_MAX_LINK_WIDTH ),
  .LINK_CAP_RSVD_23_22 ( LINK_CAP_RSVD_23_22 ),
  .LINK_CAP_SURPRISE_DOWN_ERROR_CAPABLE ( LINK_CAP_SURPRISE_DOWN_ERROR_CAPABLE ),
  .LINK_CONTROL_RCB ( LINK_CONTROL_RCB ),
  .LINK_CTRL2_DEEMPHASIS ( LINK_CTRL2_DEEMPHASIS ),
  .LINK_CTRL2_HW_AUTONOMOUS_SPEED_DISABLE ( LINK_CTRL2_HW_AUTONOMOUS_SPEED_DISABLE ),
  .LINK_CTRL2_TARGET_LINK_SPEED ( LINK_CTRL2_TARGET_LINK_SPEED ),
  .LINK_STATUS_SLOT_CLOCK_CONFIG ( LINK_STATUS_SLOT_CLOCK_CONFIG ),
  .LL_ACK_TIMEOUT ( LL_ACK_TIMEOUT ),
  .LL_ACK_TIMEOUT_EN ( LL_ACK_TIMEOUT_EN ),
  .LL_ACK_TIMEOUT_FUNC ( LL_ACK_TIMEOUT_FUNC ),
  .LL_REPLAY_TIMEOUT ( LL_REPLAY_TIMEOUT ),
  .LL_REPLAY_TIMEOUT_EN ( LL_REPLAY_TIMEOUT_EN ),
  .LL_REPLAY_TIMEOUT_FUNC ( LL_REPLAY_TIMEOUT_FUNC ),
  .LTSSM_MAX_LINK_WIDTH ( LTSSM_MAX_LINK_WIDTH ),
  .MSI_BASE_PTR ( MSI_BASE_PTR ),
  .MSI_CAP_ID ( MSI_CAP_ID ),
  .MSI_CAP_MULTIMSGCAP ( MSI_CAP_MULTIMSGCAP ),
  .MSI_CAP_MULTIMSG_EXTENSION ( MSI_CAP_MULTIMSG_EXTENSION ),
  .MSI_CAP_NEXTPTR ( MSI_CAP_NEXTPTR ),
  .MSI_CAP_ON ( MSI_CAP_ON ),
  .MSI_CAP_PER_VECTOR_MASKING_CAPABLE ( MSI_CAP_PER_VECTOR_MASKING_CAPABLE ),
  .MSI_CAP_64_BIT_ADDR_CAPABLE ( MSI_CAP_64_BIT_ADDR_CAPABLE ),
  .MSIX_BASE_PTR ( MSIX_BASE_PTR ),
  .MSIX_CAP_ID ( MSIX_CAP_ID ),
  .MSIX_CAP_NEXTPTR ( MSIX_CAP_NEXTPTR ),
  .MSIX_CAP_ON ( MSIX_CAP_ON ),
  .MSIX_CAP_PBA_BIR ( MSIX_CAP_PBA_BIR ),
  .MSIX_CAP_PBA_OFFSET ( MSIX_CAP_PBA_OFFSET ),
  .MSIX_CAP_TABLE_BIR ( MSIX_CAP_TABLE_BIR ),
  .MSIX_CAP_TABLE_OFFSET ( MSIX_CAP_TABLE_OFFSET ),
  .MSIX_CAP_TABLE_SIZE ( MSIX_CAP_TABLE_SIZE ),
  .N_FTS_COMCLK_GEN1 ( N_FTS_COMCLK_GEN1 ),
  .N_FTS_COMCLK_GEN2 ( N_FTS_COMCLK_GEN2 ),
  .N_FTS_GEN1 ( N_FTS_GEN1 ),
  .N_FTS_GEN2 ( N_FTS_GEN2 ),
  .PCIE_BASE_PTR ( PCIE_BASE_PTR ),
  .PCIE_CAP_CAPABILITY_ID ( PCIE_CAP_CAPABILITY_ID ),
  .PCIE_CAP_CAPABILITY_VERSION ( PCIE_CAP_CAPABILITY_VERSION ),
  .PCIE_CAP_DEVICE_PORT_TYPE ( PCIE_CAP_DEVICE_PORT_TYPE ),
  .PCIE_CAP_INT_MSG_NUM ( PCIE_CAP_INT_MSG_NUM ),
  .PCIE_CAP_NEXTPTR ( PCIE_CAP_NEXTPTR ),
  .PCIE_CAP_ON ( PCIE_CAP_ON ),
  .PCIE_CAP_RSVD_15_14 ( PCIE_CAP_RSVD_15_14 ),
  .PCIE_CAP_SLOT_IMPLEMENTED ( PCIE_CAP_SLOT_IMPLEMENTED ),
  .PCIE_REVISION ( PCIE_REVISION ),
  .PGL0_LANE ( PGL0_LANE ),
  .PGL1_LANE ( PGL1_LANE ),
  .PGL2_LANE ( PGL2_LANE ),
  .PGL3_LANE ( PGL3_LANE ),
  .PGL4_LANE ( PGL4_LANE ),
  .PGL5_LANE ( PGL5_LANE ),
  .PGL6_LANE ( PGL6_LANE ),
  .PGL7_LANE ( PGL7_LANE ),
  .PL_AUTO_CONFIG ( PL_AUTO_CONFIG ),
  .PL_FAST_TRAIN ( PL_FAST_TRAIN ),
  .PM_BASE_PTR ( PM_BASE_PTR ),
  .PM_CAP_AUXCURRENT ( PM_CAP_AUXCURRENT ),
  .PM_CAP_DSI ( PM_CAP_DSI ),
  .PM_CAP_D1SUPPORT ( PM_CAP_D1SUPPORT ),
  .PM_CAP_D2SUPPORT ( PM_CAP_D2SUPPORT ),
  .PM_CAP_ID ( PM_CAP_ID ),
  .PM_CAP_NEXTPTR ( PM_CAP_NEXTPTR ),
  .PM_CAP_ON ( PM_CAP_ON ),
  .PM_CAP_PME_CLOCK ( PM_CAP_PME_CLOCK ),
  .PM_CAP_PMESUPPORT ( PM_CAP_PMESUPPORT ),
  .PM_CAP_RSVD_04 ( PM_CAP_RSVD_04 ),
  .PM_CAP_VERSION ( PM_CAP_VERSION ),
  .PM_CSR_BPCCEN ( PM_CSR_BPCCEN ),
  .PM_CSR_B2B3 ( PM_CSR_B2B3 ),
  .PM_CSR_NOSOFTRST ( PM_CSR_NOSOFTRST ),
  .PM_DATA_SCALE0 ( PM_DATA_SCALE0 ),
  .PM_DATA_SCALE1 ( PM_DATA_SCALE1 ),
  .PM_DATA_SCALE2 ( PM_DATA_SCALE2 ),
  .PM_DATA_SCALE3 ( PM_DATA_SCALE3 ),
  .PM_DATA_SCALE4 ( PM_DATA_SCALE4 ),
  .PM_DATA_SCALE5 ( PM_DATA_SCALE5 ),
  .PM_DATA_SCALE6 ( PM_DATA_SCALE6 ),
  .PM_DATA_SCALE7 ( PM_DATA_SCALE7 ),
  .PM_DATA0 ( PM_DATA0 ),
  .PM_DATA1 ( PM_DATA1 ),
  .PM_DATA2 ( PM_DATA2 ),
  .PM_DATA3 ( PM_DATA3 ),
  .PM_DATA4 ( PM_DATA4 ),
  .PM_DATA5 ( PM_DATA5 ),
  .PM_DATA6 ( PM_DATA6 ),
  .PM_DATA7 ( PM_DATA7 ),
  .RECRC_CHK ( RECRC_CHK ),
  .RECRC_CHK_TRIM ( RECRC_CHK_TRIM ),
  .REVISION_ID ( REVISION_ID ),
  .ROOT_CAP_CRS_SW_VISIBILITY ( ROOT_CAP_CRS_SW_VISIBILITY ),
  .SELECT_DLL_IF ( SELECT_DLL_IF ),
  .SLOT_CAP_ATT_BUTTON_PRESENT ( SLOT_CAP_ATT_BUTTON_PRESENT ),
  .SLOT_CAP_ATT_INDICATOR_PRESENT ( SLOT_CAP_ATT_INDICATOR_PRESENT ),
  .SLOT_CAP_ELEC_INTERLOCK_PRESENT ( SLOT_CAP_ELEC_INTERLOCK_PRESENT ),
  .SLOT_CAP_HOTPLUG_CAPABLE ( SLOT_CAP_HOTPLUG_CAPABLE ),
  .SLOT_CAP_HOTPLUG_SURPRISE ( SLOT_CAP_HOTPLUG_SURPRISE ),
  .SLOT_CAP_MRL_SENSOR_PRESENT ( SLOT_CAP_MRL_SENSOR_PRESENT ),
  .SLOT_CAP_NO_CMD_COMPLETED_SUPPORT ( SLOT_CAP_NO_CMD_COMPLETED_SUPPORT ),
  .SLOT_CAP_PHYSICAL_SLOT_NUM ( SLOT_CAP_PHYSICAL_SLOT_NUM ),
  .SLOT_CAP_POWER_CONTROLLER_PRESENT ( SLOT_CAP_POWER_CONTROLLER_PRESENT ),
  .SLOT_CAP_POWER_INDICATOR_PRESENT ( SLOT_CAP_POWER_INDICATOR_PRESENT ),
  .SLOT_CAP_SLOT_POWER_LIMIT_SCALE ( SLOT_CAP_SLOT_POWER_LIMIT_SCALE ),
  .SLOT_CAP_SLOT_POWER_LIMIT_VALUE ( SLOT_CAP_SLOT_POWER_LIMIT_VALUE ),
  .SPARE_BIT0 ( SPARE_BIT0 ),
  .SPARE_BIT1 ( SPARE_BIT1 ),
  .SPARE_BIT2 ( SPARE_BIT2 ),
  .SPARE_BIT3 ( SPARE_BIT3 ),
  .SPARE_BIT4 ( SPARE_BIT4 ),
  .SPARE_BIT5 ( SPARE_BIT5 ),
  .SPARE_BIT6 ( SPARE_BIT6 ),
  .SPARE_BIT7 ( SPARE_BIT7 ),
  .SPARE_BIT8 ( SPARE_BIT8 ),
  .SPARE_BYTE0 ( SPARE_BYTE0 ),
  .SPARE_BYTE1 ( SPARE_BYTE1 ),
  .SPARE_BYTE2 ( SPARE_BYTE2 ),
  .SPARE_BYTE3 ( SPARE_BYTE3 ),
  .SPARE_WORD0 ( SPARE_WORD0 ),
  .SPARE_WORD1 ( SPARE_WORD1 ),
  .SPARE_WORD2 ( SPARE_WORD2 ),
  .SPARE_WORD3 ( SPARE_WORD3 ),
  .SUBSYSTEM_ID ( SUBSYSTEM_ID ),
  .SUBSYSTEM_VENDOR_ID ( SUBSYSTEM_VENDOR_ID ),
  .TL_RBYPASS ( TL_RBYPASS ),
  .TL_RX_RAM_RADDR_LATENCY ( TL_RX_RAM_RADDR_LATENCY ),
  .TL_RX_RAM_RDATA_LATENCY ( TL_RX_RAM_RDATA_LATENCY ),
  .TL_RX_RAM_WRITE_LATENCY ( TL_RX_RAM_WRITE_LATENCY ),
  .TL_TFC_DISABLE ( TL_TFC_DISABLE ),
  .TL_TX_CHECKS_DISABLE ( TL_TX_CHECKS_DISABLE ),
  .TL_TX_RAM_RADDR_LATENCY ( TL_TX_RAM_RADDR_LATENCY ),
  .TL_TX_RAM_RDATA_LATENCY ( TL_TX_RAM_RDATA_LATENCY ),
  .TL_TX_RAM_WRITE_LATENCY ( TL_TX_RAM_WRITE_LATENCY ),
  .UPCONFIG_CAPABLE ( UPCONFIG_CAPABLE ),
  .UPSTREAM_FACING ( UPSTREAM_FACING ),
  .EXIT_LOOPBACK_ON_EI ( EXIT_LOOPBACK_ON_EI ),
  .UR_INV_REQ ( UR_INV_REQ ),
  .USER_CLK_FREQ ( USER_CLK_FREQ ),
  .VC_BASE_PTR ( VC_BASE_PTR ),
  .VC_CAP_ID ( VC_CAP_ID ),
  .VC_CAP_NEXTPTR ( VC_CAP_NEXTPTR ),
  .VC_CAP_ON ( VC_CAP_ON ),
  .VC_CAP_REJECT_SNOOP_TRANSACTIONS ( VC_CAP_REJECT_SNOOP_TRANSACTIONS ),
  .VC_CAP_VERSION ( VC_CAP_VERSION ),
  .VC0_CPL_INFINITE ( VC0_CPL_INFINITE ),
  .VC0_RX_RAM_LIMIT ( VC0_RX_RAM_LIMIT ),
  .VC0_TOTAL_CREDITS_CD ( VC0_TOTAL_CREDITS_CD ),
  .VC0_TOTAL_CREDITS_CH ( VC0_TOTAL_CREDITS_CH ),
  .VC0_TOTAL_CREDITS_NPH ( VC0_TOTAL_CREDITS_NPH ),
  .VC0_TOTAL_CREDITS_PD ( VC0_TOTAL_CREDITS_PD ),
  .VC0_TOTAL_CREDITS_PH ( VC0_TOTAL_CREDITS_PH ),
  .VC0_TX_LASTPACKET ( VC0_TX_LASTPACKET ),
  .VENDOR_ID ( VENDOR_ID ),
  .VSEC_BASE_PTR ( VSEC_BASE_PTR ),
  .VSEC_CAP_HDR_ID ( VSEC_CAP_HDR_ID ),
  .VSEC_CAP_HDR_LENGTH ( VSEC_CAP_HDR_LENGTH ),
  .VSEC_CAP_HDR_REVISION ( VSEC_CAP_HDR_REVISION ),
  .VSEC_CAP_ID ( VSEC_CAP_ID ),
  .VSEC_CAP_IS_LINK_VISIBLE ( VSEC_CAP_IS_LINK_VISIBLE ),
  .VSEC_CAP_NEXTPTR ( VSEC_CAP_NEXTPTR ),
  .VSEC_CAP_ON ( VSEC_CAP_ON ),
  .VSEC_CAP_VERSION ( VSEC_CAP_VERSION )

)
pcie_block_i (

  .CFGAERECRCCHECKEN ( CFGAERECRCCHECKEN ),
  .CFGAERECRCGENEN ( CFGAERECRCGENEN ),
  .CFGCOMMANDBUSMASTERENABLE ( CFGCOMMANDBUSMASTERENABLE ),
  .CFGCOMMANDINTERRUPTDISABLE ( CFGCOMMANDINTERRUPTDISABLE ),
  .CFGCOMMANDIOENABLE ( CFGCOMMANDIOENABLE ),
  .CFGCOMMANDMEMENABLE ( CFGCOMMANDMEMENABLE ),
  .CFGCOMMANDSERREN ( CFGCOMMANDSERREN ),
  .CFGDEVCONTROLAUXPOWEREN ( CFGDEVCONTROLAUXPOWEREN ),
  .CFGDEVCONTROLCORRERRREPORTINGEN ( CFGDEVCONTROLCORRERRREPORTINGEN ),
  .CFGDEVCONTROLENABLERO ( CFGDEVCONTROLENABLERO ),
  .CFGDEVCONTROLEXTTAGEN ( CFGDEVCONTROLEXTTAGEN ),
  .CFGDEVCONTROLFATALERRREPORTINGEN ( CFGDEVCONTROLFATALERRREPORTINGEN ),
  .CFGDEVCONTROLMAXPAYLOAD ( CFGDEVCONTROLMAXPAYLOAD ),
  .CFGDEVCONTROLMAXREADREQ ( CFGDEVCONTROLMAXREADREQ ),
  .CFGDEVCONTROLNONFATALREPORTINGEN ( CFGDEVCONTROLNONFATALREPORTINGEN ),
  .CFGDEVCONTROLNOSNOOPEN ( CFGDEVCONTROLNOSNOOPEN ),
  .CFGDEVCONTROLPHANTOMEN ( CFGDEVCONTROLPHANTOMEN ),
  .CFGDEVCONTROLURERRREPORTINGEN ( CFGDEVCONTROLURERRREPORTINGEN ),
  .CFGDEVCONTROL2CPLTIMEOUTDIS ( CFGDEVCONTROL2CPLTIMEOUTDIS ),
  .CFGDEVCONTROL2CPLTIMEOUTVAL ( CFGDEVCONTROL2CPLTIMEOUTVAL ),
  .CFGDEVSTATUSCORRERRDETECTED ( CFGDEVSTATUSCORRERRDETECTED ),
  .CFGDEVSTATUSFATALERRDETECTED ( CFGDEVSTATUSFATALERRDETECTED ),
  .CFGDEVSTATUSNONFATALERRDETECTED ( CFGDEVSTATUSNONFATALERRDETECTED ),
  .CFGDEVSTATUSURDETECTED ( CFGDEVSTATUSURDETECTED ),
  .CFGDO ( CFGDO ),
  .CFGERRAERHEADERLOGSETN ( CFGERRAERHEADERLOGSETN ),
  .CFGERRCPLRDYN ( CFGERRCPLRDYN ),
  .CFGINTERRUPTDO ( CFGINTERRUPTDO ),
  .CFGINTERRUPTMMENABLE ( CFGINTERRUPTMMENABLE ),
  .CFGINTERRUPTMSIENABLE ( CFGINTERRUPTMSIENABLE ),
  .CFGINTERRUPTMSIXENABLE ( CFGINTERRUPTMSIXENABLE ),
  .CFGINTERRUPTMSIXFM ( CFGINTERRUPTMSIXFM ),
  .CFGINTERRUPTRDYN ( CFGINTERRUPTRDYN ),
  .CFGLINKCONTROLRCB ( CFGLINKCONTROLRCB ),
  .CFGLINKCONTROLASPMCONTROL ( CFGLINKCONTROLASPMCONTROL ),
  .CFGLINKCONTROLAUTOBANDWIDTHINTEN ( CFGLINKCONTROLAUTOBANDWIDTHINTEN ),
  .CFGLINKCONTROLBANDWIDTHINTEN ( CFGLINKCONTROLBANDWIDTHINTEN ),
  .CFGLINKCONTROLCLOCKPMEN ( CFGLINKCONTROLCLOCKPMEN ),
  .CFGLINKCONTROLCOMMONCLOCK ( CFGLINKCONTROLCOMMONCLOCK ),
  .CFGLINKCONTROLEXTENDEDSYNC ( CFGLINKCONTROLEXTENDEDSYNC ),
  .CFGLINKCONTROLHWAUTOWIDTHDIS ( CFGLINKCONTROLHWAUTOWIDTHDIS ),
  .CFGLINKCONTROLLINKDISABLE ( CFGLINKCONTROLLINKDISABLE ),
  .CFGLINKCONTROLRETRAINLINK ( CFGLINKCONTROLRETRAINLINK ),
  .CFGLINKSTATUSAUTOBANDWIDTHSTATUS ( CFGLINKSTATUSAUTOBANDWIDTHSTATUS ),
  .CFGLINKSTATUSBANDWITHSTATUS ( CFGLINKSTATUSBANDWITHSTATUS ),
  .CFGLINKSTATUSCURRENTSPEED ( CFGLINKSTATUSCURRENTSPEED ),
  .CFGLINKSTATUSDLLACTIVE ( CFGLINKSTATUSDLLACTIVE ),
  .CFGLINKSTATUSLINKTRAINING ( CFGLINKSTATUSLINKTRAINING ),
  .CFGLINKSTATUSNEGOTIATEDWIDTH ( CFGLINKSTATUSNEGOTIATEDWIDTH ),
  .CFGMSGDATA ( CFGMSGDATA ),
  .CFGMSGRECEIVED ( CFGMSGRECEIVED ),
  .CFGMSGRECEIVEDASSERTINTA ( CFGMSGRECEIVEDASSERTINTA ),
  .CFGMSGRECEIVEDASSERTINTB ( CFGMSGRECEIVEDASSERTINTB ),
  .CFGMSGRECEIVEDASSERTINTC ( CFGMSGRECEIVEDASSERTINTC ),
  .CFGMSGRECEIVEDASSERTINTD ( CFGMSGRECEIVEDASSERTINTD ),
  .CFGMSGRECEIVEDDEASSERTINTA ( CFGMSGRECEIVEDDEASSERTINTA ),
  .CFGMSGRECEIVEDDEASSERTINTB ( CFGMSGRECEIVEDDEASSERTINTB ),
  .CFGMSGRECEIVEDDEASSERTINTC ( CFGMSGRECEIVEDDEASSERTINTC ),
  .CFGMSGRECEIVEDDEASSERTINTD ( CFGMSGRECEIVEDDEASSERTINTD ),
  .CFGMSGRECEIVEDERRCOR ( CFGMSGRECEIVEDERRCOR ),
  .CFGMSGRECEIVEDERRFATAL ( CFGMSGRECEIVEDERRFATAL ),
  .CFGMSGRECEIVEDERRNONFATAL ( CFGMSGRECEIVEDERRNONFATAL ),
  .CFGMSGRECEIVEDPMASNAK ( CFGMSGRECEIVEDPMASNAK ),
  .CFGMSGRECEIVEDPMETO ( CFGMSGRECEIVEDPMETO ),
  .CFGMSGRECEIVEDPMETOACK ( CFGMSGRECEIVEDPMETOACK ),
  .CFGMSGRECEIVEDPMPME ( CFGMSGRECEIVEDPMPME ),
  .CFGMSGRECEIVEDSETSLOTPOWERLIMIT ( CFGMSGRECEIVEDSETSLOTPOWERLIMIT ),
  .CFGMSGRECEIVEDUNLOCK ( CFGMSGRECEIVEDUNLOCK ),
  .CFGPCIELINKSTATE ( CFGPCIELINKSTATE ),
  .CFGPMRCVASREQL1N ( CFGPMRCVASREQL1N ),
  .CFGPMRCVENTERL1N ( CFGPMRCVENTERL1N ),
  .CFGPMRCVENTERL23N ( CFGPMRCVENTERL23N ),
  .CFGPMRCVREQACKN ( CFGPMRCVREQACKN ),
  .CFGPMCSRPMEEN ( CFGPMCSRPMEEN ),
  .CFGPMCSRPMESTATUS ( CFGPMCSRPMESTATUS ),
  .CFGPMCSRPOWERSTATE ( CFGPMCSRPOWERSTATE ),
  .CFGRDWRDONEN ( CFGRDWRDONEN ),
  .CFGSLOTCONTROLELECTROMECHILCTLPULSE ( CFGSLOTCONTROLELECTROMECHILCTLPULSE ),
  .CFGTRANSACTION ( CFGTRANSACTION ),
  .CFGTRANSACTIONADDR ( CFGTRANSACTIONADDR ),
  .CFGTRANSACTIONTYPE ( CFGTRANSACTIONTYPE ),
  .CFGVCTCVCMAP ( CFGVCTCVCMAP ),
  .DBGSCLRA ( DBGSCLRA ),
  .DBGSCLRB ( DBGSCLRB ),
  .DBGSCLRC ( DBGSCLRC ),
  .DBGSCLRD ( DBGSCLRD ),
  .DBGSCLRE ( DBGSCLRE ),
  .DBGSCLRF ( DBGSCLRF ),
  .DBGSCLRG ( DBGSCLRG ),
  .DBGSCLRH ( DBGSCLRH ),
  .DBGSCLRI ( DBGSCLRI ),
  .DBGSCLRJ ( DBGSCLRJ ),
  .DBGSCLRK ( DBGSCLRK ),
  .DBGVECA ( DBGVECA ),
  .DBGVECB ( DBGVECB ),
  .DBGVECC ( DBGVECC ),
  .DRPDO ( PCIEDRPDO ),
  .DRPDRDY ( PCIEDRPDRDY ),
  .LL2BADDLLPERRN ( LL2BADDLLPERRN ),
  .LL2BADTLPERRN ( LL2BADTLPERRN ),
  .LL2PROTOCOLERRN ( LL2PROTOCOLERRN ),
  .LL2REPLAYROERRN ( LL2REPLAYROERRN ),
  .LL2REPLAYTOERRN ( LL2REPLAYTOERRN ),
  .LL2SUSPENDOKN ( LL2SUSPENDOKN ),
  .LL2TFCINIT1SEQN ( LL2TFCINIT1SEQN ),
  .LL2TFCINIT2SEQN ( LL2TFCINIT2SEQN ),
  .MIMRXRADDR ( MIMRXRADDR ),
  .MIMRXRCE ( MIMRXRCE ),
  .MIMRXREN ( MIMRXREN ),
  .MIMRXWADDR ( MIMRXWADDR ),
  .MIMRXWDATA ( MIMRXWDATA ),
  .MIMRXWEN ( MIMRXWEN ),
  .MIMTXRADDR ( MIMTXRADDR ),
  .MIMTXRCE ( MIMTXRCE ),
  .MIMTXREN ( MIMTXREN ),
  .MIMTXWADDR ( MIMTXWADDR ),
  .MIMTXWDATA ( MIMTXWDATA ),
  .MIMTXWEN ( MIMTXWEN ),
  .PIPERX0POLARITY ( PIPERX0POLARITY ),
  .PIPERX1POLARITY ( PIPERX1POLARITY ),
  .PIPERX2POLARITY ( PIPERX2POLARITY ),
  .PIPERX3POLARITY ( PIPERX3POLARITY ),
  .PIPERX4POLARITY ( PIPERX4POLARITY ),
  .PIPERX5POLARITY ( PIPERX5POLARITY ),
  .PIPERX6POLARITY ( PIPERX6POLARITY ),
  .PIPERX7POLARITY ( PIPERX7POLARITY ),
  .PIPETXDEEMPH ( PIPETXDEEMPH ),
  .PIPETXMARGIN ( PIPETXMARGIN ),
  .PIPETXRATE ( PIPETXRATE ),
  .PIPETXRCVRDET ( PIPETXRCVRDET ),
  .PIPETXRESET ( PIPETXRESET ),
  .PIPETX0CHARISK ( PIPETX0CHARISK ),
  .PIPETX0COMPLIANCE ( PIPETX0COMPLIANCE ),
  .PIPETX0DATA ( PIPETX0DATA ),
  .PIPETX0ELECIDLE ( PIPETX0ELECIDLE ),
  .PIPETX0POWERDOWN ( PIPETX0POWERDOWN ),
  .PIPETX1CHARISK ( PIPETX1CHARISK ),
  .PIPETX1COMPLIANCE ( PIPETX1COMPLIANCE ),
  .PIPETX1DATA ( PIPETX1DATA ),
  .PIPETX1ELECIDLE ( PIPETX1ELECIDLE ),
  .PIPETX1POWERDOWN ( PIPETX1POWERDOWN ),
  .PIPETX2CHARISK ( PIPETX2CHARISK ),
  .PIPETX2COMPLIANCE ( PIPETX2COMPLIANCE ),
  .PIPETX2DATA ( PIPETX2DATA ),
  .PIPETX2ELECIDLE ( PIPETX2ELECIDLE ),
  .PIPETX2POWERDOWN ( PIPETX2POWERDOWN ),
  .PIPETX3CHARISK ( PIPETX3CHARISK ),
  .PIPETX3COMPLIANCE ( PIPETX3COMPLIANCE ),
  .PIPETX3DATA ( PIPETX3DATA ),
  .PIPETX3ELECIDLE ( PIPETX3ELECIDLE ),
  .PIPETX3POWERDOWN ( PIPETX3POWERDOWN ),
  .PIPETX4CHARISK ( PIPETX4CHARISK ),
  .PIPETX4COMPLIANCE ( PIPETX4COMPLIANCE ),
  .PIPETX4DATA ( PIPETX4DATA ),
  .PIPETX4ELECIDLE ( PIPETX4ELECIDLE ),
  .PIPETX4POWERDOWN ( PIPETX4POWERDOWN ),
  .PIPETX5CHARISK ( PIPETX5CHARISK ),
  .PIPETX5COMPLIANCE ( PIPETX5COMPLIANCE ),
  .PIPETX5DATA ( PIPETX5DATA ),
  .PIPETX5ELECIDLE ( PIPETX5ELECIDLE ),
  .PIPETX5POWERDOWN ( PIPETX5POWERDOWN ),
  .PIPETX6CHARISK ( PIPETX6CHARISK ),
  .PIPETX6COMPLIANCE ( PIPETX6COMPLIANCE ),
  .PIPETX6DATA ( PIPETX6DATA ),
  .PIPETX6ELECIDLE ( PIPETX6ELECIDLE ),
  .PIPETX6POWERDOWN ( PIPETX6POWERDOWN ),
  .PIPETX7CHARISK ( PIPETX7CHARISK ),
  .PIPETX7COMPLIANCE ( PIPETX7COMPLIANCE ),
  .PIPETX7DATA ( PIPETX7DATA ),
  .PIPETX7ELECIDLE ( PIPETX7ELECIDLE ),
  .PIPETX7POWERDOWN ( PIPETX7POWERDOWN ),
  .PLDBGVEC ( PLDBGVEC ),
  .PLINITIALLINKWIDTH ( PLINITIALLINKWIDTH ),
  .PLLANEREVERSALMODE ( PLLANEREVERSALMODE ),
  .PLLINKGEN2CAP ( PLLINKGEN2CAP ),
  .PLLINKPARTNERGEN2SUPPORTED ( PLLINKPARTNERGEN2SUPPORTED ),
  .PLLINKUPCFGCAP ( PLLINKUPCFGCAP ),
  .PLLTSSMSTATE ( PLLTSSMSTATE ),
  .PLPHYLNKUPN ( PLPHYLNKUPN ),
  .PLRECEIVEDHOTRST ( PLRECEIVEDHOTRST ),
  .PLRXPMSTATE ( PLRXPMSTATE ),
  .PLSELLNKRATE ( PLSELLNKRATE ),
  .PLSELLNKWIDTH ( PLSELLNKWIDTH ),
  .PLTXPMSTATE ( PLTXPMSTATE ),
  .PL2LINKUPN ( PL2LINKUPN ),
  .PL2RECEIVERERRN ( PL2RECEIVERERRN ),
  .PL2RECOVERYN ( PL2RECOVERYN ),
  .PL2RXELECIDLE ( PL2RXELECIDLE ),
  .PL2SUSPENDOK ( PL2SUSPENDOK ),
  .RECEIVEDFUNCLVLRSTN ( RECEIVEDFUNCLVLRSTN ),
  .LNKCLKEN ( LNKCLKEN ),
  .TL2ASPMSUSPENDCREDITCHECKOKN ( TL2ASPMSUSPENDCREDITCHECKOKN ),
  .TL2ASPMSUSPENDREQN ( TL2ASPMSUSPENDREQN ),
  .TL2PPMSUSPENDOKN ( TL2PPMSUSPENDOKN ),
  .TRNFCCPLD ( TRNFCCPLD ),
  .TRNFCCPLH ( TRNFCCPLH ),
  .TRNFCNPD ( TRNFCNPD ),
  .TRNFCNPH ( TRNFCNPH ),
  .TRNFCPD ( TRNFCPD ),
  .TRNFCPH ( TRNFCPH ),
  .TRNLNKUPN ( TRNLNKUPN ),
  .TRNRBARHITN ( TRNRBARHITN ),
  .TRNRD ( TRNRD ),
  .TRNRDLLPDATA ( ),
  .TRNRDLLPSRCRDYN ( TRNRDLLPSRCRDYN ),
  .TRNRECRCERRN ( TRNRECRCERRN ),
  .TRNREOFN ( TRNREOFN ),
  .TRNRERRFWDN ( TRNRERRFWDN ),
  .TRNRREMN ( TRNRREMN ),
  .TRNRSOFN ( TRNRSOFN ),
  .TRNRSRCDSCN ( TRNRSRCDSCN ),
  .TRNRSRCRDYN ( TRNRSRCRDYN ),
  .TRNTBUFAV ( TRNTBUFAV ),
  .TRNTCFGREQN ( TRNTCFGREQN ),
  .TRNTDLLPDSTRDYN ( TRNTDLLPDSTRDYN ),
  .TRNTDSTRDYN ( TRNTDSTRDYN ),
  .TRNTERRDROPN ( TRNTERRDROPN ),
  .USERRSTN ( USERRSTN ),
  .CFGBYTEENN ( CFGBYTEENN ),
  .CFGDI ( CFGDI ),
  .CFGDSBUSNUMBER ( CFGDSBUSNUMBER ),
  .CFGDSDEVICENUMBER ( CFGDSDEVICENUMBER ),
  .CFGDSFUNCTIONNUMBER ( CFGDSFUNCTIONNUMBER ),
  .CFGDSN ( CFGDSN ),
  .CFGDWADDR ( CFGDWADDR ),
  .CFGERRACSN ( CFGERRACSN ),
  .CFGERRAERHEADERLOG ( CFGERRAERHEADERLOG ),
  .CFGERRCORN ( CFGERRCORN ),
  .CFGERRCPLABORTN ( CFGERRCPLABORTN ),
  .CFGERRCPLTIMEOUTN ( CFGERRCPLTIMEOUTN ),
  .CFGERRCPLUNEXPECTN ( CFGERRCPLUNEXPECTN ),
  .CFGERRECRCN ( CFGERRECRCN ),
  .CFGERRLOCKEDN ( CFGERRLOCKEDN ),
  .CFGERRPOSTEDN ( CFGERRPOSTEDN ),
  .CFGERRTLPCPLHEADER ( CFGERRTLPCPLHEADER ),
  .CFGERRURN ( CFGERRURN ),
  .CFGINTERRUPTASSERTN ( CFGINTERRUPTASSERTN ),
  .CFGINTERRUPTDI ( CFGINTERRUPTDI ),
  .CFGINTERRUPTN ( CFGINTERRUPTN ),
  .CFGPMDIRECTASPML1N ( CFGPMDIRECTASPML1N ),
  .CFGPMSENDPMACKN ( CFGPMSENDPMACKN ),
  .CFGPMSENDPMETON ( CFGPMSENDPMETON ),
  .CFGPMSENDPMNAKN ( CFGPMSENDPMNAKN ),
  .CFGPMTURNOFFOKN ( CFGPMTURNOFFOKN ),
  .CFGPMWAKEN ( CFGPMWAKEN ),
  .CFGPORTNUMBER ( CFGPORTNUMBER ),
  .CFGRDENN ( CFGRDENN ),
  .CFGTRNPENDINGN ( CFGTRNPENDINGN ),
  .CFGWRENN ( CFGWRENN ),
  .CFGWRREADONLYN ( CFGWRREADONLYN ),
  .CFGWRRW1CASRWN ( CFGWRRW1CASRWN ),
  .CMRSTN ( CMRSTN ),
  .CMSTICKYRSTN ( CMSTICKYRSTN ),
  .DBGMODE ( DBGMODE ),
  .DBGSUBMODE ( DBGSUBMODE ),
  .DLRSTN ( DLRSTN ),
  .DRPCLK ( PCIEDRPCLK ),
  .DRPDADDR ( PCIEDRPDADDR ),
  .DRPDEN ( PCIEDRPDEN ),
  .DRPDI ( PCIEDRPDI ),
  .DRPDWE ( PCIEDRPDWE ),
  .FUNCLVLRSTN ( FUNCLVLRSTN ),
  .LL2SENDASREQL1N ( LL2SENDASREQL1N ),
  .LL2SENDENTERL1N ( LL2SENDENTERL1N ),
  .LL2SENDENTERL23N ( LL2SENDENTERL23N ),
  .LL2SUSPENDNOWN ( LL2SUSPENDNOWN ),
  .LL2TLPRCVN ( LL2TLPRCVN ),
  .MIMRXRDATA ( MIMRXRDATA[67:0] ),
  .MIMTXRDATA ( MIMTXRDATA[68:0] ),
  .PIPECLK ( PIPECLK ),
  .PIPERX0CHANISALIGNED ( PIPERX0CHANISALIGNED ),
  .PIPERX0CHARISK ( filter_pipe_upconfig_fix_3451 ? 2'b11 : PIPERX0CHARISK ),
  .PIPERX0DATA ( PIPERX0DATA ),
  .PIPERX0ELECIDLE ( PIPERX0ELECIDLE ),
  .PIPERX0PHYSTATUS ( PIPERX0PHYSTATUS ),
  .PIPERX0STATUS ( PIPERX0STATUS ),
  .PIPERX0VALID ( PIPERX0VALID ),
  .PIPERX1CHANISALIGNED ( PIPERX1CHANISALIGNED ),
  .PIPERX1CHARISK ( filter_pipe_upconfig_fix_3451 ? 2'b11 : PIPERX1CHARISK ),
  .PIPERX1DATA ( PIPERX1DATA ),
  .PIPERX1ELECIDLE ( PIPERX1ELECIDLE ),
  .PIPERX1PHYSTATUS ( PIPERX1PHYSTATUS ),
  .PIPERX1STATUS ( PIPERX1STATUS ),
  .PIPERX1VALID ( PIPERX1VALID ),
  .PIPERX2CHANISALIGNED ( PIPERX2CHANISALIGNED ),
  .PIPERX2CHARISK ( filter_pipe_upconfig_fix_3451 ? 2'b11 : PIPERX2CHARISK ),
  .PIPERX2DATA ( PIPERX2DATA ),
  .PIPERX2ELECIDLE ( PIPERX2ELECIDLE ),
  .PIPERX2PHYSTATUS ( PIPERX2PHYSTATUS ),
  .PIPERX2STATUS ( PIPERX2STATUS ),
  .PIPERX2VALID ( PIPERX2VALID ),
  .PIPERX3CHANISALIGNED ( PIPERX3CHANISALIGNED ),
  .PIPERX3CHARISK ( filter_pipe_upconfig_fix_3451 ? 2'b11 : PIPERX3CHARISK ),
  .PIPERX3DATA ( PIPERX3DATA ),
  .PIPERX3ELECIDLE ( PIPERX3ELECIDLE ),
  .PIPERX3PHYSTATUS ( PIPERX3PHYSTATUS ),
  .PIPERX3STATUS ( PIPERX3STATUS ),
  .PIPERX3VALID ( PIPERX3VALID ),
  .PIPERX4CHANISALIGNED ( PIPERX4CHANISALIGNED ),
  .PIPERX4CHARISK ( filter_pipe_upconfig_fix_3451 ? 2'b11 : PIPERX4CHARISK ),
  .PIPERX4DATA ( PIPERX4DATA ),
  .PIPERX4ELECIDLE ( PIPERX4ELECIDLE ),
  .PIPERX4PHYSTATUS ( PIPERX4PHYSTATUS ),
  .PIPERX4STATUS ( PIPERX4STATUS ),
  .PIPERX4VALID ( PIPERX4VALID ),
  .PIPERX5CHANISALIGNED ( PIPERX5CHANISALIGNED ),
  .PIPERX5CHARISK ( filter_pipe_upconfig_fix_3451 ? 2'b11 : PIPERX5CHARISK ),
  .PIPERX5DATA ( PIPERX5DATA ),
  .PIPERX5ELECIDLE ( PIPERX5ELECIDLE ),
  .PIPERX5PHYSTATUS ( PIPERX5PHYSTATUS ),
  .PIPERX5STATUS ( PIPERX5STATUS ),
  .PIPERX5VALID ( PIPERX5VALID ),
  .PIPERX6CHANISALIGNED ( PIPERX6CHANISALIGNED ),
  .PIPERX6CHARISK ( filter_pipe_upconfig_fix_3451 ? 2'b11 : PIPERX6CHARISK ),
  .PIPERX6DATA ( PIPERX6DATA ),
  .PIPERX6ELECIDLE ( PIPERX6ELECIDLE ),
  .PIPERX6PHYSTATUS ( PIPERX6PHYSTATUS ),
  .PIPERX6STATUS ( PIPERX6STATUS ),
  .PIPERX6VALID ( PIPERX6VALID ),
  .PIPERX7CHANISALIGNED ( PIPERX7CHANISALIGNED ),
  .PIPERX7CHARISK ( filter_pipe_upconfig_fix_3451 ? 2'b11 : PIPERX7CHARISK ),
  .PIPERX7DATA ( PIPERX7DATA ),
  .PIPERX7ELECIDLE ( PIPERX7ELECIDLE ),
  .PIPERX7PHYSTATUS ( PIPERX7PHYSTATUS ),
  .PIPERX7STATUS ( PIPERX7STATUS ),
  .PIPERX7VALID ( PIPERX7VALID ),
  .PLDBGMODE ( PLDBGMODE ),
  .PLDIRECTEDLINKAUTON ( PLDIRECTEDLINKAUTON ),
  .PLDIRECTEDLINKCHANGE ( PLDIRECTEDLINKCHANGE ),
  .PLDIRECTEDLINKSPEED ( PLDIRECTEDLINKSPEED ),
  .PLDIRECTEDLINKWIDTH ( PLDIRECTEDLINKWIDTH ),
  .PLDOWNSTREAMDEEMPHSOURCE ( PLDOWNSTREAMDEEMPHSOURCE ),
  .PLRSTN ( PLRSTN ),
  .PLTRANSMITHOTRST ( PLTRANSMITHOTRST ),
  .PLUPSTREAMPREFERDEEMPH ( PLUPSTREAMPREFERDEEMPH ),
  .PL2DIRECTEDLSTATE ( PL2DIRECTEDLSTATE ),
  .SYSRSTN ( SYSRSTN ),
  .TLRSTN ( TLRSTN ),
  .TL2ASPMSUSPENDCREDITCHECKN ( 1'b1),
  .TL2PPMSUSPENDREQN ( 1'b1 ),
  .TRNFCSEL ( TRNFCSEL ),
  .TRNRDSTRDYN ( TRNRDSTRDYN ),
  .TRNRNPOKN ( TRNRNPOKN ),
  .TRNTCFGGNTN ( TRNTCFGGNTN ),
  .TRNTD ( TRNTD ),
  .TRNTDLLPDATA ( TRNTDLLPDATA ),
  .TRNTDLLPSRCRDYN ( TRNTDLLPSRCRDYN ),
  .TRNTECRCGENN ( TRNTECRCGENN ),
  .TRNTEOFN ( TRNTEOFN ),
  .TRNTERRFWDN ( TRNTERRFWDN ),
  .TRNTREMN ( TRNTREMN ),
  .TRNTSOFN ( TRNTSOFN ),
  .TRNTSRCDSCN ( TRNTSRCDSCN ),
  .TRNTSRCRDYN ( TRNTSRCRDYN ),
  .TRNTSTRN ( TRNTSTRN ),
  .USERCLK ( USERCLK )

);

//-------------------------------------------------------
// Virtex6 PIPE Module
//-------------------------------------------------------

pcie_pipe_v6 # (

   .NO_OF_LANES(LINK_CAP_MAX_LINK_WIDTH),
   .LINK_CAP_MAX_LINK_SPEED(LINK_CAP_MAX_LINK_SPEED),
   .PIPE_PIPELINE_STAGES(PIPE_PIPELINE_STAGES)

)
pcie_pipe_i (

  // Pipe Per-Link Signals
  .pipe_tx_rcvr_det_i       (PIPETXRCVRDET),
  .pipe_tx_reset_i          (PIPETXRESET),
  .pipe_tx_rate_i           (PIPETXRATE),
  .pipe_tx_deemph_i         (PIPETXDEEMPH),
  .pipe_tx_margin_i         (PIPETXMARGIN),
  .pipe_tx_swing_i          (1'b0),

  .pipe_tx_rcvr_det_o       (PIPETXRCVRDETGT),
  .pipe_tx_reset_o          ( ),
  .pipe_tx_rate_o           (PIPETXRATEGT),
  .pipe_tx_deemph_o         (PIPETXDEEMPHGT),
  .pipe_tx_margin_o         (PIPETXMARGINGT),
  .pipe_tx_swing_o          ( ),

  // Pipe Per-Lane Signals - Lane 0
  .pipe_rx0_char_is_k_o     (PIPERX0CHARISK         ),
  .pipe_rx0_data_o          (PIPERX0DATA            ),
  .pipe_rx0_valid_o         (PIPERX0VALID           ),
  .pipe_rx0_chanisaligned_o (PIPERX0CHANISALIGNED   ),
  .pipe_rx0_status_o        (PIPERX0STATUS          ),
  .pipe_rx0_phy_status_o    (PIPERX0PHYSTATUS       ),
  .pipe_rx0_elec_idle_i     (PIPERX0ELECIDLEGT      ),
  .pipe_rx0_polarity_i      (PIPERX0POLARITY        ),
  .pipe_tx0_compliance_i    (PIPETX0COMPLIANCE      ),
  .pipe_tx0_char_is_k_i     (PIPETX0CHARISK         ),
  .pipe_tx0_data_i          (PIPETX0DATA            ),
  .pipe_tx0_elec_idle_i     (PIPETX0ELECIDLE        ),
  .pipe_tx0_powerdown_i     (PIPETX0POWERDOWN       ),

  .pipe_rx0_char_is_k_i     (PIPERX0CHARISKGT       ),
  .pipe_rx0_data_i          (PIPERX0DATAGT          ),
  .pipe_rx0_valid_i         (PIPERX0VALIDGT         ),
  .pipe_rx0_chanisaligned_i (PIPERX0CHANISALIGNEDGT ),
  .pipe_rx0_status_i        (PIPERX0STATUSGT        ),
  .pipe_rx0_phy_status_i    (PIPERX0PHYSTATUSGT     ),
  .pipe_rx0_elec_idle_o     (PIPERX0ELECIDLE        ),
  .pipe_rx0_polarity_o      (PIPERX0POLARITYGT      ),
  .pipe_tx0_compliance_o    (PIPETX0COMPLIANCEGT    ),
  .pipe_tx0_char_is_k_o     (PIPETX0CHARISKGT       ),
  .pipe_tx0_data_o          (PIPETX0DATAGT          ),
  .pipe_tx0_elec_idle_o     (PIPETX0ELECIDLEGT      ),
  .pipe_tx0_powerdown_o     (PIPETX0POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 1
  .pipe_rx1_char_is_k_o     (PIPERX1CHARISK         ),
  .pipe_rx1_data_o          (PIPERX1DATA            ),
  .pipe_rx1_valid_o         (PIPERX1VALID           ),
  .pipe_rx1_chanisaligned_o (PIPERX1CHANISALIGNED   ),
  .pipe_rx1_status_o        (PIPERX1STATUS          ),
  .pipe_rx1_phy_status_o    (PIPERX1PHYSTATUS       ),
  .pipe_rx1_elec_idle_i     (PIPERX1ELECIDLEGT      ),
  .pipe_rx1_polarity_i      (PIPERX1POLARITY        ),
  .pipe_tx1_compliance_i    (PIPETX1COMPLIANCE      ),
  .pipe_tx1_char_is_k_i     (PIPETX1CHARISK         ),
  .pipe_tx1_data_i          (PIPETX1DATA            ),
  .pipe_tx1_elec_idle_i     (PIPETX1ELECIDLE        ),
  .pipe_tx1_powerdown_i     (PIPETX1POWERDOWN       ),

  .pipe_rx1_char_is_k_i     (PIPERX1CHARISKGT       ),
  .pipe_rx1_data_i          (PIPERX1DATAGT          ),
  .pipe_rx1_valid_i         (PIPERX1VALIDGT         ),
  .pipe_rx1_chanisaligned_i (PIPERX1CHANISALIGNEDGT ),
  .pipe_rx1_status_i        (PIPERX1STATUSGT        ),
  .pipe_rx1_phy_status_i    (PIPERX1PHYSTATUSGT     ),
  .pipe_rx1_elec_idle_o     (PIPERX1ELECIDLE        ),
  .pipe_rx1_polarity_o      (PIPERX1POLARITYGT      ),
  .pipe_tx1_compliance_o    (PIPETX1COMPLIANCEGT    ),
  .pipe_tx1_char_is_k_o     (PIPETX1CHARISKGT       ),
  .pipe_tx1_data_o          (PIPETX1DATAGT          ),
  .pipe_tx1_elec_idle_o     (PIPETX1ELECIDLEGT      ),
  .pipe_tx1_powerdown_o     (PIPETX1POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 2
  .pipe_rx2_char_is_k_o     (PIPERX2CHARISK         ),
  .pipe_rx2_data_o          (PIPERX2DATA            ),
  .pipe_rx2_valid_o         (PIPERX2VALID           ),
  .pipe_rx2_chanisaligned_o (PIPERX2CHANISALIGNED   ),
  .pipe_rx2_status_o        (PIPERX2STATUS          ),
  .pipe_rx2_phy_status_o    (PIPERX2PHYSTATUS       ),
  .pipe_rx2_elec_idle_i     (PIPERX2ELECIDLEGT      ),
  .pipe_rx2_polarity_i      (PIPERX2POLARITY        ),
  .pipe_tx2_compliance_i    (PIPETX2COMPLIANCE      ),
  .pipe_tx2_char_is_k_i     (PIPETX2CHARISK         ),
  .pipe_tx2_data_i          (PIPETX2DATA            ),
  .pipe_tx2_elec_idle_i     (PIPETX2ELECIDLE        ),
  .pipe_tx2_powerdown_i     (PIPETX2POWERDOWN       ),

  .pipe_rx2_char_is_k_i     (PIPERX2CHARISKGT       ),
  .pipe_rx2_data_i          (PIPERX2DATAGT          ),
  .pipe_rx2_valid_i         (PIPERX2VALIDGT         ),
  .pipe_rx2_chanisaligned_i (PIPERX2CHANISALIGNEDGT ),
  .pipe_rx2_status_i        (PIPERX2STATUSGT        ),
  .pipe_rx2_phy_status_i    (PIPERX2PHYSTATUSGT     ),
  .pipe_rx2_elec_idle_o     (PIPERX2ELECIDLE        ),
  .pipe_rx2_polarity_o      (PIPERX2POLARITYGT      ),
  .pipe_tx2_compliance_o    (PIPETX2COMPLIANCEGT    ),
  .pipe_tx2_char_is_k_o     (PIPETX2CHARISKGT       ),
  .pipe_tx2_data_o          (PIPETX2DATAGT          ),
  .pipe_tx2_elec_idle_o     (PIPETX2ELECIDLEGT      ),
  .pipe_tx2_powerdown_o     (PIPETX2POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 3
  .pipe_rx3_char_is_k_o     (PIPERX3CHARISK         ),
  .pipe_rx3_data_o          (PIPERX3DATA            ),
  .pipe_rx3_valid_o         (PIPERX3VALID           ),
  .pipe_rx3_chanisaligned_o (PIPERX3CHANISALIGNED   ),
  .pipe_rx3_status_o        (PIPERX3STATUS          ),
  .pipe_rx3_phy_status_o    (PIPERX3PHYSTATUS       ),
  .pipe_rx3_elec_idle_i     (PIPERX3ELECIDLEGT      ),
  .pipe_rx3_polarity_i      (PIPERX3POLARITY        ),
  .pipe_tx3_compliance_i    (PIPETX3COMPLIANCE      ),
  .pipe_tx3_char_is_k_i     (PIPETX3CHARISK         ),
  .pipe_tx3_data_i          (PIPETX3DATA            ),
  .pipe_tx3_elec_idle_i     (PIPETX3ELECIDLE        ),
  .pipe_tx3_powerdown_i     (PIPETX3POWERDOWN       ),

  .pipe_rx3_char_is_k_i     (PIPERX3CHARISKGT       ),
  .pipe_rx3_data_i          (PIPERX3DATAGT          ),
  .pipe_rx3_valid_i         (PIPERX3VALIDGT         ),
  .pipe_rx3_chanisaligned_i (PIPERX3CHANISALIGNEDGT ),
  .pipe_rx3_status_i        (PIPERX3STATUSGT        ),
  .pipe_rx3_phy_status_i    (PIPERX3PHYSTATUSGT     ),
  .pipe_rx3_elec_idle_o     (PIPERX3ELECIDLE        ),
  .pipe_rx3_polarity_o      (PIPERX3POLARITYGT      ),
  .pipe_tx3_compliance_o    (PIPETX3COMPLIANCEGT    ),
  .pipe_tx3_char_is_k_o     (PIPETX3CHARISKGT       ),
  .pipe_tx3_data_o          (PIPETX3DATAGT          ),
  .pipe_tx3_elec_idle_o     (PIPETX3ELECIDLEGT      ),
  .pipe_tx3_powerdown_o     (PIPETX3POWERDOWNGT     ),

   // Pipe Per-Lane Signals - Lane 4
  .pipe_rx4_char_is_k_o     (PIPERX4CHARISK         ),
  .pipe_rx4_data_o          (PIPERX4DATA            ),
  .pipe_rx4_valid_o         (PIPERX4VALID           ),
  .pipe_rx4_chanisaligned_o (PIPERX4CHANISALIGNED   ),
  .pipe_rx4_status_o        (PIPERX4STATUS          ),
  .pipe_rx4_phy_status_o    (PIPERX4PHYSTATUS       ),
  .pipe_rx4_elec_idle_i     (PIPERX4ELECIDLEGT      ),
  .pipe_rx4_polarity_i      (PIPERX4POLARITY        ),
  .pipe_tx4_compliance_i    (PIPETX4COMPLIANCE      ),
  .pipe_tx4_char_is_k_i     (PIPETX4CHARISK         ),
  .pipe_tx4_data_i          (PIPETX4DATA            ),
  .pipe_tx4_elec_idle_i     (PIPETX4ELECIDLE        ),
  .pipe_tx4_powerdown_i     (PIPETX4POWERDOWN       ),

  .pipe_rx4_char_is_k_i     (PIPERX4CHARISKGT       ),
  .pipe_rx4_data_i          (PIPERX4DATAGT          ),
  .pipe_rx4_valid_i         (PIPERX4VALIDGT         ),
  .pipe_rx4_chanisaligned_i (PIPERX4CHANISALIGNEDGT ),
  .pipe_rx4_status_i        (PIPERX4STATUSGT        ),
  .pipe_rx4_phy_status_i    (PIPERX4PHYSTATUSGT     ),
  .pipe_rx4_elec_idle_o     (PIPERX4ELECIDLE        ),
  .pipe_rx4_polarity_o      (PIPERX4POLARITYGT      ),
  .pipe_tx4_compliance_o    (PIPETX4COMPLIANCEGT    ),
  .pipe_tx4_char_is_k_o     (PIPETX4CHARISKGT       ),
  .pipe_tx4_data_o          (PIPETX4DATAGT          ),
  .pipe_tx4_elec_idle_o     (PIPETX4ELECIDLEGT      ),
  .pipe_tx4_powerdown_o     (PIPETX4POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 5
  .pipe_rx5_char_is_k_o     (PIPERX5CHARISK         ),
  .pipe_rx5_data_o          (PIPERX5DATA            ),
  .pipe_rx5_valid_o         (PIPERX5VALID           ),
  .pipe_rx5_chanisaligned_o (PIPERX5CHANISALIGNED   ),
  .pipe_rx5_status_o        (PIPERX5STATUS          ),
  .pipe_rx5_phy_status_o    (PIPERX5PHYSTATUS       ),
  .pipe_rx5_elec_idle_i     (PIPERX5ELECIDLEGT      ),
  .pipe_rx5_polarity_i      (PIPERX5POLARITY        ),
  .pipe_tx5_compliance_i    (PIPETX5COMPLIANCE      ),
  .pipe_tx5_char_is_k_i     (PIPETX5CHARISK         ),
  .pipe_tx5_data_i          (PIPETX5DATA            ),
  .pipe_tx5_elec_idle_i     (PIPETX5ELECIDLE        ),
  .pipe_tx5_powerdown_i     (PIPETX5POWERDOWN       ),

  .pipe_rx5_char_is_k_i     (PIPERX5CHARISKGT       ),
  .pipe_rx5_data_i          (PIPERX5DATAGT          ),
  .pipe_rx5_valid_i         (PIPERX5VALIDGT         ),
  .pipe_rx5_chanisaligned_i (PIPERX5CHANISALIGNEDGT ),
  .pipe_rx5_status_i        (PIPERX5STATUSGT        ),
  .pipe_rx5_phy_status_i    (PIPERX5PHYSTATUSGT     ),
  .pipe_rx5_elec_idle_o     (PIPERX5ELECIDLE        ),
  .pipe_rx5_polarity_o      (PIPERX5POLARITYGT      ),
  .pipe_tx5_compliance_o    (PIPETX5COMPLIANCEGT    ),
  .pipe_tx5_char_is_k_o     (PIPETX5CHARISKGT       ),
  .pipe_tx5_data_o          (PIPETX5DATAGT          ),
  .pipe_tx5_elec_idle_o     (PIPETX5ELECIDLEGT      ),
  .pipe_tx5_powerdown_o     (PIPETX5POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 6
  .pipe_rx6_char_is_k_o     (PIPERX6CHARISK         ),
  .pipe_rx6_data_o          (PIPERX6DATA            ),
  .pipe_rx6_valid_o         (PIPERX6VALID           ),
  .pipe_rx6_chanisaligned_o (PIPERX6CHANISALIGNED   ),
  .pipe_rx6_status_o        (PIPERX6STATUS          ),
  .pipe_rx6_phy_status_o    (PIPERX6PHYSTATUS       ),
  .pipe_rx6_elec_idle_i     (PIPERX6ELECIDLEGT      ),
  .pipe_rx6_polarity_i      (PIPERX6POLARITY        ),
  .pipe_tx6_compliance_i    (PIPETX6COMPLIANCE      ),
  .pipe_tx6_char_is_k_i     (PIPETX6CHARISK         ),
  .pipe_tx6_data_i          (PIPETX6DATA            ),
  .pipe_tx6_elec_idle_i     (PIPETX6ELECIDLE        ),
  .pipe_tx6_powerdown_i     (PIPETX6POWERDOWN       ),

  .pipe_rx6_char_is_k_i     (PIPERX6CHARISKGT       ),
  .pipe_rx6_data_i          (PIPERX6DATAGT          ),
  .pipe_rx6_valid_i         (PIPERX6VALIDGT         ),
  .pipe_rx6_chanisaligned_i (PIPERX6CHANISALIGNEDGT ),
  .pipe_rx6_status_i        (PIPERX6STATUSGT        ),
  .pipe_rx6_phy_status_i    (PIPERX6PHYSTATUSGT     ),
  .pipe_rx6_elec_idle_o     (PIPERX6ELECIDLE        ),
  .pipe_rx6_polarity_o      (PIPERX6POLARITYGT      ),
  .pipe_tx6_compliance_o    (PIPETX6COMPLIANCEGT    ),
  .pipe_tx6_char_is_k_o     (PIPETX6CHARISKGT       ),
  .pipe_tx6_data_o          (PIPETX6DATAGT          ),
  .pipe_tx6_elec_idle_o     (PIPETX6ELECIDLEGT      ),
  .pipe_tx6_powerdown_o     (PIPETX6POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 7
  .pipe_rx7_char_is_k_o     (PIPERX7CHARISK         ),
  .pipe_rx7_data_o          (PIPERX7DATA            ),
  .pipe_rx7_valid_o         (PIPERX7VALID           ),
  .pipe_rx7_chanisaligned_o (PIPERX7CHANISALIGNED   ),
  .pipe_rx7_status_o        (PIPERX7STATUS          ),
  .pipe_rx7_phy_status_o    (PIPERX7PHYSTATUS       ),
  .pipe_rx7_elec_idle_i     (PIPERX7ELECIDLEGT      ),
  .pipe_rx7_polarity_i      (PIPERX7POLARITY        ),
  .pipe_tx7_compliance_i    (PIPETX7COMPLIANCE      ),
  .pipe_tx7_char_is_k_i     (PIPETX7CHARISK         ),
  .pipe_tx7_data_i          (PIPETX7DATA            ),
  .pipe_tx7_elec_idle_i     (PIPETX7ELECIDLE        ),
  .pipe_tx7_powerdown_i     (PIPETX7POWERDOWN       ),

  .pipe_rx7_char_is_k_i     (PIPERX7CHARISKGT       ),
  .pipe_rx7_data_i          (PIPERX7DATAGT          ),
  .pipe_rx7_valid_i         (PIPERX7VALIDGT         ),
  .pipe_rx7_chanisaligned_i (PIPERX7CHANISALIGNEDGT ),
  .pipe_rx7_status_i        (PIPERX7STATUSGT        ),
  .pipe_rx7_phy_status_i    (PIPERX7PHYSTATUSGT     ),
  .pipe_rx7_elec_idle_o     (PIPERX7ELECIDLE        ),
  .pipe_rx7_polarity_o      (PIPERX7POLARITYGT      ),
  .pipe_tx7_compliance_o    (PIPETX7COMPLIANCEGT    ),
  .pipe_tx7_char_is_k_o     (PIPETX7CHARISKGT       ),
  .pipe_tx7_data_o          (PIPETX7DATAGT          ),
  .pipe_tx7_elec_idle_o     (PIPETX7ELECIDLEGT      ),
  .pipe_tx7_powerdown_o     (PIPETX7POWERDOWNGT     ),

  // Non PIPE signals
  .pl_ltssm_state           (PLLTSSMSTATE           ),
  .pipe_clk                 (PIPECLK                ),
  .rst_n                    (PHYRDYN                )
);

//-------------------------------------------------------
// Virtex6 GTX Module
//-------------------------------------------------------

pcie_gtx_v6 #(

  .NO_OF_LANES(LINK_CAP_MAX_LINK_WIDTH),
  .LINK_CAP_MAX_LINK_SPEED(LINK_CAP_MAX_LINK_SPEED),
  .REF_CLK_FREQ(REF_CLK_FREQ),
  .PL_FAST_TRAIN(PL_FAST_TRAIN)

)
pcie_gt_i (

  // Pipe Common Signals
  .pipe_tx_rcvr_det         (PIPETXRCVRDETGT        ),
  .pipe_tx_reset            (1'b0                   ),
  .pipe_tx_rate             (PIPETXRATEGT           ),
  .pipe_tx_deemph           (PIPETXDEEMPHGT         ),
  .pipe_tx_margin           (PIPETXMARGINGT         ),
  .pipe_tx_swing            (1'b0),

  // Pipe Per-Lane Signals - Lane 0
  .pipe_rx0_char_is_k       (PIPERX0CHARISKGT       ),
  .pipe_rx0_data            (PIPERX0DATAGT          ),
  .pipe_rx0_valid           (PIPERX0VALIDGT         ),
  .pipe_rx0_chanisaligned   (PIPERX0CHANISALIGNEDGT ),
  .pipe_rx0_status          (PIPERX0STATUSGT        ),
  .pipe_rx0_phy_status      (PIPERX0PHYSTATUSGT     ),
  .pipe_rx0_elec_idle       (PIPERX0ELECIDLEGT      ),
  .pipe_rx0_polarity        (PIPERX0POLARITYGT      ),
  .pipe_tx0_compliance      (PIPETX0COMPLIANCEGT    ),
  .pipe_tx0_char_is_k       (PIPETX0CHARISKGT       ),
  .pipe_tx0_data            (PIPETX0DATAGT          ),
  .pipe_tx0_elec_idle       (PIPETX0ELECIDLEGT      ),
  .pipe_tx0_powerdown       (PIPETX0POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 1
  .pipe_rx1_char_is_k       (PIPERX1CHARISKGT       ),
  .pipe_rx1_data            (PIPERX1DATAGT          ),
  .pipe_rx1_valid           (PIPERX1VALIDGT         ),
  .pipe_rx1_chanisaligned   (PIPERX1CHANISALIGNEDGT ),
  .pipe_rx1_status          (PIPERX1STATUSGT        ),
  .pipe_rx1_phy_status      (PIPERX1PHYSTATUSGT     ),
  .pipe_rx1_elec_idle       (PIPERX1ELECIDLEGT      ),
  .pipe_rx1_polarity        (PIPERX1POLARITYGT      ),
  .pipe_tx1_compliance      (PIPETX1COMPLIANCEGT    ),
  .pipe_tx1_char_is_k       (PIPETX1CHARISKGT       ),
  .pipe_tx1_data            (PIPETX1DATAGT          ),
  .pipe_tx1_elec_idle       (PIPETX1ELECIDLEGT      ),
  .pipe_tx1_powerdown       (PIPETX1POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 2
  .pipe_rx2_char_is_k       (PIPERX2CHARISKGT       ),
  .pipe_rx2_data            (PIPERX2DATAGT          ),
  .pipe_rx2_valid           (PIPERX2VALIDGT         ),
  .pipe_rx2_chanisaligned   (PIPERX2CHANISALIGNEDGT ),
  .pipe_rx2_status          (PIPERX2STATUSGT        ),
  .pipe_rx2_phy_status      (PIPERX2PHYSTATUSGT     ),
  .pipe_rx2_elec_idle       (PIPERX2ELECIDLEGT      ),
  .pipe_rx2_polarity        (PIPERX2POLARITYGT      ),
  .pipe_tx2_compliance      (PIPETX2COMPLIANCEGT    ),
  .pipe_tx2_char_is_k       (PIPETX2CHARISKGT       ),
  .pipe_tx2_data            (PIPETX2DATAGT          ),
  .pipe_tx2_elec_idle       (PIPETX2ELECIDLEGT      ),
  .pipe_tx2_powerdown       (PIPETX2POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 3
  .pipe_rx3_char_is_k       (PIPERX3CHARISKGT       ),
  .pipe_rx3_data            (PIPERX3DATAGT          ),
  .pipe_rx3_valid           (PIPERX3VALIDGT         ),
  .pipe_rx3_chanisaligned   (PIPERX3CHANISALIGNEDGT ),
  .pipe_rx3_status          (PIPERX3STATUSGT        ),
  .pipe_rx3_phy_status      (PIPERX3PHYSTATUSGT     ),
  .pipe_rx3_elec_idle       (PIPERX3ELECIDLEGT      ),
  .pipe_rx3_polarity        (PIPERX3POLARITYGT      ),
  .pipe_tx3_compliance      (PIPETX3COMPLIANCEGT    ),
  .pipe_tx3_char_is_k       (PIPETX3CHARISKGT       ),
  .pipe_tx3_data            (PIPETX3DATAGT          ),
  .pipe_tx3_elec_idle       (PIPETX3ELECIDLEGT      ),
  .pipe_tx3_powerdown       (PIPETX3POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 4
  .pipe_rx4_char_is_k       (PIPERX4CHARISKGT       ),
  .pipe_rx4_data            (PIPERX4DATAGT          ),
  .pipe_rx4_valid           (PIPERX4VALIDGT         ),
  .pipe_rx4_chanisaligned   (PIPERX4CHANISALIGNEDGT ),
  .pipe_rx4_status          (PIPERX4STATUSGT        ),
  .pipe_rx4_phy_status      (PIPERX4PHYSTATUSGT     ),
  .pipe_rx4_elec_idle       (PIPERX4ELECIDLEGT      ),
  .pipe_rx4_polarity        (PIPERX4POLARITYGT      ),
  .pipe_tx4_compliance      (PIPETX4COMPLIANCEGT    ),
  .pipe_tx4_char_is_k       (PIPETX4CHARISKGT       ),
  .pipe_tx4_data            (PIPETX4DATAGT          ),
  .pipe_tx4_elec_idle       (PIPETX4ELECIDLEGT      ),
  .pipe_tx4_powerdown       (PIPETX4POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 5
  .pipe_rx5_char_is_k       (PIPERX5CHARISKGT       ),
  .pipe_rx5_data            (PIPERX5DATAGT          ),
  .pipe_rx5_valid           (PIPERX5VALIDGT         ),
  .pipe_rx5_chanisaligned   (PIPERX5CHANISALIGNEDGT ),
  .pipe_rx5_status          (PIPERX5STATUSGT        ),
  .pipe_rx5_phy_status      (PIPERX5PHYSTATUSGT     ),
  .pipe_rx5_elec_idle       (PIPERX5ELECIDLEGT      ),
  .pipe_rx5_polarity        (PIPERX5POLARITYGT      ),
  .pipe_tx5_compliance      (PIPETX5COMPLIANCEGT    ),
  .pipe_tx5_char_is_k       (PIPETX5CHARISKGT       ),
  .pipe_tx5_data            (PIPETX5DATAGT          ),
  .pipe_tx5_elec_idle       (PIPETX5ELECIDLEGT      ),
  .pipe_tx5_powerdown       (PIPETX5POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 6
  .pipe_rx6_char_is_k       (PIPERX6CHARISKGT       ),
  .pipe_rx6_data            (PIPERX6DATAGT          ),
  .pipe_rx6_valid           (PIPERX6VALIDGT         ),
  .pipe_rx6_chanisaligned   (PIPERX6CHANISALIGNEDGT ),
  .pipe_rx6_status          (PIPERX6STATUSGT        ),
  .pipe_rx6_phy_status      (PIPERX6PHYSTATUSGT     ),
  .pipe_rx6_elec_idle       (PIPERX6ELECIDLEGT      ),
  .pipe_rx6_polarity        (PIPERX6POLARITYGT      ),
  .pipe_tx6_compliance      (PIPETX6COMPLIANCEGT    ),
  .pipe_tx6_char_is_k       (PIPETX6CHARISKGT       ),
  .pipe_tx6_data            (PIPETX6DATAGT          ),
  .pipe_tx6_elec_idle       (PIPETX6ELECIDLEGT      ),
  .pipe_tx6_powerdown       (PIPETX6POWERDOWNGT     ),

  // Pipe Per-Lane Signals - Lane 7
  .pipe_rx7_char_is_k       (PIPERX7CHARISKGT       ),
  .pipe_rx7_data            (PIPERX7DATAGT          ),
  .pipe_rx7_valid           (PIPERX7VALIDGT         ),
  .pipe_rx7_chanisaligned   (PIPERX7CHANISALIGNEDGT ),
  .pipe_rx7_status          (PIPERX7STATUSGT        ),
  .pipe_rx7_phy_status      (PIPERX7PHYSTATUSGT     ),
  .pipe_rx7_elec_idle       (PIPERX7ELECIDLEGT      ),
  .pipe_rx7_polarity        (PIPERX7POLARITYGT      ),
  .pipe_tx7_compliance      (PIPETX7COMPLIANCEGT    ),
  .pipe_tx7_char_is_k       (PIPETX7CHARISKGT       ),
  .pipe_tx7_data            (PIPETX7DATAGT          ),
  .pipe_tx7_elec_idle       (PIPETX7ELECIDLEGT      ),
  .pipe_tx7_powerdown       (PIPETX7POWERDOWNGT     ),

  // PCI Express Signals
  .pci_exp_txn              (PCIEXPTXN            ),
  .pci_exp_txp              (PCIEXPTXP            ),
  .pci_exp_rxn              (PCIEXPRXN            ),
  .pci_exp_rxp              (PCIEXPRXP            ),

  // Non PIPE Signals
  .sys_clk                  (SYSCLK               ),
  .sys_rst_n                (FUNDRSTN             ),
  .pipe_clk                 (PIPECLK              ),
  .drp_clk                  (DRPCLK               ),
  .clock_locked             (CLOCKLOCKED          ),
  .pl_ltssm_state           (PLLTSSMSTATE         ),

  .gt_pll_lock              (GTPLLLOCK            ),
  .phy_rdy_n                (PHYRDYN              ),
  .TxOutClk                 (TxOutClk             )

);

//-------------------------------------------------------
// PCI Express BRAM Module
//-------------------------------------------------------

pcie_bram_top_v6 #(

  .DEV_CAP_MAX_PAYLOAD_SUPPORTED(DEV_CAP_MAX_PAYLOAD_SUPPORTED),

  .VC0_TX_LASTPACKET(VC0_TX_LASTPACKET),
  .TL_TX_RAM_RADDR_LATENCY(TL_TX_RAM_RADDR_LATENCY),
  .TL_TX_RAM_RDATA_LATENCY(TL_TX_RAM_RDATA_LATENCY),
  .TL_TX_RAM_WRITE_LATENCY(TL_TX_RAM_WRITE_LATENCY),

  .VC0_RX_LIMIT(VC0_RX_RAM_LIMIT),
  .TL_RX_RAM_RADDR_LATENCY(TL_RX_RAM_RADDR_LATENCY),
  .TL_RX_RAM_RDATA_LATENCY(TL_RX_RAM_RDATA_LATENCY),
  .TL_RX_RAM_WRITE_LATENCY(TL_RX_RAM_WRITE_LATENCY)

)
pcie_bram_i (

  .user_clk_i( USERCLK ),
  .reset_i( PHYRDYN ),

  .mim_tx_waddr( MIMTXWADDR ),
  .mim_tx_wen( MIMTXWEN ),
  .mim_tx_ren( MIMTXREN ),
  .mim_tx_rce( MIMTXRCE ),
  .mim_tx_wdata( {3'b0, MIMTXWDATA} ),
  .mim_tx_raddr( MIMTXRADDR ),
  .mim_tx_rdata( MIMTXRDATA ),

  .mim_rx_waddr( MIMRXWADDR ),
  .mim_rx_wen( MIMRXWEN ),
  .mim_rx_ren( MIMRXREN ),
  .mim_rx_rce( MIMRXRCE ),
  .mim_rx_wdata( {4'b0, MIMRXWDATA} ),
  .mim_rx_raddr( MIMRXRADDR ),
  .mim_rx_rdata( MIMRXRDATA )

);


//-------------------------------------------------------
// PCI Express Port Workarounds
//-------------------------------------------------------

pcie_upconfig_fix_3451_v6 # (

  .UPSTREAM_FACING ( UPSTREAM_FACING ),
  .PL_FAST_TRAIN ( PL_FAST_TRAIN ),
  .LINK_CAP_MAX_LINK_WIDTH ( LINK_CAP_MAX_LINK_WIDTH )

)
pcie_upconfig_fix_3451_v6_i (

  .pipe_clk(PIPECLK),
  .pl_phy_lnkup_n(PLPHYLNKUPN),

  .pl_ltssm_state(PLLTSSMSTATE),
  .pl_sel_lnk_rate(PLSELLNKRATE),
  .pl_directed_link_change(PLDIRECTEDLINKCHANGE),

  .cfg_link_status_negotiated_width(CFGLINKSTATUSNEGOTIATEDWIDTH),
  .pipe_rx0_data(PIPERX0DATAGT[15:0]),
  .pipe_rx0_char_isk(PIPERX0CHARISKGT[1:0]),

  .filter_pipe(filter_pipe_upconfig_fix_3451)

);

endmodule
