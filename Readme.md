**Wizz_^**

Gapcoin Noob Stuff - Powershell

######################################

**Sample files are produced by [gapcoin-cli]Dump_gapcoincli_CurrentBlocks.ps1**

[Sample]Dump_LastBlocks.csv

[Sample]Dump_LastBlocks_Custom.csv

[Sample]Dump_LastBlocks_Mersenne.csv

######################################

**Data are produced from 'gapminer-cpu' output.**

[Data]Shift25-99_2HoursEach_PPSTESTS.csv

[Data]PPSDrop_Shift64Blue-65Red.png

######################################



STABLE - **[gapminer-cpu]ClearFoundSharesFromGapminer-cpuRawOutput.ps1**

  -Format data from an existing raw .txt output file from 'gapminer-cpu' and add to file.


STABLE - **[gapminer-cpu]Gapminer-cpuLauncher_LogRawOutput.ps1**

  -Just a launcher for 'gapminer-cpu' logging output. Need to use "-e" to log PPS and TESTS. Use "-q" to log Shares only.


STABLE - **[gapminer-cpu]RunMultipleShiftsSuccessively.ps1**
  
  -Starts 'gapminer-cpu' repeatedly from Shift x to Shift y
  
  -Format ouput from 'gapminer-cpu' to a single file.
  
  -Clean Temp files if it ends correctly.



######################################



STABLE - **[gapcoin-cli]Dump_gapcoincli_CurrentBlocks.ps1**

  -Starts from scratch will ask wich block to dump first.
  
  -Starts with an existing raw .txt dump file will continue this one.
  
  -Starts or ends at the block up to date and loop forever, dumping the blockchain into .txt xD
  
  -Format data for each block and add to file.
  
  Modify 'gapcoin-cli' Path and run from everywhere.
  
  3 outputs files : Raw, Custom or Mersenne Forum's submission format.
  
  & Temp files to clean manually.


STABLE - **[gapcoin-cli]Dump_RawToCustom_Mersenne.ps1**

  -Format data from an existing raw .txt dump file (raw blocks) and add to file.
  
  Change 'gapcoin-cli' path and run from everywhere.
  
  2 output files : Custom or Mersenne Forum submission format.
  

######################################

**#Pi**
