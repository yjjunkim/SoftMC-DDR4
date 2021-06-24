-makelib xcelium_lib/xpm -sv \
  "D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/microblaze_v11_0_4 \
  "../../../ipstatic/hdl/microblaze_v11_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_0/sim/bd_9054_microblaze_I_0.vhd" \
-endlib
-makelib xcelium_lib/lib_cdc_v1_0_2 \
  "../../../ipstatic/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/proc_sys_reset_v5_0_13 \
  "../../../ipstatic/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_1/sim/bd_9054_rst_0_0.vhd" \
-endlib
-makelib xcelium_lib/lmb_v10_v3_0_11 \
  "../../../ipstatic/hdl/lmb_v10_v3_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_2/sim/bd_9054_ilmb_0.vhd" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_3/sim/bd_9054_dlmb_0.vhd" \
-endlib
-makelib xcelium_lib/lmb_bram_if_cntlr_v4_0_19 \
  "../../../ipstatic/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_4/sim/bd_9054_dlmb_cntlr_0.vhd" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_5/sim/bd_9054_ilmb_cntlr_0.vhd" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_4 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_6/sim/bd_9054_lmb_bram_I_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_7/sim/bd_9054_second_dlmb_cntlr_0.vhd" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_8/sim/bd_9054_second_ilmb_cntlr_0.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_9/sim/bd_9054_second_lmb_bram_I_0.v" \
-endlib
-makelib xcelium_lib/iomodule_v3_1_6 \
  "../../../ipstatic/hdl/iomodule_v3_1_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_10/sim/bd_9054_iomodule_0_0.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/sim/bd_9054.v" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_0/sim/ddr4_0_microblaze_mcs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/phy/ddr4_0_phy_ddr4.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/phy/ddr4_phy_v2_2_xiphy_behav.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/phy/ddr4_phy_v2_2_xiphy.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/iob/ddr4_phy_v2_2_iob_byte.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/iob/ddr4_phy_v2_2_iob.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/clocking/ddr4_phy_v2_2_pll.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_tristate_wrapper.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_riuor_wrapper.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_control_wrapper.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_byte_wrapper.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_bitslice_wrapper.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/ip_top/ddr4_0_phy.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/clocking/ddr4_v2_2_infrastructure.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_xsdb_bram.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_write.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_wr_byte.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_wr_bit.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_sync.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_read.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_rd_en.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_pi.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_mc_odt.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_debug_microblaze.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_cplx_data.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_cplx.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_config_rom.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_addr_decode.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_top.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal_xsdb_arbiter.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_cal.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_chipscope_xsdb_slave.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_v2_2_dp_AB9.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/ip_top/ddr4_0_ddr4.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal/ddr4_0_ddr4_cal_riu.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/ip_top/ddr4_0.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_2/tb/microblaze_mcs_0.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

