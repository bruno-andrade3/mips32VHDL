#!/bin/bash

# Analisar o design e o testbench
ghdl -a --workdir=output controller.vhd
ghdl -a --workdir=output tb_controller.vhd

# Elaborar o design
ghdl -e --workdir=output tb_controller

# Simular e gerar as formas de onda
ghdl -r --workdir=output tb_controller --vcd=output/waveform.vcd

# Abrir o GTKWave para visualizar as formas de onda
gtkwave output/waveform.vcd
