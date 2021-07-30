onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib axis_clock_converter_c2h_opt

do {wave.do}

view wave
view structure
view signals

do {axis_clock_converter_c2h.udo}

run -all

quit -force
