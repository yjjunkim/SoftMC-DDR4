onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib bd_9c58_opt

do {wave.do}

view wave
view structure
view signals

do {bd_9c58.udo}

run -all

quit -force
