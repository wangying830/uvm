#############################
# User variables
#############################
TB       = tb
SEED     = 1
FILES    = tb_gatesim_io_delay_control.sv 
# GMODE = {GNORMAL, GBEST, GWORST}
GMODE    = GNORMAL
SIMDIR   = ./

#############################
# Environment variables
#############################
export ENV_GMODE=$(GMODE)
export ENV_SIMDIR=$(SIMDIR)

VCOMP                = vlogan -full64 -sverilog -timescale=1ps/1ps -nc -l comp.log
ELAB                 = vcs -full64 -debug_access+all -l elab.log -sim_res=1ps 
RUN                  = ./$(TB).simv -l run.log +ntb_random_seed=$(SEED) -ucli -do run_sim.tcl

comp:
	$(VCOMP) $(FILES) 

elab: 
	$(ELAB) -top $(TB) -o $(TB).simv

run:
	$(RUN) 

rung:
	$(RUN) -gui

clean:
	rm -rf AN.DB DVEfiles csrc *.simv *.simv.daidir *.simv.vdb ucli.key
	rm -rf *.log* *.vpd 64

