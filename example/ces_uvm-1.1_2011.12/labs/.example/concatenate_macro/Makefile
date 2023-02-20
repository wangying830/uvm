seed = 1
SOLVER = 2
defines =

all: simv run

simv compile: *.sv
	vcs -sverilog -timescale="1ns/100ps" -l comp.log -debug_all +vcs+vcdpluson test.sv +define+${defines}

run:
	./simv -l simv.log +ntb_random_seed=$(seed) +ntb_solver_mode=$(SOLVER)

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key log *.h temp *.log .vcs* *.txt DVE* *~
