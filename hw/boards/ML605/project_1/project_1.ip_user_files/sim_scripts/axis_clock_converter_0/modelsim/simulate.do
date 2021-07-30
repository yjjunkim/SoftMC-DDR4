onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -L xilinx_vip -L xpm -L axis_infrastructure_v1_1_0 -L axis_clock_converter_v1_1_23 -L xil_defaultlib -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.axis_clock_converter_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {axis_clock_converter_0.udo}

run -all

quit -force
