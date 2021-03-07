#Script to check Commits validity
#Git is required. If all commits content isn't wanted, comment line 5
#Output files
$file="C:\Temp\Test\TestCheckCommits\Potentials.txt"
$all="C:\Temp\Test\TestCheckCommits\Commits.txt"
#Clone or Open Repo
#git clone "https://github.com/primegap-list-project/prime-gap-list"
cd C:\Users\Wizz\Documents\GitHub\prime-gap-list

#Get all commits matching merit in it
$Commits=git log --oneline |Select-String merit
#Start Loop
$Changes=Foreach($line in $Commits){
$line=$line -split ' ' #|Where{$_ -match "shift"}
$Tag=$line[0]
#Commit content
$com=(git show $Tag --pretty=format:%b $COMMIT)
#Write all commit content into file
$com|Add-Content $all
#All changes in commit. On récupère que les lignes avec '+' ou '-'
$modcom=$com|Select-String  \+INSERT,\-INSERT

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
Write-Host "Potential error Gap $Gap in commit '$Tag', introducted merit: $merit < $previousmerit (Existing) Check:'(git show $Tag --pretty=format:%b $Tag)'"
"Potential error Gap $Gap in commit '$Tag', introducted merit: $merit < $previousmerit (Existing) Check:'(git show $Tag --pretty=format:%b $Tag)'"|Add-Content $file
pause}
Else{
#Saul Goodman
Write-Host "Gap $Gap correctly incremented from $previousmerit to $merit"}}
#Current to previous for next one
$previousgap=$gap;$previousmerit=$merit}
Write-Warning "Commit $line END, NEXT"}
