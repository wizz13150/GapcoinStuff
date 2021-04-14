#Script to check Commits incrementation.
#Git is required. Dump all commits (matching 'merit') content and Potentials errors with infos.
#Output files
$file="D:\Temp\Test\TestCheckCommits\Potentials.txt"
$all="D:\Temp\Test\TestCheckCommits\Commits.txt"
#Download Up to Date PrimeGaps List
$WebResponse = Invoke-WebRequest -Uri "https://raw.githubusercontent.com/primegap-list-project/prime-gap-list/master/allgaps.sql" -UseBasicParsing
$WebResponse.Content|Set-Content "D:\Temp\Test\TestCheckCommits\CurrentGaps.txt"
$pglist="D:\Temp\Test\TestCheckCommits\CurrentGaps.txt"
#Clone or Open Repo
#git clone "https://github.com/primegap-list-project/prime-gap-list"
cd D:\Temp\Test\TestCheckCommits\prime-gap-list

#Get all commits matching merit in it
$Commits=git log --oneline |Select-String merit
#Start Loop
$Changes=Foreach($line in $Commits){
$line=$line -split ' '
$Tag=$line[0]
#Commit content
$com=(git show $Tag --pretty=format:%b $COMMIT)
#Write all commit content into file
$com|Add-Content $all
#All changes in commit. On récupère que les lignes avec '+' ou '-'
$modcom=$com|Select-String  \+INSERT,\-INSERT

#Looking for each gap and compare to previous, if it's the same gap, else don't compare and next
$previousgap=0;$previousmerit=0;$previousline=0;$merit=0
Foreach($entry in $modcom){
#Gap
$gap=[decimal](($entry -split ' '|Select-String VALUES).ToString().Split(',')[0]).Split('(')[1]
#Merit
$merit=[decimal]($entry -split ' '|Select-String VALUES).ToString().Split(',')[7]
Write-Host "Gap: $gap ; Merit: $merit"
If($Gap -eq $previousgap){
#Check if current merit is smaller than previous, if yes dump infos
If(($merit -lt $previousmerit)-eq $True){
#Get current gap record
$current=Get-Content $pglist|Select-String -SimpleMatch "VALUES($($Gap),"
Write-Host "Potential error at Gap $Gap in commit '$Tag', introducted merit: $merit < $previousmerit (Existing) Check:'(git show $Tag --pretty=format:%b $Tag)'"
"Potential error at Gap $Gap in commit '$Tag', introducted merit: $merit < $previousmerit (Existing) Check:'(git show $Tag --pretty=format:%b $Tag)'"|Add-Content $file
"Introducted line: $entry"|Add-Content $file
"Previous line: $previousline"|Add-Content $file
"Current Record: $current"|Add-Content $file
" "|Add-Content $file
Start-Sleep 1}
Else{
#Saul Goodman
Write-Host "Gap $Gap correctly incremented from $previousmerit to $merit"}}
ElseIf($Gap -eq $previousgap2){
#Check if current merit is smaller than the 2nd previous, if yes dump infos
If(($merit -lt $previousmerit2)-eq $True){
#Get current gap record
$current2=Get-Content $pglist|Select-String -SimpleMatch "VALUES($($Gap),"
Write-Host "Potential error2 at Gap $Gap in commit '$Tag', introducted merit: $merit < $previousmerit2 (Existing) Check:'(git show $Tag --pretty=format:%b $Tag)'"
"Potential error2 at Gap $Gap in commit '$Tag', introducted merit: $merit < $previousmerit2 (Existing) Check:'(git show $Tag --pretty=format:%b $Tag)'"|Add-Content $file
"Introducted line2: $entry"|Add-Content $file
"Previous line2: $previousline2"|Add-Content $file
"Current Record2: $current2"|Add-Content $file
" "|Add-Content $file
Start-Sleep 1}
Else{
#Saul Goodman
Write-Host "Gap $Gap correctly incremented from $previousmerit2 to $merit"}
}
ElseIf($Gap -eq $previousgap3){
#Check if current merit is smaller than the 3rd previous, if yes dump infos
If(($merit -lt $previousmerit3)-eq $True){
#Get current gap record
$current3=Get-Content $pglist|Select-String -SimpleMatch "VALUES($($Gap),"
Write-Host "Potential error3 at Gap $Gap in commit '$Tag', introducted merit: $merit < $previousmerit3 (Existing) Check:'(git show $Tag --pretty=format:%b $Tag)'"
"Potential error3 at Gap $Gap in commit '$Tag', introducted merit: $merit < $previousmerit3 (Existing) Check:'(git show $Tag --pretty=format:%b $Tag)'"|Add-Content $file
"Introducted line3: $entry"|Add-Content $file
"Previous line3: $previousline3"|Add-Content $file
"Current Record3: $current3"|Add-Content $file
" "|Add-Content $file
Start-Sleep 1}
Else{
#Saul Goodman
Write-Host "Gap $Gap correctly incremented from $previousmerit2 to $merit"}
}
ElseIf($Gap -eq $previousgap4){
#Check if current merit is smaller than the 4th previous, if yes dump infos
If(($merit -lt $previousmerit4)-eq $True){
#Get current gap record
$current3=Get-Content $pglist|Select-String -SimpleMatch "VALUES($($Gap),"
Write-Host "Potential error4 at Gap $Gap in commit '$Tag', introducted merit: $merit < $previousmerit4 (Existing) Check:'(git show $Tag --pretty=format:%b $Tag)'"
"Potential error4 at Gap $Gap in commit '$Tag', introducted merit: $merit < $previousmerit4 (Existing) Check:'(git show $Tag --pretty=format:%b $Tag)'"|Add-Content $file
"Introducted line4: $entry"|Add-Content $file
"Previous line4: $previousline4"|Add-Content $file
"Current Record4: $current4"|Add-Content $file
" "|Add-Content $file
Start-Sleep 1}
Else{
#Saul Goodman
Write-Host "Gap $Gap correctly incremented from $previousmerit2 to $merit"}
}
#Current to previous for next one
$previousgap4=$previousgap3;$previousmerit4=$previousmerit3;$previousline4=$previousline3;$previoustag4=$previoustag3
$previousgap3=$previousgap2;$previousmerit3=$previousmerit2;$previousline3=$previousline2;$previoustag3=$previoustag2
$previousgap2=$previousgap;$previousmerit2=$previousmerit;$previousline2=$previousline;$previoustag2=$previoustag
$previousgap=$gap;$previousmerit=$merit;$previousline=$entry;$previoustag=$tag}
Write-Warning "Commit $line END, NEXT"}
