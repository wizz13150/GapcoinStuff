**Wizz_^**

Gapcoin Noob Stuff - Powershell

######################################

**Sample files are produced by [gapminer-cli].**

[Sample]DumpBlocks_1-x.csv

[Sample]DumpBlocks_1-x_Clean.csv

[Sample]DumpBlocks_1-x_MersenneForum.csv

######################################

**Data are produced by gapminer-cpu RawOutput.**

[Data]Shift25-99_2HoursEach_PPSTESTS.csv

[Data]PPSDrop_Shift64Blue-65Red.png

######################################



STABLE - **[gapminer-cpu]ClearFoundSharesFromGapminer-cpuRawOutput.ps1**

  -Format data from an existing raw .txt output file from gapminer-cpu and add to file.


STABLE - **[gapminer-cpu]Gapminer-cpuLauncher_LogRawOutput.ps1**

  -Just a launcher logging output from gapminer-cpu. Need to use "-e" to log PPS and TESTS. Use "-q" to log Shares only.


STABLE - **[gapminer-cpu]RunMultipleShiftsSuccessively.ps1**
  
  -Run gapminer-cpu repeatedly from Shift x to Shift y
  
  -Format ouput from gapminer-cpu to a single file.
  
  -Clean Temp files if it ends correctly.



######################################



STABLE - **[gapcoin-cli]Dump_gapcoincli_CurrentBlocks.ps1**

  -Start from scratch will ask wich block to dump first.
  
  -Start with an existing raw .txt dump file will continue this one.
  
  -Format data for each block and add to file.
  
  Change gapcoin-cli path and run from everywhere.
  
  3 outputs files : Raw, Custom or Mersenne Forum's submission format.
  
  & Temp files to clean manually.


STABLE - **[gapcoin-cli]Dump_RawToCustom_Mersenne.ps1**

  -Format data from an existing raw .txt dump file (raw blocks) and add to file.
  
  Change gapcoin-cli path and run from everywhere.
  
  2 output files : Custom or Mersenne Forum submission format.
  

######################################

**#Pi**
