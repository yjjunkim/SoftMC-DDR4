# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_resetSystemStats
    rt::HARTNDb_startSystemStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/.Xil/Vivado-16164-DESKTOP-ILOVGO9/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    rt::set_parameter datapathDensePacking false
    set rt::partid xcvu095-ffvb1760-1-i
     file delete -force synth_hints.os

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common_vhdl.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_verilog -sv -include {
    C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605
    C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa
    C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/xilinx_mig/user_design/sim
    C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/project_1.srcs/sources_1/ip/ddr4_0_2
    C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/project_1.srcs/sources_1/ip/instr_fifo
    C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/project_1.srcs/sources_1/ip/rdback_fifo
  } {
      D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv
      D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv
    }
      rt::read_verilog -include {
    C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605
    C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa
    C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/xilinx_mig/user_design/sim
    C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/project_1.srcs/sources_1/ip/ddr4_0_2
    C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/project_1.srcs/sources_1/ip/instr_fifo
    C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/project_1.srcs/sources_1/ip/rdback_fifo
  } {
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/.Xil/Vivado-16164-DESKTOP-ILOVGO9/realtime/ddr4_0_stub.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/.Xil/Vivado-16164-DESKTOP-ILOVGO9/realtime/instr_fifo_stub.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/.Xil/Vivado-16164-DESKTOP-ILOVGO9/realtime/rdback_fifo_stub.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/axi_basic_tx_thrtl_ctl.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/axi_basic_tx_pipeline.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/pcie_pipe_misc_v6.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/axi_basic_tx.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/pcie_reset_delay_v6.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/gtx_drp_chanalign_fix_3752_v6.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/chnl_tester.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/gtx_rx_valid_filter_v6.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/gtx_tx_sync_rate_v6.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/gtx_wrapper_v6.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/pcie_upconfig_fix_3451_v6.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/pcie_clocking_v6.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/xilinx_mig/user_design/sim/ddr3_model.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/pcie_pipe_lane_v6.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/axi_basic_rx_null_gen.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/axi_basic_rx_pipeline.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/axi_basic_rx.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/axi_basic_top.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/ff.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/syncff.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/ram_2clk_1w_1r.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/ram_1clk_1w_1r.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/sync_fifo.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/cross_domain_signal.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/async_fifo.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_writer.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_monitor_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_monitor_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_monitor_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_channel_gate_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_channel_gate_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_channel_gate_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_buffer_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_buffer_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_buffer_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_selector.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_formatter_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_formatter_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_formatter_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/sg_list_requester.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/sg_list_reader_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/sg_list_reader_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/sg_list_reader_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/rx_port_requester_mux.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/rx_port_reader.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/rx_port_channel_gate.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/reorder_queue_output.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/reorder_queue_input.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/fifo_packer_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/fifo_packer_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/fifo_packer_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/async_fifo_fwft.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_qword_aligner_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_qword_aligner_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_port_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_upper_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_upper_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_upper_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_lower_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_lower_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_lower_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/rx_port_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/rx_port_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/rx_port_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/rx_engine_req.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/reorder_queue.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/interrupt_controller.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/tx_engine_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/translation_layer_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/translation_layer_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/translation_layer_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/rx_engine_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/rx_engine_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/rx_engine_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/recv_credit_flow_ctrl.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/interrupt.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/demux_1_to_n.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/channel_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/channel_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/channel_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/translation_layer.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/riffa_endpoint_64.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/riffa_endpoint_32.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/ipcore_dir/riffa/riffa_endpoint_128.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/instr_decoder.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/softMC_pcie_app.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/pipe_reg.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/instr_dispatcher.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/read_capturer.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/maint_handler.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/maint_ctrl.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/iseq_dispatcher.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/instr_receiver.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/autoref_config.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/softMC.v
      C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/softMC_top.v
    }
      rt::read_vhdl -lib xpm D:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top softMC_top
    rt::set_parameter enableIncremental true
    rt::set_parameter markDebugPreservationLevel "enable"
    set rt::reportTiming false
    rt::set_parameter elaborateOnly true
    rt::set_parameter elaborateRtl true
    rt::set_parameter eliminateRedundantBitOperator false
    rt::set_parameter elaborateRtlOnlyFlow true
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::set_parameter srlDepthThreshold 3
    rt::set_parameter rstSrlDepthThreshold 4
# MODE: 
    rt::set_parameter webTalkPath {}
    rt::set_parameter synthDebugLog false
    rt::set_parameter printModuleName false
    rt::set_parameter enableSplitFlowPath "C:/Users/yongj/Desktop/softmc_ddr4/hw/boards/ML605/project_1/.Xil/Vivado-16164-DESKTOP-ILOVGO9/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
        set oldMIITMVal [rt::get_parameter maxInputIncreaseToMerge]; rt::set_parameter maxInputIncreaseToMerge 1000
        set oldCDPCRL [rt::get_parameter createDfgPartConstrRecurLimit]; rt::set_parameter createDfgPartConstrRecurLimit 1
        $rt::db readXRFFile
      rt::run_rtlelab -module $rt::top
        rt::set_parameter maxInputIncreaseToMerge $oldMIITMVal
        rt::set_parameter createDfgPartConstrRecurLimit $oldCDPCRL
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    if { $rt::flowresult == 1 } { return -code error }


  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] } { 
     $rt::db killSynthHelper $hsKey
  } 
  rt::set_parameter helper_shm_key "" 
    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }

    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] } { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
