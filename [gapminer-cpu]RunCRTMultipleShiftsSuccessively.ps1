#Variables: Starting shift +1 (excluded); Last shift; Execution time for each shift, in sec
[int]$i=1;$Last=31;$Timeout=$Seconds=42

#Gapminer start-batch name (no extension) & dir. $Path is final output dir
$Name="start-gapminerCRT";$Path="C:\Temp\CRT\"

#Repeated variables
$FR="$($Path)FinalResultCRT.csv";$TR="$($Path)TempResult.csv";$Output="CRTShift$($i)-$($Last)_$($Timeout)sec"
$PO="$Path$Output";$Date=((Get-Date) -replace " ","_" -replace ":" -replace "/")
        #If the Final Output csv file exist, rename with timestamp.
        If ((Test-Path -Path "$($PO).csv" -PathType Leaf) -eq $True){
        $Null=Rename-Item -Path "$($PO).csv" -NewName "$($PO)_$($Date).csv" -Force -ErrorAction Ignore}
        #If the final Temp Result csv files doesn't exist, create them.
        If (-not((Test-Path -Path $FR -PathType Leaf) -and (Test-Path -Path $TR -PathType Leaf))){
        $Null=New-Item -ItemType File -Path $FR,$TR -Force -ErrorAction Ignore}
#Start, Loop until last shift
while($i -lt $Last){
        #Find Shift
        $shift=(Get-Content "$($Path)$($Name).bat")[$i] -split ' '
        $shift=$shift[11]
        #Even more repeated variables xD
        $CO="$($Path)CleanOutput$($shift).csv";$OS="$($Path)OutputShift$($shift).txt";$NS="$($Name)Shift$($shift)"
        #Start from initial batch
        (Get-Content "$($Path)$($Name).bat")[$i] -replace ':: '|Set-Content "$($Path)$($NS).bat"
        #Start miner until
        Write-Warning -Message "Processing for $($NS)..."
        $process = Start-Process "$($Path)$($NS).bat" -RedirectStandardOutput $OS -PassThru
        try {
        $process | Wait-Process -Timeout $Timeout -ErrorAction Stop
        }catch{
        Write-Warning -Message "Process for $($NS) started $($Timeout) seconds ago, will be killed now."
        Stop-Process -name "gapminer-cpu" -Force                  #Kill miner after timeout
	    Remove-Item -Path "$($Path)$($NS).bat" -Force
        #Clean Output
        $Stuff=Get-Content $OS|Where{$_ -match "pps"}
        $Resultspps=ForEach($linepps in $Stuff){
        #$Splitpps=$linepps.Split()[0,1,3,7] -join ',' -replace '\[' -replace '\]'  # Keep date,time,pps;tests
        $Splitpps=$linepps.Split()[3,7] -join ','                                   # Keep pps;tests
        "$Splitpps"}
        $pps=@("s$($shift)PPS,s$($shift)Tests") + $Resultspps
        $Stuffgap=Get-Content $OS|Where{$_ -match "gaplist"}
        $Stuffgap=$Stuffgap -replace '                      '
        $Resultsgaps=ForEach($linegap in $Stuffgap){
        $Splitgap=$linegap.Split()[1,9] -join ',' -replace '\['                     # Keep gaps, % of block calculation
        "$Splitgap"}
        #We bring it all together
        $gaps=@("s$($shift)Gaps,s$($shift)%Block") + $Resultsgaps
        For($c=0;$c -lt $pps.Count;$c++)
        {('{0},{1}' -f $pps[$c],$gaps[$c])|Add-Content $CO}
        }#End to run a shift, and produced a Clean Output file
        Remove-Item -Path $OS -Force
        If ((Get-Content $FR) -eq $Null){                                           #Check if first round
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
        $i++ }
       

Remove-Item -Path $TR -Force
Rename-Item -Path $FR -NewName "$Output.csv" -Force