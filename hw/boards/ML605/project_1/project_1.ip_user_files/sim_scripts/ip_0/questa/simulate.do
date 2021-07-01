onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib ddr4_1_microblaze_mcs_opt

do {wave.do}

view wave
view structure
view signals

do {ddr4_1_microblaze_mcs.udo}

run -all

quit -force
