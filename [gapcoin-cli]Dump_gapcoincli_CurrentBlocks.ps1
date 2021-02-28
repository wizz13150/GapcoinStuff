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
    $LastProcessed=[decimal]$LastProcessed+1

    #Or from lastproc file if exist
    }Else{If((Test-Path -Path $lastproc -PathType Leaf) -eq $True){
    Write-Warning "Searching for the last proccessed block in lastproc file."
    $LastProcessed=Get-Content -Path $lastproc
    Write-Warning "Last proccessed block is $LastProcessed found in $lastproc"
    #Request hash from last processed block
    Write-Warning "No hash found, so request hash for block $LastProcessed..." 
    $Null=Start-Process $Proc -Argumentlist "getblockhash $LastProcessed" -RedirectStandardOutput $hashout -Wait -WindowStyle Hidden -PassThru
    $LastHash=Get-Content $hashout}

    #Else it will Start from current last block height
    Else{
    $LastProcessed=$LastHeight
    #Request hash from last processed block
    Write-Warning "No proccessed last blocks found nor hash, so request hash for block $LastProcessed..." 
    $Null=Start-Process $Proc -Argumentlist "getblockhash $LastProcessed" -RedirectStandardOutput $hashout -Wait -WindowStyle Hidden -PassThru
    $LastHash=Get-Content $hashout}}

    #Display numbers of blocks to dump until now
    $Diff=$LastHeight-$LastProcessed
    Write-Warning "$($Diff) blocks to dump until up to date."
    
    

    ###################################################################################
    ###Loop to dump repeatedly from last processed block height until current blocks###
    ###                    Or from current last block                               ###
    ###################################################################################

    Write-Warning "Starting Loop..."
While($True){

    while($LastProcessed -lt $LastHeight){$Timer=Measure-Command{
    Write-Host "     " -BackgroundColor DarkGreen
    #Write-Warning "Processing hash for block $LastProcessed..."    
    #Request hash from last processed block   
    #$Null=Start-Process $Proc -Argumentlist "getblockhash $LastProcessed" -Wait -RedirectStandardOutput $hashout -WindowStyle Hidden -PassThru
    #$LastHash=Get-Content $hashout

    #Dump block
    Write-Warning "Processing raw data for block $LastProcessed..."
    $Null=Start-Process $Proc -Argumentlist "getblock $LastHash" -RedirectStandardOutput $blockout -Wait -WindowStyle Hidden -PassThru
    $Block=Get-Content $blockout
    $Block|Add-Content $Dump
    Write-Warning "Raw data dumped in $Dump"

    #Save last processed block height
    #$LastProcessed=$LastBlock| Where {$_ -match "height"}
    #$LastProcessed=$LastProcessed -replace '    "height" : ' -replace ','|Set-Content -Path $lastproc
    Write-Warning "Last proccessed height is $LastProcessed, saved in $lastproc"}
    Write-Warning "[DUMP] $($Timer.TotalSeconds) sec ellapsed."
    $LastProcessed=[decimal]$LastProcessed+1
    } #End measure
    
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
       
