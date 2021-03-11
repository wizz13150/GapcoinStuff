#Script to check Commits incrementation.
#Git is required. Dump all commits (matching 'merit') content and Potentials errors with infos.
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
$line=$line -split ' '
$Tag=$line[0]
#Commit content
$com=(git show $Tag --pretty=format:%b $COMMIT)
#Write all commit content into file
$com|Add-Content $all
#All changes in commit. On récupère que les lignes avec '+' ou '-'
$modcom=$com|Select-String  \+INSERT,\-INSERT

#Looking for each gap and compare to previous, if it's the same gap, else don't compare and next
$previousgap=0;$previousmerit=0;$previousline=0
Foreach($entry in $modcom){
#Gap
$gap=[decimal](($entry -split ' '|Select-String VALUES).ToString().Split(',')[0]).Split('(')[1]
#Merit
$merit=[decimal]($entry -split ' '|Select-String VALUES).ToString().Split(',')[7]
Write-Host "Gap: $gap ; Merit: $merit"
If ($Gap -eq $previousgap){
#Check if current merit is smaller than previous, if yes dump infos
If(($merit -lt $previousmerit)-eq $True){
Write-Warning "Potential error at Gap $Gap in commit '$Tag', introducted merit: $merit < $previousmerit (Existing) Check:'(git show $Tag --pretty=format:%b $Tag)'"
"Potential error at Gap $Gap in commit '$Tag', introducted merit: $merit < $previousmerit (Existing) Check:'(git show $Tag --pretty=format:%b $Tag)'"|Add-Content $file
"Introducted line: $entry"|Add-Content $file
"Previous line: $previousline"|Add-Content $file
" "|Add-Content $file }
Else{
#Saul Goodman
Write-Host "Gap $Gap correctly incremented from $previousmerit to $merit"}}
#Current to previous for next one
$previousgap=$gap;$previousmerit=$merit;$previousline=$entry}
Write-Warning "Commit $line END, NEXT"}
