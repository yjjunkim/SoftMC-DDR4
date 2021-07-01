onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -L xpm -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.ddr4_1_microblaze_mcs xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {ddr4_1_microblaze_mcs.udo}

run -all

quit -force
