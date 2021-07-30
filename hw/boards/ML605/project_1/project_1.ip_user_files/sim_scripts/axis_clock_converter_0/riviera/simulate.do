onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+axis_clock_converter_0 -L xilinx_vip -L xpm -L axis_infrastructure_v1_1_0 -L axis_clock_converter_v1_1_23 -L xil_defaultlib -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.axis_clock_converter_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {axis_clock_converter_0.udo}

run -all

endsim

quit -force
