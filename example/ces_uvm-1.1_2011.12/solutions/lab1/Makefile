# Makefile for UVM Lab1
rtl_path = ../../rtl
TB_TOP = ./test.sv
UVM_HOME = ../../uvm-1.1a
test = test_base
verbosity = UVM_MEDIUM
uvm_ver = uvm-1.1
seed = 1
defines = UVM_NO_DEPRECATED+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR
plus = 
#option = UVM_OBJECTION_TRACE
SOLVER = 2

all: simv run

simv compile: *.sv
	vcs -sverilog -ntb_opts ${uvm_ver} -timescale="1ns/100ps" -l comp.log -debug_all +vcs+vcdpluson $(DUT) $(HARNESS_TOP) $(TB_TOP) +define+${defines}

run:
	./simv -l simv.log +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus}

uvm1.1a: uvm_compile run
	./simv -l simv.log +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus}

uvm_compile: *.sv
	vcs -sverilog ${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS ${UVM_HOME}/src/uvm_pkg.sv +incdir+${UVM_HOME}/src+${VCS_HOME}/etc/uvm-1.1/vcs ${VCS_HOME}/etc/uvm-1.1/vcs/uvm_custom_install_vcs_recorder.sv -timescale="1ns/100ps" -l comp.log -debug_all +vcs+vcdpluson $(DUT) $(HARNESS_TOP) $(TB_TOP) +define+${defines}

random: simv
	./simv -l simv.log +ntb_random_seed_automatic +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus}

dve_i: simv
	./simv -l simv.log -gui +ntb_random_seed=$(seed) +UVM_TESTNAME=$(test) +ntb_solver_mode=$(SOLVER) +UVM_VERBOSITY=$(verbosity) +${plus}

solution: nuke
	cp ../../solutions/lab1/*.sv .

original: copy

copy: nuke
	rm -rf *.sv
	cp ../../solutions/lab1/driver.sv.orig driver.sv
	cp ../../solutions/lab1/packet.sv.orig packet.sv
	cp ../../solutions/lab1/packet_sequence.sv.orig packet_sequence.sv
	cp ../../solutions/lab1/input_agent.sv.orig input_agent.sv
	cp ../../solutions/lab1/router_env.sv.orig router_env.sv
	cp ../../solutions/lab1/test_collection.sv.orig test_collection.sv

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
	@echo  "  YYY sets the verbosity filter.  Defaults to UVM_MEDIUM               "
	@echo  "  ZZZ selects the uvm test.       Defaults to test_base                "
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
	@echo  " copy       => Copy all necessary files for starting lab               "
	@echo  " solution   => Copy all files from solutions directory                 "
	@echo  "								       "
	@echo  " ---------------------- EMBEDDED SETTINGS -----------------------------"
	@echo  " -timescale=\"1ns/100ps\"                                              "
	@echo  " -debug_all                                                            "
	@echo =======================================================================
