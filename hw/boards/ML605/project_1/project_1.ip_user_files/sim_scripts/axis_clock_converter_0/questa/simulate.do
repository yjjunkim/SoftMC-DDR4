onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib axis_clock_converter_0_opt

do {wave.do}

view wave
view structure
view signals

do {axis_clock_converter_0.udo}

run -all

quit -force
