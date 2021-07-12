onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib instr_fifo_opt

do {wave.do}

view wave
view structure
view signals

do {instr_fifo.udo}

run -all

quit -force
