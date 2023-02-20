# Makefile for UVM Lab5
test = test_base
dut_path = ../../../rtl
DUT = ${dut_path}/router.sv ${dut_path}/router_io.sv ${dut_path}/ral/host_io.sv
HARNESS_TOP = ${dut_path}/router_test_top.sv
TB_TOP = ./test.sv
PACKAGE =
verbosity = UVM_MEDIUM
uvm_ver = uvm-1.1
seed = 1
defines = UVM_NO_DEPRECATED+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR+UVM_CB_TRACE_ON
plus = 
option = UVM_TR_RECORD +UVM_LOG_RECORD
SOLVER = 2
tcl = packet.tcl

all: simv run

simv compile: *.sv $(DUT) $(HARNESS_TOP) $(TB_TOP)
	vcs -sverilog -ntb_opts ${uvm_ver} -timescale="1ns/100ps" -l comp.log -debug_all +vcs+vcdpluson $(DUT) $(HARNESS_TOP) $(TB_TOP) $(PACKAGE) +define+${defines}

run:
	./simv -l simv.log +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus} +${option}

	./simv -l simv.log +ntb_random_seed_automatic +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus} +${option}

dve:
	dve -vpd vcdplus.vpd -session $(tcl)&

dve_i: simv
	./simv -l simv.log -gui +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test)

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key log *.h temp *.log .vcs* *.txt DVE* *~

help:
	@echo =======================================================================
	@echo  " 								       "
	@echo  " USAGE: make target <seed=xxx> <verbosity=YYY> <test=ZZZ>              "
	@echo  " 								       "
	@echo  "  xxx is the random seed.  Can be any integer except 0. Defaults to 1  "
	@echo  "  YYY sets the verbosity filter.  Defaults to UVM_MEDIUM               "
	@echo  "  ZZZ selects the uvm test.       Defaults to test_base                  "
	@echo  " 								       "
	@echo  " ------------------------- Test TARGETS ------------------------------ "
	@echo  " all             => Compile TB and DUT files and run the simulation    "
	@echo  " compile         => Compile TB and DUT files                           "
	@echo  " run             => Run the simulation with seed                       "
	@echo  " random          => Run the simulation with random seed                "
	@echo  " dve             => Run DVE with preset waveform displayed             "
	@echo  " dve_i           => Run simulation interactively with DVE              "
	@echo  "                                                                       "
	@echo  " -------------------- ADMINISTRATIVE TARGETS ------------------------- "
	@echo  " help       => Displays this message.                                  "
	@echo  " clean      => Remove all intermediate simv and log files              "
	@echo  "								       "
	@echo  " ---------------------- EMBEDDED SETTINGS -----------------------------"
	@echo  " -timescale=\"1ns/100ps\"                                              "
	@echo  " -debug_all                                                            "
	@echo =======================================================================
