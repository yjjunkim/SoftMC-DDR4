vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/xpm
vlib questa_lib/msim/microblaze_v11_0_4
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/lib_cdc_v1_0_2
vlib questa_lib/msim/proc_sys_reset_v5_0_13
vlib questa_lib/msim/lmb_v10_v3_0_11
vlib questa_lib/msim/lmb_bram_if_cntlr_v4_0_19
vlib questa_lib/msim/blk_mem_gen_v8_4_4
vlib questa_lib/msim/iomodule_v3_1_6

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap xpm questa_lib/msim/xpm
vmap microblaze_v11_0_4 questa_lib/msim/microblaze_v11_0_4
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap lib_cdc_v1_0_2 questa_lib/msim/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 questa_lib/msim/proc_sys_reset_v5_0_13
vmap lmb_v10_v3_0_11 questa_lib/msim/lmb_v10_v3_0_11
vmap lmb_bram_if_cntlr_v4_0_19 questa_lib/msim/lmb_bram_if_cntlr_v4_0_19
vmap blk_mem_gen_v8_4_4 questa_lib/msim/blk_mem_gen_v8_4_4
vmap iomodule_v3_1_6 questa_lib/msim/iomodule_v3_1_6

vlog -work xilinx_vip  -sv -L xilinx_vip "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv -L xilinx_vip "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/map" "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/ip_top" "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93 \
"D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work microblaze_v11_0_4  -93 \
"../../../ipstatic/hdl/microblaze_v11_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93 \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_0/sim/bd_9054_microblaze_I_0.vhd" \

vcom -work lib_cdc_v1_0_2  -93 \
"../../../ipstatic/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13  -93 \
"../../../ipstatic/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93 \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_1/sim/bd_9054_rst_0_0.vhd" \

vcom -work lmb_v10_v3_0_11  -93 \
"../../../ipstatic/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93 \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_2/sim/bd_9054_ilmb_0.vhd" \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_3/sim/bd_9054_dlmb_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_19  -93 \
"../../../ipstatic/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93 \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_4/sim/bd_9054_dlmb_cntlr_0.vhd" \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_5/sim/bd_9054_ilmb_cntlr_0.vhd" \

vlog -work blk_mem_gen_v8_4_4  "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/map" "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/ip_top" "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/map" "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/ip_top" "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_6/sim/bd_9054_lmb_bram_I_0.v" \

vcom -work xil_defaultlib  -93 \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_7/sim/bd_9054_second_dlmb_cntlr_0.vhd" \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_8/sim/bd_9054_second_ilmb_cntlr_0.vhd" \

vlog -work xil_defaultlib  "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/map" "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/ip_top" "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_9/sim/bd_9054_second_lmb_bram_I_0.v" \

vcom -work iomodule_v3_1_6  -93 \
"../../../ipstatic/hdl/iomodule_v3_1_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93 \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/ip/ip_10/sim/bd_9054_iomodule_0_0.vhd" \

vlog -work xil_defaultlib  "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/map" "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/ip_top" "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/bd_0/sim/bd_9054.v" \
"../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_0/sim/ddr4_0_microblaze_mcs.v" \

vlog -work xil_defaultlib  -sv -L xilinx_vip "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/ip_1/rtl/map" "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/ip_top" "+incdir+../../../../project_1.srcs/sources_1/ip/ddr4_0_2/rtl/cal" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
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

vlog -work xil_defaultlib \
"glbl.v"

