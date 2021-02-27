#Variables: Starting shift +1 (excluded); Last shift; Execution time for each shift, in sec
$i=$f=25;$Last=31;$Timeout=$Seconds=42
#Gapminer start-batch name (no extension) & dir. $Path is final output dir
$Name="start-gapminer";$Path="C:\temp\test\"
#More repeated variables
$FR="$($Path)FinalResult.csv";$TR="$($Path)TempResult.csv";$Output="Shift$($f)-$($Last)_$($Timeout)sec"
$PO="$Path$Output";$Date=((Get-Date) -replace " ","_" -replace ":" -replace "/")
        #If the Final Output csv file exist, rename with timestamp.
        If ((Test-Path -Path "$($PO).csv" -PathType Leaf) -eq $True){
        $Null=Rename-Item -Path "$($PO).csv" -NewName "$($PO)_$($Date).csv" -Force -ErrorAction Ignore}
        #If the final Temp Result csv files doesn't exist, create them.
        If (-not((Test-Path -Path $FR -PathType Leaf) -and (Test-Path -Path $TR -PathType Leaf))){
        $Null=New-Item -ItemType File -Path $FR,$TR -Force -ErrorAction Ignore}
#Start, Loop until last shift
while($i -lt $Last){
#Even more repeated variables xD
$CO="$($Path)CleanOutput$($i).csv";$OS="$($Path)OutputShift$($i).txt";$NS="$($Name)Shift$($i)"
        #Start from initial batch
        (Get-Content "$($Path)$($Name).bat") -replace "-f $($f)","-f $($i)"|Set-Content "$($Path)$($NS).bat"
        #Start miner until
        Write-Warning -Message "Processing for $($NS)..."
        $process = Start-Process "$($Path)$($NS).bat" -RedirectStandardOutput $OS -PassThru
        try {
        $process | Wait-Process -Timeout $Timeout -ErrorAction Stop
        #ForEach ($Count in (1..$Seconds)){
        #Write-Progress -Id 1 -Activity "Timer" -Status "$($Seconds - $Count)/$Seconds seconds left for Shift $i..." -PercentComplete (($Count / $Seconds) * 100)
        #Start-Sleep -Seconds 1}
        }catch{
        Write-Warning -Message "Process for $($NS) started $($Timeout) seconds ago, will be killed now."
        Stop-Process -name "gapminer-cpu" -Force                  #Kill miner after timeout
	    Remove-Item -Path "$($Path)$($NS).bat" -Force
        #Clean Output
        $Stuff=Get-Content $OS|Where{$_ -match "pps"}
        $Results=ForEach($line in $Stuff){
        #$Split=$line.Split()[0,1,3,8] -replace "]" -replace "\[" # Keep date;time;pps;tests
        $Split=$line.Split()[3,8] -replace "]" -replace "\["      # Keep pps;tests
        "$Split" -replace " ",","}
        @("S$($i)PPS,S$($i)Tests") + $Results|Set-Content $CO     #Put Shift on top
        Remove-Item -Path $OS -Force
        If ((Get-Content $FR) -eq $Null){                         #Check if first round
        Copy-Item -Path $CO -Destination $FR -Force}else{
        Copy-Item -Path $FR -Destination $TR -Force
        Clear-Content -Path $FR -Force
        #Zip into FinalResult.csv
        $Final=Get-Content $TR
        $Clean=Get-Content $CO
        For($c=0;$c -lt $Final.Count;$c++)
        {('{0},{1}' -f $Final[$c],$Clean[$c])|Add-Content $FR}}
        Remove-Item -Path $CO -Force
        Clear-Content -Path $TR -Force
        }
        $i++
}
Remove-Item -Path $TR -Force
Rename-Item -Path $FR -NewName "$Output.csv" -Force
