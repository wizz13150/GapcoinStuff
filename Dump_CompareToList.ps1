#Script to compare gaps to the up to date PrimeGapList
#Comparison from a Dump formatted for Mersenne
#ex: 4494,C??,22.551703,Gapcoin,01-03-2021,87,350115607822499236188157303964567234646664361596077138996270421912199500949152537724663

#PrimeGapList and Files Path
$Path="Z:\Gapcoin\Live Dump"
#Download and Get the Prime Gap List
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/primegap-list-project/prime-gap-list/master/allgaps.sql" -OutFile "$Path\LastPrimeGapList.txt"
$PrimeGapList=Get-Content "$Path\LastPrimeGapList.txt"
#Get Dump to Compare
$ToCompare=Get-Content "$Path\Dump_Mersenne.csv"|Select-Object -skip 1    #End of the file only. "-skip 1" for all except first line. "-last 100" for the last 100 lines.
#Create the PtentialRecords.txt, if doesn't exist
If ((Test-Path -Path "$Path\PotentialRecords.txt" -PathType Leaf) -eq $False){
$Null=Set-Content -Path "$Path\PotentialRecords.txt" -Value "Potential Gapcoin Records"}
$c=1;$s=1;$TotalLines=$ToCompare.count

#Look for each line to compare
Foreach($line in $ToCompare){
$GapSizetoCompare=$line.Split(",")[0]
$MerittoCompare=$line.Split(",")[2]

#Get the gap and merit from the list
$Wanted=$PrimeGapList|Select-String -SimpleMatch "VALUES($($GapSizetoCompare),"
$Wanted=$Wanted -replace "INSERT INTO gaps VALUES" -replace '\(' -replace '\)' -replace ';' -replace "'"
$Wanted=$Wanted -split ","
$Gapsize=$Wanted[0]
$Merit=$Wanted[7]

#Compare, display in console and write in file if potential records
If($MerittoCompare -gt $Merit){
$Diffe=$MerittoCompare - $Merit
Write-Warning "Le Gap $Gapsize est un Record potentiel avec un Mérite de $MerittoCompare. Existant=$Merit Difference:$Diffe ($c Record(s))"
"Le Gap $Gapsize est un Record potentiel avec un Mérite de $MerittoCompare. Existant=$Merit Difference:$Diffe ($c Record(s))"|Add-Content "C:\Temp\Test\ComparetoList\PotentialRecords.txt"
$c++}Else{
#$Diff=$Merit - $MerittoCompare                                                                                          #Comment to see only Potential Records
#Write-Host "Fail. Gap $Gapsize avec un mérite de $Merit. Trouvé:$MerittoCompare Manque:$Diff ($s /"$ToCompare.count")"  #Comment to see only Potential Records
}$s++
}#End ForEach
