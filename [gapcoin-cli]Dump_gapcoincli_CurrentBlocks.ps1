    #Current Blocks dumper from gapcoin-cli.exe
    #Path for gapcoin-cli.exe and outputs
    $Path="C:\Temp\Test\"
    #Repeated Variables
    $heightout="$($Path)heightout.txt";$hashout="$($Path)hashout.txt";$blockout="$($Path)blockout.txt";$lastproc="$($Path)lastproc.txt"
    $Dump="$($Path)Dump_LastBlocks_Test.csv";$Proc="$($Path)gapcoin-cli.exe"

    #################################################################
    ##########Delete files to start from current last block##########
    #################################################################

    #First Request for last block height value
    $Null=Start-Process $Proc -Argumentlist "getblockcount" -RedirectStandardOutput $heightout -Wait -WindowStyle Hidden -PassThru
    $LastHeight=Get-Content $heightout
    Write-Warning "Up to date last block height is $LastHeight"

    #Check if Dump_LastBlocks file already exist                                    #Trop long, a changer
    Write-Warning "Searching for last processed block in Dump_LastBlocks file."
    If((Test-Path -Path $Dump -PathType Leaf) -eq $True){
    #And then get last proccessed block height and next hash from it
    $LastProcessed=Get-Content -Path $Dump|Where {$_ -match "height"}
    $LastProcessed=$LastProcessed -replace '    "height" : ' -replace ','
    $LastProcessed=$LastProcessed.split()[-1]
    $LastProcessed|Set-Content $lastproc
    #Get next hash from Dump_LastBlocks file
    $LastHash=Get-Content -Path $Dump|Where {$_ -match "nextblockhash"}
    $Lasthash=($Lasthash -replace '    "nextblockhash" : ' -replace '"').Split()[-1]
    Write-Warning "Last proccessed block in Dump file is $LastProcessed"
    $LastProcessed=[decimal]$LastProcessed+1}
    Else{
    Write-Warning "No proccessed block nor hash found, so request new hash" 
    #Ask for starting block
    $userinput = Read-Host "No Dump file found, enter first block to dump (Default is 1)"
    if(-not($userinput)){$userinput = '1'}#else{Write-output "Input a ete saisi"}
    $LastProcessed=$userinput
    
    #$LastProcessed=$LastHeight
    #Request hash from last processed block
    $Null=Start-Process $Proc -Argumentlist "getblockhash $LastProcessed" -RedirectStandardOutput $hashout -Wait -WindowStyle Hidden -PassThru
    $LastHash=Get-Content $hashout
    Write-Warning "Last hash to use is $LastHash" 
    #Dump block
    Write-Warning "Processing raw data for block $LastProcessed..."
    $Null=Start-Process $Proc -Argumentlist "getblock $LastHash" -RedirectStandardOutput $blockout -Wait -WindowStyle Hidden -PassThru
    $Block=Get-Content $blockout
    $Null=New-Item $Dump -ItemType file
    $Block|Add-Content $Dump
    $LastProcessed=[decimal]$LastProcessed+1} #}

    #Display numbers of blocks to dump until now
    If(($LastHeight -eq $LastProcessed) -eq $True){
    $Diff=$LastHeight
    Write-Warning "$($Diff) blocks to dump until up to date."}Else{
    $Diff=[decimal]$LastHeight-[decimal]$LastProcessed
    Write-Warning "$($Diff) blocks to dump until up to date"}

    

    ###################################################################################
    ###Loop to dump repeatedly from last processed block height until current blocks###
    ###                    Or from current last block                               ###
    ###################################################################################

    Write-Warning "Starting Loop..."
While($True){
    while($LastProcessed -lt $LastHeight){$Timer=Measure-Command{
    Write-Host "     " -BackgroundColor DarkGreen
    #Dump block
    Write-Warning "Processing raw data for block $LastProcessed..."
    $Null=Start-Process $Proc -Argumentlist "getblock $LastHash" -RedirectStandardOutput $blockout -Wait -WindowStyle Hidden -PassThru
    $Block=Get-Content $blockout
    $Block|Add-Content $Dump
    #Get next hash
    $LastHash=$Block|Select-String -SimpleMatch nextblockhash
    $LastHash=$LastHash -replace '    "nextblockhash" : ' -replace '"'
    #Save last processed block height
    $LastProcessed|Set-Content $lastproc
    Write-Warning "Raw data dumped in $Dump"
    $LastProcessed=[decimal]$LastProcessed+1}} #End measure 
    Write-Warning "[DUMP] $($Timer.TotalSeconds) sec ellapsed."
    
    #Request again for last block height since start processing, if new one, don't sleep
    Write-Warning "Processing last block height, if new one, don't sleep..."
    $Null=Start-Process $Proc -Argumentlist "getblockcount" -RedirectStandardOutput $heightout -Wait -WindowStyle Hidden -PassThru
    $LastHeight=Get-Content $heightout
    Write-Warning "Last block height is $LastHeight"
    Write-Warning "Block $LastHeight processed."

    #Loop to check for new blocks or sleep 10 sec
    while($LastProcessed -le $LastHeight){$Timer=Measure-Command{
    Write-Warning "Check for a new block..."
    $Null=Start-Process $Proc -Argumentlist "getblockcount" -RedirectStandardOutput $heightout -Wait -WindowStyle Hidden -PassThru
    $LastHeight=Get-Content $heightout
    Write-Warning "No new block, sleeping for 10 sec."
    Write-Host "     " -BackgroundColor DarkYellow
    Start-Sleep -Seconds 10}
    Write-Warning "{CHECK] $($Timer.TotalSeconds) sec ellapsed."} #End measure

    #Another request for last block height since start processing, if no new one, sleep
    Write-Warning "Processing last block height..."
    $Null=Start-Process $Proc -Argumentlist "getblockcount" -RedirectStandardOutput $heightout -Wait -WindowStyle Hidden -PassThru
    $LastHeight=Get-Content $heightout
    Write-Warning "Last block height is $LastHeight"
    Write-Warning "Block $LastHeight processed."
    }#End Dump Loop
