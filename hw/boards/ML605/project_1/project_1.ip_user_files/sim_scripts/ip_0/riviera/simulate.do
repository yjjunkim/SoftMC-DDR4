onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+ddr4_1_microblaze_mcs -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ddr4_1_microblaze_mcs xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {ddr4_1_microblaze_mcs.udo}

run -all

endsim

quit -force
