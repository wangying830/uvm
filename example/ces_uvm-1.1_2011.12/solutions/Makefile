# Makefile for UVM Lab2
test = test_base
TB_TOP = ./test.sv
UVM_HOME = ../../uvm-1.1
verbosity = UVM_MEDIUM
#option = UVM_OBJECTION_TRACE
uvm_ver = uvm-1.0
seed = 1
SOLVER = 2

default: uvm

all: simv
	./simv -l simv.log +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity)

uvm: uvm_simv
	./simv -l simv.log +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity)

uvm_simv uvm_compile: *.sv
	vcs -sverilog ${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS ${UVM_HOME}/src/uvm_pkg.sv +incdir+${UVM_HOME}/src -timescale="1ns/100ps" -l comp.log -debug_all $(DUT) $(HARNESS_TOP) $(TB_TOP)

run:
	./simv -l simv.log +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity)

random: simv
	./simv -l simv.log +ntb_random_seed_automatic +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity)

simv compile: *.sv $(TB_TOP)
	vcs -sverilog -ntb_opts ${uvm_ver} -timescale="1ns/100ps" -l comp.log -debug_all $(TB_TOP)

dve_i: uvm_simv
	./simv -l simv.log -gui +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test)

solution: nuke
	cp ../../solutions/lab2/*.sv .

mycopy: nuke
	cp ../lab1/*.sv .
	cp ../../solutions/lab2/packet_da_3.sv.orig packet_da_3.sv

original: copy

copy: nuke
	cp ../../solutions/lab1/*.sv .
	cp ../../solutions/lab2/packet_da_3.sv.orig packet_da_3.sv
	cp ../../solutions/lab2/test_collection.sv.orig test_collection.sv

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key log *.h temp *.log .vcs* *.txt DVE* *~

nuke: clean
	rm -rf *.sv

help:
	@echo =======================================================================
	@echo  " 								       "
	@echo  " USAGE: make target <seed=xxx> <verbosity=YYY> <test=ZZZ>              "
	@echo  " 								       "
	@echo  "  xxx is the random seed.  Can be any integer except 0. Defaults to 1  "
	@echo  "  YYY sets the verbosity filter.  Defaults to UVM_MEDIUM                     "
	@echo  "  ZZZ selects the uvm test.     Defaults to test_base                    "
	@echo  " 								       "
	@echo  " ------------------------- Test TARGETS ------------------------------ "
	@echo  " all             => Compile TB and DUT files and run the simulation    "
	@echo  " compile         => Compile TB and DUT files                           "
	@echo  " run             => Run the simulation with seed                       "
	@echo  " random          => Run the simulation with random seed                "
	@echo  " dve_i           => Run simulation interactively with DVE              "
	@echo  "                                                                       "
	@echo  " -------------------- ADMINISTRATIVE TARGETS ------------------------- "
	@echo  " help       => Displays this message.                                  "
	@echo  " clean      => Remove all intermediate simv and log files              "
	@echo  " nuke       => Remove all source code and debug files                  "
	@echo  " original   => Return content of lab back to original state            "
	@echo  " copy       => Copy files from previous lab's solution directory       "
	@echo  " mycopy     => Copy files from user's previous lab directory           "
	@echo  " solution   => Copy files from solutions directory for lab             "
	@echo  "								       "
	@echo  " ---------------------- EMBEDDED SETTINGS -----------------------------"
	@echo  " -timescale=\"1ns/100ps\"                                              "
	@echo  " -debug_all                                                            "
	@echo =======================================================================
