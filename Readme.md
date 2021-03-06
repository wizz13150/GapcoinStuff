**Wizz_^**

Gapcoin Noob Stuff - Powershell

######################################

**Sample files are produced by [gapcoin-cli]Dump_gapcoincli_CurrentBlocks.ps1**

[Sample]Dump_LastBlocks.csv

[Sample]Dump_LastBlocks_Custom.csv

[Sample]Dump_LastBlocks_Mersenne.csv

######################################

**Data are produced from 'gapminer-cpu' output.**

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

  -Starts from scratch will ask which block to dump first.
  
  -Starts with an existing raw .txt dump file will continue this one.
  
  -Starts or ends at the block up to date and loop forever, dumping the blockchain into .txt xD
  
  -Format data for each block and add to files.
  
  LiteTouch script. Just modify 'gapcoin-cli' dir path and run from everywhere.
  
  4 outputs files : Raw, Custom, Mersenne Forum and S.Troisi's submission format.
  
  & Temp files to clean manually.


STABLE - **[gapcoin-cli]Dump_RawToCustom_Mersenne.ps1**

  -Format data from an existing raw .txt dump file (raw blocks) and add to file.
  
  Change 'gapcoin-cli' path and run from everywhere.
  
  3 output files : Custom, Mersenne Forum and S.Troisi submission format.
  

######################################

Mersenne Forum submission's format is a text file with the following data (comma separated): :
**26694,C??,25.376337,M.Jansen,29-2-2020,457,1015231*1087#/4830 - 19308**


So I ask you to send respectively:

**Prime gap** (integer value),

**Rating** (C?? is standard for all gaps I receive, so use this to be safe. Thomas also used CFC/CNC/C?C/C?P. The first C stands for conventional, the second character: F=First Occurence, N = not a first occurence, ? = Unknown and the final character has C for Certified, P for Probable or ? for unknown. I cannot (at this moment) certify endpoints, nor can I check gaps over 3500 characters, so untill then all gaps will receive either C?? or C?P (if I can duplicate the gap) as rating),

**Merit** (in 6 digits, decimal sign is a dot [.]),

**Discoverer** (8 characters as you want to attribute yourself or a cooperative effort),

**Date** (the date you found the gap, if unknown, leave this empty, I will then use the day I received the gap),

**Digits** (the number of digits of the gapstart, which can be calculated as ([Gap]/[Merit])/ln(10) and then round up to the next integer value),

**GapStart** (a text field with the startvalue of the gap, in this case of the form: Multiplier*Primorial#/Divider - integer (note the spaces around the minus!)

######################################

S.Troisi submission

https://primegaps.cloudygo.com/

######################################

**#Pi** 
