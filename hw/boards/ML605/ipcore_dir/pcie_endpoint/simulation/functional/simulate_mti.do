
vlib work
vmap work
vlog -work work +incdir+../.+../../example_design \
        +define+SIMULATION \
        +incdir+.+../dsport+../tests \
        $env(XILINX)/verilog/src/glbl.v \
      -f board.f

vsim -voptargs="+acc" +notimingchecks +TESTNAME=pio_writeReadBack_test0 -L work -L secureip -L unisims_ver \
     work.board glbl +dump_all

run -all
