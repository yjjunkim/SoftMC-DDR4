::****************************************************************************
:: (c) Copyright 2009 - 2010 Xilinx, Inc. All rights reserved.
::
:: This file contains confidential and proprietary information
:: of Xilinx, Inc. and is protected under U.S. and
:: international copyright and other intellectual property
:: laws.
::
:: DISCLAIMER
:: This disclaimer is not a license and does not grant any
:: rights to the materials distributed herewith. Except as
:: otherwise provided in a valid license issued to you by
:: Xilinx, and to the maximum extent permitted by applicable
:: law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
:: WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
:: AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
:: BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
:: INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
:: (2) Xilinx shall not be liable (whether in contract or tort,
:: including negligence, or under any other theory of
:: liability) for any loss or damage of any kind or nature
:: related to, arising under or in connection with these
:: materials, including for any direct, or any indirect,
:: special, incidental, or consequential loss or damage
:: (including loss of data, profits, goodwill, or any type of
:: loss or damage suffered as a result of any action brought
:: by a third party) even if such damage or loss was
:: reasonably foreseeable or Xilinx had been advised of the
:: possibility of the same.
::
:: CRITICAL APPLICATIONS
:: Xilinx products are not designed or intended to be fail-
:: safe, or for use in any application requiring fail-safe
:: performance, such as life-support or safety devices or
:: systems, Class III medical devices, nuclear facilities,
:: applications related to the deployment of airbags, or any
:: other applications that could lead to death, personal
:: injury, or severe property or environmental damage
:: (individually and collectively, "Critical
:: Applications"). Customer assumes the sole risk and
:: liability of any use of Xilinx products in Critical
:: Applications, subject only to applicable laws and
:: regulations governing limitations on product liability.
::
:: THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
:: PART OF THIS FILE AT ALL TIMES.
::
::****************************************************************************
::   ____  ____
::  /   /\/   /
:: /___/  \  /    Vendor                : Xilinx
:: \   \   \/     Version               : 3.92
::  \   \         Application           : MIG
::  /   /         Filename              : rem_files.bat
:: /___/   /\     Date Last Modified    : Mon Jul 20 2009
:: \   \  /  \    Date Created          : Fri Feb 06 2009
::  \___\/\___\
::
:: Device            : Virtex-6
:: Design Name       : DDR3 SDRAM
:: Purpose           : Batch file to remove files generated from ISE
:: Reference         :
:: Revision History  :
::****************************************************************************

@echo off
IF EXIST "../synth/__projnav" rmdir /S /Q "../synth/__projnav"
IF EXIST "../synth/xst" rmdir /S /Q "../synth/xst"
IF EXIST "../synth/_ngo" rmdir /S /Q "../synth/_ngo"

IF EXIST tmp rmdir /S /Q tmp
IF EXIST _xmsgs rmdir /S /Q _xmsgs

IF EXIST xst rmdir /S /Q xst
IF EXIST xlnx_auto_0_xdb rmdir /S /Q xlnx_auto_0_xdb

IF EXIST coregen.cgp del /F /Q coregen.cgp
IF EXIST coregen.cgc del /F /Q coregen.cgc
IF EXIST coregen.log del /F /Q coregen.log
IF EXIST stdout.log del /F /Q stdout.log

IF EXIST ise_flow_results.txt del /F /Q ise_flow_results.txt
IF EXIST xilinx_mig_vhdl.prj del /F /Q xilinx_mig_vhdl.prj
IF EXIST xilinx_mig.syr del /F /Q xilinx_mig.syr
IF EXIST xilinx_mig.ngc del /F /Q xilinx_mig.ngc
IF EXIST xilinx_mig.ngr del /F /Q xilinx_mig.ngr
IF EXIST xilinx_mig_xst.xrpt del /F /Q xilinx_mig_xst.xrpt
IF EXIST xilinx_mig.bld del /F /Q xilinx_mig.bld
IF EXIST xilinx_mig.ngd del /F /Q xilinx_mig.ngd
IF EXIST xilinx_mig_ngdbuild.xrpt del /F /Q  xilinx_mig_ngdbuild.xrpt
IF EXIST xilinx_mig_map.map del /F /Q  xilinx_mig_map.map
IF EXIST xilinx_mig_map.mrp del /F /Q  xilinx_mig_map.mrp
IF EXIST xilinx_mig_map.ngm del /F /Q  xilinx_mig_map.ngm
IF EXIST xilinx_mig.pcf del /F /Q  xilinx_mig.pcf
IF EXIST xilinx_mig_map.ncd del /F /Q  xilinx_mig_map.ncd
IF EXIST xilinx_mig_map.xrpt del /F /Q  xilinx_mig_map.xrpt
IF EXIST xilinx_mig_summary.xml del /F /Q  xilinx_mig_summary.xml
IF EXIST xilinx_mig_usage.xml del /F /Q  xilinx_mig_usage.xml
IF EXIST xilinx_mig.ncd del /F /Q  xilinx_mig.ncd
IF EXIST xilinx_mig.par del /F /Q  xilinx_mig.par
IF EXIST xilinx_mig.xpi del /F /Q  xilinx_mig.xpi
IF EXIST smartpreview.twr del /F /Q  smartpreview.twr
IF EXIST xilinx_mig.ptwx del /F /Q  xilinx_mig.ptwx
IF EXIST xilinx_mig.pad del /F /Q  xilinx_mig.pad
IF EXIST xilinx_mig.unroutes del /F /Q  xilinx_mig.unroutes
IF EXIST xilinx_mig_pad.csv del /F /Q  xilinx_mig_pad.csv
IF EXIST xilinx_mig_pad.txt del /F /Q  xilinx_mig_pad.txt
IF EXIST xilinx_mig_par.xrpt del /F /Q  xilinx_mig_par.xrpt
IF EXIST xilinx_mig.twx del /F /Q  xilinx_mig.twx
IF EXIST xilinx_mig.bgn del /F /Q  xilinx_mig.bgn
IF EXIST xilinx_mig.twr del /F /Q  xilinx_mig.twr
IF EXIST xilinx_mig.drc del /F /Q  xilinx_mig.drc
IF EXIST xilinx_mig_bitgen.xwbt del /F /Q  xilinx_mig_bitgen.xwbt
IF EXIST xilinx_mig.bit del /F /Q  xilinx_mig.bit

:: Files and folders generated Coregen ChipScope Modules
IF EXIST icon5.asy del icon5.asy
IF EXIST icon5.ngc del icon5.ngc
IF EXIST icon5.xco del icon5.xco
IF EXIST icon5_xmdf.tcl del icon5_xmdf.tcl
IF EXIST icon5.gise del icon5.gise
IF EXIST icon5.ise del icon5.ise
IF EXIST icon5.xise del icon5.xise
IF EXIST icon5_flist.txt del icon5_flist.txt
IF EXIST icon5_readme.txt del icon5_readme.txt
IF EXIST icon5.cdc del icon5.cdc
IF EXIST icon5_xdb rmdir /S /Q icon5_xdb

IF EXIST ila384_8.asy del ila384_8.asy
IF EXIST ila384_8.ngc del ila384_8.ngc
IF EXIST ila384_8.xco del ila384_8.xco
IF EXIST ila384_8_xmdf.tcl del ila384_8_xmdf.tcl
IF EXIST ila384_8.gise del ila384_8.gise
IF EXIST ila384_8.ise del ila384_8.ise
IF EXIST ila384_8.xise del ila384_8.xise
IF EXIST ila384_8_flist.txt del ila384_8_flist.txt
IF EXIST ila384_8_readme.txt del ila384_8_readme.txt
IF EXIST ila384_8.cdc del ila384_8.cdc
IF EXIST ila384_8_xdb rmdir /S /Q ila384_8_xdb

IF EXIST vio_async_in256.asy del vio_async_in256.asy
IF EXIST vio_async_in256.ngc del vio_async_in256.ngc
IF EXIST vio_async_in256.xco del vio_async_in256.xco
IF EXIST vio_async_in256_xmdf.tcl del vio_async_in256_xmdf.tcl
IF EXIST vio_async_in256.gise del vio_async_in256.gise
IF EXIST vio_async_in256.ise del vio_async_in256.ise
IF EXIST vio_async_in256.xise del vio_async_in256.xise
IF EXIST vio_async_in256_flist.txt del vio_async_in256_flist.txt
IF EXIST vio_async_in256_readme.txt del vio_async_in256_readme.txt
IF EXIST vio_async_in256.cdc del vio_async_in256.cdc
IF EXIST vio_async_in256_xdb rmdir /S /Q vio_async_in256_xdb

IF EXIST vio_sync_out32.asy del vio_sync_out32.asy
IF EXIST vio_sync_out32.ngc del vio_sync_out32.ngc
IF EXIST vio_sync_out32.xco del vio_sync_out32.xco
IF EXIST vio_sync_out32_xmdf.tcl del vio_sync_out32_xmdf.tcl
IF EXIST vio_sync_out32.gise del vio_sync_out32.gise
IF EXIST vio_sync_out32.ise del vio_sync_out32.ise
IF EXIST vio_sync_out32.xise del vio_sync_out32.xise
IF EXIST vio_sync_out32_flist.txt del vio_sync_out32_flist.txt
IF EXIST vio_sync_out32_readme.txt del vio_sync_out32_readme.txt
IF EXIST vio_sync_out32.cdc del vio_sync_out32.cdc
IF EXIST vio_sync_out32_xdb rmdir /S /Q vio_sync_out32_xdb

:: Files and folders generated by create ise
IF EXIST test_xdb rmdir /S /Q test_xdb
IF EXIST _xmsgs rmdir /S /Q _xmsgs
IF EXIST test.gise del /F /Q test.gise
IF EXIST test.xise del /F /Q test.xise
IF EXIST test.xise del /F /Q test.xise

:: Files and folders generated by ISE through GUI mode
IF EXIST _ngo rmdir /S /Q _ngo
IF EXIST xst rmdir /S /Q xst
IF EXIST xilinx_mig.cmd_log del /F /Q xilinx_mig.cmd_log
IF EXIST xilinx_mig.lso del /F /Q xilinx_mig.lso
IF EXIST xilinx_mig.prj del /F /Q xilinx_mig.prj
IF EXIST xilinx_mig.stx del /F /Q xilinx_mig.stx
IF EXIST xilinx_mig.ut del /F /Q xilinx_mig.ut
IF EXIST xilinx_mig.xst del /F /Q xilinx_mig.xst
IF EXIST xilinx_mig_guide.ncd del /F /Q xilinx_mig_guide.ncd
IF EXIST xilinx_mig_prev_built.ngd del /F /Q xilinx_mig_prev_built.ngd
IF EXIST xilinx_mig_summary.html del /F /Q xilinx_mig_summary.html
IF EXIST par_usage_statistics.html del /F /Q par_usage_statistics.html
IF EXIST usage_statistics_webtalk.html del /F /Q usage_statistics_webtalk.html
IF EXIST webtalk.log del /F /Q webtalk.log
IF EXIST device_usage_statistics.html del /F /Q device_usage_statistics.html
IF EXIST test.ntrc_log del /F /Q test.ntrc_log

@echo on
