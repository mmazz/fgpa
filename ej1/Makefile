# vhdl files
FILES = src/*
DUT:=mod_m_counter_prog

# testbench
TESTBENCHFILE = ${DUT}_tb
TESTBENCHPATH = ${TESTBENCHFILE}.vhd

#GHDL CONFIG

GHDL_FLAGS  = --ieee=standard --warn-no-vital-generic
SIMDIR = simulation
STOP_TIME = 10ms

# Simulation break condition
#GHDL_SIM_OPT = --assert-level=error

GHDL_SIM_OPT = --stop-time=$(STOP_TIME)
WAVEFORM_VIEWER = gtkwave

.PHONY: clean  compile run

all: setup compile run view

utils:
	$(MAKE) -C utils

setup:
	@mkdir -p $(SIMDIR)

compile:  setup

	ghdl -a $(GHDL_FLAGS) --workdir=$(SIMDIR) -Putils --work=work $(FILES) $(TESTBENCHPATH)
	ghdl -e $(GHDL_FLAGS) --workdir=$(SIMDIR) -Putils --work=work $(TESTBENCHFILE)

run:
	ghdl -r -Putils --workdir=$(SIMDIR) $(TESTBENCHFILE) --wave=$(SIMDIR)/$(TESTBENCHFILE).ghw $(GHDL_SIM_OPT)

view:
	$(WAVEFORM_VIEWER) $(SIMDIR)/$(TESTBENCHFILE).ghw $(SIMDIR)/$(TESTBENCHFILE).gtkw

clean:
	@rm -rf $(SIMDIR) *.o

