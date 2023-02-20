

echo "ADDITIONAL GATESIM IO DELAY PARAMETER"
if {$::env(ENV_GMODE)=="GNORMAL"} {
  echo "KEEP DEFAULT IO DELAY PARAMETER"
}
if {$::env(ENV_GMODE)=="GBEST"} {
  do $::env(ENV_SIMDIR)/io_delay_gatesim_best_case.tcl
  echo "EXECUTE io_delay_gatesim_best_case.tcl for GBEST IO DELAY PARAMETER EFFECT"
}
if {$::env(ENV_GMODE)=="GWORST"} {
  do $::env(ENV_SIMDIR)/io_delay_gatesim_worst_case.tcl
  echo "EXECUTE io_delay_gatesim_best_case.tcl for GWORST IO DELAY PARAMETER EFFECT"
}

