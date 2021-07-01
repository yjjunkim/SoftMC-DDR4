onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -L xpm -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.bd_9c58 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {bd_9c58.udo}

run -all

quit -force
