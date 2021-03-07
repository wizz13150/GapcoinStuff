#Script to check Commits validity
#Git is required. If all commits content isn't wanted, comment line 5
#Output files
$file="C:\Temp\Test\TestCheckCommits\Potentials.txt"
$all="C:\Temp\Test\TestCheckCommits\Commits.txt"
#Open Repo
cd C:\Users\Wizz\Documents\GitHub\prime-gap-list

#Write all commits in a txt file with git
$Commits=git log --oneline |Select-String merit
$Changes=Foreach($line in $Commits){
$line=$line -split ' ' #|Where{$_ -match "shift"}
$Tag=$line[0]
#Contient all the commit content
$com=(git show $Tag --pretty=format:%b $COMMIT) |Add-Content $all
#On récupère que les lignes avec '+' ou '-'
$modcom=$com|Select-String  \+INSERT,\-INSERT
#Contient les toutes modifications du commit
#$modcom

#Looking for each gap and compare to previous, if it's the same gap, else don't compare and next
$previousgap=0;$previousmerit=0
Foreach($entry in $modcom){
#Gap
$gap=[decimal](($entry -split ' '|Select-String VALUES).ToString().Split(',')[0]).Split('(')[1]
#Merit
$merit=[decimal]($entry -split ' '|Select-String VALUES).ToString().Split(',')[7]
Write-Host "Gap: $gap ; Merit: $merit"
If ($Gap -eq $previousgap){
#Check if current merit is smaller than previous, if yes dump infos
If(($merit -lt $previousmerit)-eq $True){
Write-Host "Potential error Gap $Gap in commit '$Tag', le merite introduit: $merit < $previousmerit (Existing) '(git show $Tag --pretty=format:%b $Tag)'"
"Potential error Gap $Gap in commit '$Tag', le merite introduit: $merit < $previousmerit (Existing) '(git show $Tag --pretty=format:%b $Tag)'"|Add-Content $file
pause}
Else{
#Saul Goodman
Write-Host "Le Gap $Gap est correctement incremente de $previousmerit a $merit"}}
#Current to previous for next one
$previousgap=$gap;$previousmerit=$merit}
Write-Warning "Commit $line End, NEXT"}