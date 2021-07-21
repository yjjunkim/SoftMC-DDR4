vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/gtwizard_ultrascale_v1_7_9
vlib riviera/xil_defaultlib
vlib riviera/blk_mem_gen_v8_4_4
vlib riviera/xdma_v4_1_8

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap gtwizard_ultrascale_v1_7_9 riviera/gtwizard_ultrascale_v1_7_9
vmap xil_defaultlib riviera/xil_defaultlib
vmap blk_mem_gen_v8_4_4 riviera/blk_mem_gen_v8_4_4
vmap xdma_v4_1_8 riviera/xdma_v4_1_8

vlog -work xilinx_vip  -sv2k12 "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"D:/Xilinx/Vivado/2020.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+../../../ipstatic/hdl/verilog" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work gtwizard_ultrascale_v1_7_9  -v2k5 "+incdir+../../../ipstatic/hdl/verilog" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_bit_sync.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gte4_drp_arb.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe4_delay_powergood.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtye4_delay_powergood.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe3_cpll_cal.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe3_cal_freqcnt.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe4_cpll_cal.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe4_cpll_cal_rx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe4_cpll_cal_tx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gthe4_cal_freqcnt.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtye4_cpll_cal.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtye4_cpll_cal_rx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtye4_cpll_cal_tx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtye4_cal_freqcnt.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_buffbypass_rx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_buffbypass_tx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_reset.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_userclk_rx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_userclk_tx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_userdata_rx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_gtwiz_userdata_tx.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_reset_sync.v" \
"../../../ipstatic/hdl/gtwizard_ultrascale_v1_7_reset_inv_sync.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic/hdl/verilog" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../ip/xdma_0/ip_0/ip_0/sim/gtwizard_ultrascale_v1_7_gthe3_channel.v" \
"../../../ip/xdma_0/ip_0/ip_0/sim/xdma_0_pcie3_ip_gt_gthe3_channel_wrapper.v" \
"../../../ip/xdma_0/ip_0/ip_0/sim/xdma_0_pcie3_ip_gt_gtwizard_gthe3.v" \
"../../../ip/xdma_0/ip_0/ip_0/sim/xdma_0_pcie3_ip_gt_gtwizard_top.v" \
"../../../ip/xdma_0/ip_0/ip_0/sim/xdma_0_pcie3_ip_gt.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_tph_tbl.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_pipe_lane.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_bram_16k.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_bram_rep_8k.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_bram_req_8k.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_gt_channel.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_pipe_pipeline.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_pipe_misc.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_init_ctrl.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_gt_common.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_bram_8k.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_bram_rep.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_bram_req.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_phy_sync.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_bram_cpl.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_sys_clk_gen.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_phy_rst.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_phy_txeq.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_phy_clk.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_bram.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_phy_rxeq.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_gtwizard_top.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_phy_wrapper.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_pcie3_uscale_wrapper.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_pcie3_uscale_top.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_phy_sync_cell.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_rxcdrhold.v" \
"../../../ip/xdma_0/ip_0/source/xdma_0_pcie3_ip_pcie3_uscale_core_top.v" \
"../../../ip/xdma_0/ip_0/sim/xdma_0_pcie3_ip.v" \

vlog -work blk_mem_gen_v8_4_4  -v2k5 "+incdir+../../../ipstatic/hdl/verilog" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic/hdl/verilog" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../ip/xdma_0/ip_1/sim/xdma_v4_1_8_blk_mem_64_reg_be.v" \
"../../../ip/xdma_0/ip_2/sim/xdma_v4_1_8_blk_mem_64_noreg_be.v" \

vlog -work xdma_v4_1_8  -sv2k12 "+incdir+../../../ipstatic/hdl/verilog" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../ipstatic/hdl/xdma_v4_1_vl_rfs.sv" \

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../ipstatic/hdl/verilog" "+incdir+D:/Xilinx/Vivado/2020.2/data/xilinx_vip/include" \
"../../../ip/xdma_0/xdma_v4_1/hdl/verilog/xdma_0_dma_bram_wrap.sv" \
"../../../ip/xdma_0/xdma_v4_1/hdl/verilog/xdma_0_dma_bram_wrap_1024.sv" \
"../../../ip/xdma_0/xdma_v4_1/hdl/verilog/xdma_0_dma_bram_wrap_2048.sv" \
"../../../ip/xdma_0/xdma_v4_1/hdl/verilog/xdma_0_core_top.sv" \
"../../../ip/xdma_0/sim/xdma_0.sv" \

vlog -work xil_defaultlib \
"glbl.v"

