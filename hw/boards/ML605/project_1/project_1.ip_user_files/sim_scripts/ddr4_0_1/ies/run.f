-makelib ies_lib/xpm -sv \
  "C:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "C:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/microblaze_v11_0_2 \
  "../../../ipstatic/hdl/microblaze_v11_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/bd_0/ip/ip_0/sim/bd_9054_microblaze_I_0.vhd" \
-endlib
-makelib ies_lib/lib_cdc_v1_0_2 \
  "../../../ipstatic/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/proc_sys_reset_v5_0_13 \
  "../../../ipstatic/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/bd_0/ip/ip_1/sim/bd_9054_rst_0_0.vhd" \
-endlib
-makelib ies_lib/lmb_v10_v3_0_10 \
  "../../../ipstatic/hdl/lmb_v10_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/bd_0/ip/ip_2/sim/bd_9054_ilmb_0.vhd" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/bd_0/ip/ip_3/sim/bd_9054_dlmb_0.vhd" \
-endlib
-makelib ies_lib/lmb_bram_if_cntlr_v4_0_17 \
  "../../../ipstatic/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/bd_0/ip/ip_4/sim/bd_9054_dlmb_cntlr_0.vhd" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/bd_0/ip/ip_5/sim/bd_9054_ilmb_cntlr_0.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_4 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/bd_0/ip/ip_6/sim/bd_9054_lmb_bram_I_0.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/bd_0/ip/ip_7/sim/bd_9054_second_dlmb_cntlr_0.vhd" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/bd_0/ip/ip_8/sim/bd_9054_second_ilmb_cntlr_0.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/bd_0/ip/ip_9/sim/bd_9054_second_lmb_bram_I_0.v" \
-endlib
-makelib ies_lib/iomodule_v3_1_5 \
  "../../../ipstatic/hdl/iomodule_v3_1_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/bd_0/ip/ip_10/sim/bd_9054_iomodule_0_0.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/bd_0/sim/bd_9054.v" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_0/sim/ddr4_0_microblaze_mcs.v" \
-endlib
-makelib ies_lib/xil_defaultlib -sv \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_1/rtl/phy/ddr4_0_phy_ddr4.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_1/rtl/phy/ddr4_phy_v2_2_xiphy_behav.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_1/rtl/phy/ddr4_phy_v2_2_xiphy.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_1/rtl/iob/ddr4_phy_v2_2_iob_byte.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_1/rtl/iob/ddr4_phy_v2_2_iob.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_1/rtl/clocking/ddr4_phy_v2_2_pll.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_tristate_wrapper.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_riuor_wrapper.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_control_wrapper.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_byte_wrapper.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_1/rtl/xiphy_files/ddr4_phy_v2_2_xiphy_bitslice_wrapper.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/ip_1/rtl/ip_top/ddr4_0_phy.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_wtr.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_ref.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_rd_wr.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_periodic.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_group.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_ecc_merge_enc.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_ecc_gen.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_ecc_fi_xor.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_ecc_dec_fix.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_ecc_buf.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_ecc.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_ctl.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_cmd_mux_c.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_cmd_mux_ap.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_arb_p.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_arb_mux_p.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_arb_c.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_arb_a.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_act_timer.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc_act_rank.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/controller/ddr4_v2_2_mc.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/ui/ddr4_v2_2_ui_wr_data.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/ui/ddr4_v2_2_ui_rd_data.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/ui/ddr4_v2_2_ui_cmd.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/ui/ddr4_v2_2_ui.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/clocking/ddr4_v2_2_infrastructure.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_xsdb_bram.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_write.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_wr_byte.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_wr_bit.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_sync.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_read.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_rd_en.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_pi.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_mc_odt.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_debug_microblaze.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_cplx_data.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_cplx.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_config_rom.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_addr_decode.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_top.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal_xsdb_arbiter.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_cal.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_chipscope_xsdb_slave.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_v2_2_dp_AB9.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/ip_top/ddr4_0_ddr4.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/ip_top/ddr4_0_ddr4_mem_intfc.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/cal/ddr4_0_ddr4_cal_riu.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/rtl/ip_top/ddr4_0.sv" \
  "../../../../project_1.srcs/sources_1/ip/ddr4_0_1/tb/microblaze_mcs_0.sv" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

