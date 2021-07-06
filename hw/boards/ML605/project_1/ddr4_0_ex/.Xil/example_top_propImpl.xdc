set_property SRC_FILE_INFO {cfile:c:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/ddr4_0_ex/ddr4_0_ex.gen/sources_1/ip/ddr4_0/bd_0/ip/ip_0/bd_9054_microblaze_I_0.xdc rfile:../ddr4_0_ex.gen/sources_1/ip/ddr4_0/bd_0/ip/ip_0/bd_9054_microblaze_I_0.xdc id:1 order:EARLY scoped_inst:u_ddr4_0/inst/u_ddr_cal_riu/mcs0/inst/microblaze_I/U0} [current_design]
set_property SRC_FILE_INFO {cfile:c:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/ddr4_0_ex/ddr4_0_ex.gen/sources_1/ip/ddr4_0/par/ddr4_0.xdc rfile:../ddr4_0_ex.gen/sources_1/ip/ddr4_0/par/ddr4_0.xdc id:2 order:EARLY scoped_inst:u_ddr4_0/inst} [current_design]
current_instance u_ddr4_0/inst/u_ddr_cal_riu/mcs0/inst/microblaze_I/U0
set_property src_info {type:SCOPED_XDC file:1 line:2 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -scoped -user microblaze -tags 12436 -type CDC -id CDC-26 -description "Invalid LUTRAM collision warning" -to [get_pins -quiet "LOCKSTEP_Out_reg\[*\]/R"]
set_property src_info {type:SCOPED_XDC file:1 line:4 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -scoped -user microblaze -tags 12436 -type CDC -id CDC-26 -description "Invalid LUTRAM collision warning" -to [get_pins -quiet "MicroBlaze_Core_I/*Interrupt_DFF/Single_Synchronize.use_sync_reset.sync_reg/D"]
set_property src_info {type:SCOPED_XDC file:1 line:8 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -scoped -user microblaze -tags 12436 -type DRC -id DPIP-2 -description "Non-pipelined by design" -objects [get_cells -hierarchical *DSP48E1_I1] -objects [get_pins -quiet -filter {REF_PIN_NAME=~A[*]} -of [get_cells -hierarchical *DSP48E1_I1]]
set_property src_info {type:SCOPED_XDC file:1 line:11 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -scoped -user microblaze -tags 12436 -type DRC -id DPIP-2 -description "Non-pipelined by design" -objects [get_cells -hierarchical *DSP48E1_I1] -objects [get_pins -quiet -filter {REF_PIN_NAME=~B[*]} -of [get_cells -hierarchical *DSP48E1_I1]]
set_property src_info {type:SCOPED_XDC file:1 line:14 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -scoped -user microblaze -tags 12436 -type DRC -id DPOP-3 -description "Non-pipelined by design" -objects [get_cells -hierarchical *DSP48E1_I1] -objects [get_pins -quiet -filter {REF_PIN_NAME=~P*} -of [get_cells -hierarchical *DSP48E1_I1]]
set_property src_info {type:SCOPED_XDC file:1 line:17 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -scoped -user microblaze -tags 12436 -type DRC -id DPOP-3 -description "Non-pipelined by design" -objects [get_cells -hierarchical *DSP48E1_I1] -objects [get_pins -quiet -filter {REF_PIN_NAME=~PATTERN*} -of [get_cells -hierarchical *DSP48E1_I1]]
set_property src_info {type:SCOPED_XDC file:1 line:20 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -scoped -user microblaze -tags 12436 -type DRC -id DPOP-3 -description "Non-pipelined by design" -objects [get_cells -hierarchical *DSP48E1_I1] -objects [get_pins -quiet -filter {REF_PIN_NAME=~*OUT*} -of [get_cells -hierarchical *DSP48E1_I1]]
set_property src_info {type:SCOPED_XDC file:1 line:23 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -scoped -user microblaze -tags 12436 -type DRC -id DPOP-4 -description "Non-pipelined by design" -objects [get_cells -hierarchical *DSP48E1_I1] -objects [get_pins -quiet -filter {REF_PIN_NAME=~P[*]} -of [get_cells -hierarchical *DSP48E1_I1]]
set_property src_info {type:SCOPED_XDC file:1 line:26 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -scoped -user microblaze -tags 12436 -type DRC -id DPOP-4 -description "Non-pipelined by design" -objects [get_cells -hierarchical *DSP48E1_I1] -objects [get_pins -quiet -filter {REF_PIN_NAME=~PATTERN*} -of [get_cells -hierarchical *DSP48E1_I1]]
set_property src_info {type:SCOPED_XDC file:1 line:29 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -quiet -scoped -user microblaze -tags 12436 -type DRC -id DPOP-4 -description "Non-pipelined by design" -objects [get_cells -hierarchical *DSP48E1_I1] -objects [get_pins -quiet -filter {REF_PIN_NAME=~*OUT*} -of [get_cells -hierarchical *DSP48E1_I1]]
current_instance
current_instance u_ddr4_0/inst
set_property src_info {type:SCOPED_XDC file:2 line:257 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -hold -to [get_pins */*/*/*/*.u_xiphy_control/xiphy_control/RIU_ADDR*]
set_property src_info {type:SCOPED_XDC file:2 line:258 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -hold -to [get_pins */*/*/*/*.u_xiphy_control/xiphy_control/RIU_WR_DATA*]
set_property src_info {type:SCOPED_XDC file:2 line:277 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 5.0 -datapath_only -from [get_pins */*/u_ddr_cal_addr_decode/io_ready_lvl_reg/C] -to [get_pins u_io_ready_lvl_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:278 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 5.0 -datapath_only -from [get_pins */*/u_ddr_cal_addr_decode/io_read_data_reg[*]/C] -to [get_pins u_io_read_data_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:279 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 3.0 -datapath_only -from [get_pins */*/phy_ready_riuclk_reg/C] -to [get_pins u_phy2clb_phy_ready_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:280 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 3.0 -datapath_only -from [get_pins */*/bisc_complete_riuclk_reg/C] -to [get_pins u_phy2clb_bisc_complete_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:281 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 3.0 -datapath_only -from [get_pins */io_addr_strobe_lvl_riuclk_reg/C] -to [get_pins u_io_addr_strobe_lvl_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:282 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 3.0 -datapath_only -from [get_pins */io_write_strobe_riuclk_reg/C] -to [get_pins u_io_write_strobe_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:283 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 3.0 -datapath_only -from [get_pins */io_address_riuclk_reg[*]/C] -to [get_pins u_io_addr_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:284 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 3.0 -datapath_only -from [get_pins */io_write_data_riuclk_reg[*]/C] -to [get_pins u_io_write_data_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:285 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 10.0 -datapath_only -from [get_pins en_vtc_in_reg/C] -to [get_pins u_en_vtc_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:286 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 10.0 -datapath_only -from [get_pins */riu2clb_valid_r1_riuclk_reg[*]/C] -to [get_pins u_riu2clb_valid_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:287 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 10.0 -datapath_only -from [get_pins */*/phy2clb_fixdly_rdy_low_riuclk_int_reg[*]/C] -to [get_pins u_phy2clb_fixdly_rdy_low/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:288 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 10.0 -datapath_only -from [get_pins */*/phy2clb_fixdly_rdy_upp_riuclk_int_reg[*]/C] -to [get_pins u_phy2clb_fixdly_rdy_upp/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:289 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 10.0 -datapath_only -from [get_pins */*/phy2clb_phy_rdy_low_riuclk_int_reg[*]/C] -to [get_pins u_phy2clb_phy_rdy_low/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:290 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 10.0 -datapath_only -from [get_pins */*/phy2clb_phy_rdy_upp_riuclk_int_reg[*]/C] -to [get_pins u_phy2clb_phy_rdy_upp/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:291 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 10.0 -datapath_only -from [get_pins rst_r1_reg/C] -to [get_pins u_fab_rst_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:292 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 3.0 -datapath_only -from [get_pins  */*/clb2phy_t_b_addr_riuclk_reg/C] -to [get_pins  */*/clb2phy_t_b_addr_i_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:293 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 3.0 -datapath_only -from [get_pins  */*/*/slave_en_lvl_reg/C] -to [get_pins  */*/*/u_slave_en_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:294 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 3.0 -datapath_only -from [get_pins  */*/*/slave_we_r_reg/C] -to [get_pins  */*/*/u_slave_we_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:295 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 3.0 -datapath_only -from [get_pins  */*/*/slave_addr_r_reg[*]/C] -to [get_pins  */*/*/u_slave_addr_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:296 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 3.0 -datapath_only -from [get_pins  */*/*/slave_di_r_reg[*]/C] -to [get_pins  */*/*/u_slave_di_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:297 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 3.0 -datapath_only -from [get_pins  */*/*/slave_rdy_cptd_sclk_reg/C] -to [get_pins  */*/*/u_slave_rdy_cptd_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:298 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 12.0 -datapath_only -from [get_pins */*/*/slave_rdy_lvl_fclk_reg/C] -to [get_pins  */*/*/u_slave_rdy_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:299 export:INPUT save:INPUT read:READ} [current_design]
set_max_delay 12.0 -datapath_only -from [get_pins */*/*/slave_do_fclk_reg[*]/C] -to [get_pins  */*/*/u_slave_do_sync/SYNC[*].sync_reg_reg[0]/D]
set_property src_info {type:SCOPED_XDC file:2 line:307 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -user DDR4 -tags "1010162" -scope -type METHODOLOGY -id CLKC-55 -description "Clocking Primitives will be Auto-Placed" -objects [get_cells -hierarchical "*gen_mmcme*.u_mmcme_adv_inst*" -filter {NAME =~ *inst/u_ddr4_infrastructure*}]
set_property src_info {type:SCOPED_XDC file:2 line:308 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -user DDR4 -tags "1010162" -scope -type METHODOLOGY -id CLKC-56 -description "Clocking Primitives will be Auto-Placed" -objects [get_cells -hierarchical "*gen_mmcme*.u_mmcme_adv_inst*" -filter {NAME =~ *inst/u_ddr4_infrastructure*}]
set_property src_info {type:SCOPED_XDC file:2 line:309 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -user DDR4 -tags "1010162" -scope -type METHODOLOGY -id CLKC-57 -description "Clocking Primitives will be Auto-Placed" -objects [get_cells -hierarchical "*plle_loop[*].gen_plle*.PLLE*_BASE_INST_OTHER*" -filter {NAME =~ *inst/u_ddr4_phy_pll*}]
set_property src_info {type:SCOPED_XDC file:2 line:310 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -user DDR4 -tags "1010162" -scope -type METHODOLOGY -id CLKC-58 -description "Clocking Primitives will be Auto-Placed" -objects [get_cells -hierarchical "*plle_loop[*].gen_plle*.PLLE*_BASE_INST_OTHER*" -filter {NAME =~ *inst/u_ddr4_phy_pll*}]
set_property src_info {type:SCOPED_XDC file:2 line:311 export:INPUT save:INPUT read:READ} [current_design]
create_waiver -internal -user DDR4 -tags "1010162" -scope -type METHODOLOGY -id CLKC-40 -description "MMCM is driven through a BUFGCE" -objects [get_cells -hierarchical "*gen_mmcme*.u_mmcme_adv_inst*" -filter {NAME =~ *inst/u_ddr4_infrastructure*}]
