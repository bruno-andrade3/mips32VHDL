#!/bin/bash

# Analisar o design e o testbench
ghdl -a --workdir=output main_decoder.vhd
ghdl -a --workdir=output tb_main_decoder.vhd

# Elaborar o design
ghdl -e --workdir=output tb_main_decoder

# Simular e gerar as formas de onda
ghdl -r --workdir=output tb_main_decoder --vcd=output/waveform.vcd

# Abrir o GTKWave para visualizar as formas de onda
gtkwave output/waveform.vcd
