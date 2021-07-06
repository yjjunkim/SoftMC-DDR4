@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.2 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Tue Jul 06 13:21:46 +0900 2021
REM SW Build 3064766 on Wed Nov 18 09:12:45 MST 2020
REM
REM Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
REM elaborate design
echo "xelab -wto b05a631014b24489b6600b177fa38575 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L microblaze_v11_0_4 -L lib_cdc_v1_0_2 -L proc_sys_reset_v5_0_13 -L lmb_v10_v3_0_11 -L lmb_bram_if_cntlr_v4_0_19 -L blk_mem_gen_v8_4_4 -L iomodule_v3_1_6 -L fifo_generator_v13_2_5 -L uvm -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_softMC_top_behav xil_defaultlib.tb_softMC_top xil_defaultlib.glbl -log elaborate.log"
call xelab  -wto b05a631014b24489b6600b177fa38575 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L microblaze_v11_0_4 -L lib_cdc_v1_0_2 -L proc_sys_reset_v5_0_13 -L lmb_v10_v3_0_11 -L lmb_bram_if_cntlr_v4_0_19 -L blk_mem_gen_v8_4_4 -L iomodule_v3_1_6 -L fifo_generator_v13_2_5 -L uvm -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot tb_softMC_top_behav xil_defaultlib.tb_softMC_top xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
