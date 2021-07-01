onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+bd_9c58 -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.bd_9c58 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {bd_9c58.udo}

run -all

endsim

quit -force
