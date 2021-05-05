    #1/5 PRODUCE RAW OUTPUT FROM GAPCOIN BLOCKCHAIN
    #NB: Output from gapcoin-cli.exe takes 2 sec to come and I need to wait for it, need to find a way to be way faster.
    #How to: Set line 7, put gapcoin-cli.exe in $Path directory. Run script from everywhere.
    #Lines to eventually edit : 7,182
    #Lines to eventually comment/uncomment for a custom output format : 132 to 171
    #Path for gapcoin-cli.exe and outputs
    $Path="C:\Temp\"

    #Repeated Variables
    $heightout="$($Path)heightout.txt";$hashout="$($Path)hashout.txt";$blockout="$($Path)blockout.txt";$lastproc="$($Path)lastproc.txt"
    $Dump="$($Path)Dump.csv";$Proc="$($Path)gapcoin-cli.exe";$DumpMersenne="Dump_Mersenne";$DumpTroisi="Dump_Troisi";$DumpBadBlocks="$($Path)DumpBadBlocks.txt"
    $DumpCustom="Dump_Custom";$blockouttemp="$($Path)blockouttemp.txt";$FDate=((Get-Date) -replace " ","_" -replace ":" -replace "/");$s=0

    #First Request for last block height value
    $Null=Start-Process $Proc -Argumentlist "getblockcount" -RedirectStandardOutput $heightout -Wait -WindowStyle Hidden -PassThru
    $LastHeight=Get-Content $heightout
    Write-Warning "Up to date last block height is $LastHeight"

    #Check if Dump_LastBlocks file already exist                                        
    Write-Warning "Searching for last processed block in Dump file."
    If((Test-Path -Path $Dump -PathType Leaf) -eq $True){
    #And then get last proccessed blockheight and nextblockhash from it  
    $n=1;$LP=Get-Content $Dump -tail $n
    While(($LP[0] -match "\{")-eq $false){$n++
    $LP=Get-Content $Dump -tail $n}
    $LastProcessed=$LP|Where {$_ -match "height"}
    $LastProcessed=$LastProcessed -replace '    "height" : ' -replace ','
    $LastProcessed=$LastProcessed.split()[-1]
    $LastProcessed|Set-Content $lastproc
    $LastHash=$LP|Where{$_ -match "nextblockhash"}
    $LastHash=$LastHash -replace '    "nextblockhash" : ' -replace '"'
    Write-Warning "Last proccessed block in Dump file is $LastProcessed"}
    Else{
    Write-Warning "No proccessed block nor hash found, so request new hash" 
    #Ask for starting block
    $userinput = Read-Host "Dump file not found, enter first block to dump (Default is block 1)"
    if(-not($userinput)){$userinput = '1'}
    #Request hash of the asked block
    $LastProcessed=$userinput
    $Null=Start-Process $Proc -Argumentlist "getblockhash $LastProcessed" -RedirectStandardOutput $hashout -Wait -WindowStyle Hidden -PassThru
    $LastHash=Get-Content $hashout
    #Write-Warning "Hash for block $LastProcessed is $LastHash"
    #Dump block
    Write-Warning "[START]Processing block $LastProcessed..."
    $Null=Start-Process $Proc -Argumentlist "getblock $LastHash" -RedirectStandardOutput $blockouttemp -Wait -WindowStyle Hidden -PassThru
    Write-Warning "[START]Block $LastProcessed cached in blockouttemp.txt"
    $Block=Get-Content $blockouttemp
    $Null=New-Item $Dump -ItemType file
    $Block|Add-Content $Dump
    #Get next hash
    $LastHash=$Block|Select-String -SimpleMatch nextblockhash
    $LastHash=$LastHash -replace '    "nextblockhash" : ' -replace '"'
    Write-Warning "Nextblockhash found in block $LastProcessed is $LastHash"}
    
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
    while([decimal]$LastProcessed -lt [decimal]$LastHeight){
    $LastProcessed=[decimal]$LastProcessed+1;$s=0
    #Dump block
    Write-Warning "Processing block $LastProcessed..."
    $Null=Start-Process $Proc -Argumentlist "getblock $LastHash" -RedirectStandardOutput $blockouttemp -Wait -WindowStyle Hidden -PassThru
    #Write-Warning "Block $LastProcessed cached in blockouttemp" 

    #Check if nextblockhash is present, or loop until
    $ToSleepOrNotToSleep = Get-Content $blockouttemp | Select-String -SimpleMatch nextblockhash
    While(([String]::IsNullOrWhiteSpace($ToSleepOrNotToSleep)) -eq $True){
    #CheckNewtBlockHash count
    $s++
    Write-Warning "Block $LastProcessed/$LastHeight doesn't contain 'nextblockhash' yet! ($s)"
    #Start-Sleep -Seconds 2
    $Null=Start-Process $Proc -Argumentlist "getblock $LastHash" -RedirectStandardOutput $blockouttemp -Wait -WindowStyle Hidden -PassThru
    #Write-Warning "Block $LastProcessed cached in blockouttemp.txt"
    $ToSleepOrNotToSleep=Get-Content $blockouttemp|Select-String -SimpleMatch nextblockhash
   
    #Check LastBlockHeight
    $Null=Start-Process $Proc -Argumentlist "getblockcount" -RedirectStandardOutput $heightout -Wait -WindowStyle Hidden -PassThru
    $LastHeight=Get-Content $heightout
        
    #If $LastHeight -gt $LastProcessed+1, we are potentially stuck, so dump the potential bad block
    If($LastHeight -gt $LastProcessed+1){
    Write-Warning "Last Processed is $LastProcessed, Last Block is $LastHeight. Dump the potential Bad Block and continue from last."
    #Read end of file until we see '{', start of last block (May vary with tx)
    $n=1;$Bad= Get-Content $Dump -tail $n
    While(($Bad[0] -match "\{")-eq $false){$n++
    $Bad=Get-Content $Dump -tail $n}
    #Complete Last Block, dump in BadBlocks file
    $Bad|Add-Content $DumpBadBlocks
    #Read all lines
    $LinesInFile = [System.IO.File]::ReadAllLines($Dump)
    #Write all lines, except for the bad block, back to the file
    [System.IO.File]::WriteAllLines("$Dump",$LinesInFile[0..($LinesInFile.Count-$n-1)])

    #Get Last Block from Dump file after cut
    $n=1;$LP=Get-Content $Dump -tail $n
    While(($LP[0] -match "\{")-eq $false){$n++
    $LP=Get-Content $Dump -tail $n}
    $LastProcessed=$LP|Where {$_ -match "height"}
    $LastProcessed=$LastProcessed -replace '    "height" : ' -replace ','
    $LastProcessed=$LastProcessed.split()[-1]
    $LastProcessed|Set-Content $lastproc
    $LastHash=$LP|Where{$_ -match "nextblockhash"}
    $LastHash=$LastHash -replace '    "nextblockhash" : ' -replace '"'
    Write-Warning "Last proccessed block in Dump file is $LastProcessed"    
    #Clean CheckNewtBlockHash count
    $s=0}}

    #Nextblockhash is present, go on
    (Get-Content $blockouttemp)|Set-Content $blockout
    $Block=Get-Content $blockout    
    $Block|Add-Content $Dump
    #Get next hash
    $LastHash=$Block|Select-String -SimpleMatch nextblockhash
    $LastHash=$LastHash -replace '    "nextblockhash" : ' -replace '"'
    #Write-Warning "Nextblockhash found in block $LastProcessed is $LastHash"
    #Save last processed block height
    $LastProcessed|Set-Content $lastproc
    #Write-Warning "Raw data dumped in $Dump"
    
    
    #2/5 CONVERT RAW DATA INTO VARIABLES
    ###############################################
    ######Custom Format Output from RAW datas######
    ###############################################
    $In=Get-Content $blockout
    #$hash=$In|Where{$_ -match '"hash" :'}
    #$hash=$hash -replace '    "hash" : ' -replace '"'
    #$hash=@("hash,") + $hash
    #$size=$In|Where{$_ -match '"size" :'}
    #$size=$size -replace '    "size" : '
    #$size=@("size,") + $size
    $height=$In|Where{$_ -match "height"}
    $height=$height -replace '    "height" : ' -replace ','  
    ##$tx=$In|Where{$_ -match "tx"}                                           #Ligne +1 ToDo, doesn't work
    ##$tx=$tx -replace '    "tx" : ' -replace '"'                             #Ligne +1 ToDo, doesn't work
    ##$tx=@("tx,") + $tx                                                      #Ligne +1 ToDo, doesn't work
    $time=$In|Where{$_ -match '"time"'}
    $time=$time -replace '    "time" : ' -replace ',' 
    $blockdates=ForEach ($ut in $time){
    $origin = New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0
    $origin.AddSeconds($ut).ToString(“dd-MM-yyyy”)}
    $nonce=$In|Where{$_ -match "nonce"}
    $nonce=$nonce -replace '    "nonce" : ' -replace ','
    $difficulty=$In|Where{$_ -match "difficulty"}
    $difficulty=$difficulty -replace '    "difficulty" : ' -replace ',' 
    $shift=$In|Where{$_ -match "shift"}
    $shift=$shift -replace '    "shift" : ' -replace ',' 
    $adder=$In|Where{$_ -match "adder"}
    $adder=$adder -replace '    "adder" : ' -replace '"' -replace ',' 
    $gapstart=$In|Where{$_ -match "gapstart"}
    $gapstart=$gapstart -replace '    "gapstart" : ' -replace '"' -replace ','    
    $Digits=ForEach($line in $gapstart){
    $measure=$line|Measure-Object -Character
    $gapstartcount=$measure.Characters
    $gapstartcount}    
    $gaplen=$In|Where{$_ -match "gaplen"}
    $gaplen=$gaplen -replace '    "gaplen" : ' -replace ','  
    $merit=$In|Where{$_ -match "merit"}
    $merit=$merit -replace '    "merit" : '
    $Merit6=ForEach($long in $merit){$long.Substring(0,$long.length-3)}

    
    #3/5 CONVERT CLEAN VARIABLES DATA INTO CUSTOM FORMAT
    ###############################################
    ######Custom Format Output from RAW datas######
    ###############################################
    #If Clean Dump file doesn't exist, create with headers
    If ((Test-Path -Path "$($Path)$($DumpCustom).csv" -PathType Leaf) -eq $False){
    $Null=Add-Content -Path "$($Path)$($DumpCustom).csv" -Value "Height,Date,Nonce,Adder,Difficulty,Shift,Merit,Gap,Gapstart"}
    #Adapt this to selection or swap columns
    "$height,$blockdates,$nonce,$adder,$difficulty,$shift,$Merit6,$gaplen,$gapstart"|Add-Content "$($Path)$($DumpCustom).csv"#}
    #Write-Warning "Custom Format Output added to $DumpCustom.csv"
    
    
    #4/5 CONVERT CLEAN VARIABLES DATA INTO MERSENNE FORUM SUBMISSON FORMAT
    ###############################################
    ###### Custom Format for Mersenne Forum  ######
    ###############################################
    #If Clean Dump file doesn't exist, create with headers
    If ((Test-Path -Path "$($Path)$($DumpMersenne).csv" -PathType Leaf) -eq $False){
    $Null=Add-Content -Path "$($Path)$($DumpMersenne).csv" -Value "Gap,C??,Merit6,Discoverer,Date,Digits,Gapstart"}
    #If next one is edited, no more for submission
    "$gaplen,C??,$Merit6,Gapcoin,$blockdates,$Digits,$gapstart"|Add-Content "$($Path)$($DumpMersenne).csv"
    #Write-Warning "MersenneForum Format Output added to $DumpMersenne.csv"


    #5/5 CONVERT CLEAN VARIABLES DATA INTO S.Troisi SUBMISSION FORMAT
    ###############################################
    ##### Custom Format for S.Troisi AutoSub  #####
    ###############################################
    #If Clean Dump file doesn't exist, create with headers
    If ((Test-Path -Path "$($Path)$($DumpTroisi).csv" -PathType Leaf) -eq $False){
    $Null=Add-Content -Path "$($Path)$($DumpTroisi).csv" -Value "Gap Date Discoverer Merit6 Gapstart"}
    #If next one is edited, no more for submission
    "$gaplen $blockdates Gapcoin $Merit6 $gapstart"|Add-Content "$($Path)$($DumpTroisi).csv"
    #Write-Warning "S.Troisi Format Output added to $DumpTroisi.csv"
    }#End dumping loop, check for new block or sleep
 
    #Loop to check for a new block
    $Previous=$LastHeight
    while($LastHeight -le $LastProcessed){
    Write-Warning "Check for a new block since last request..."
    $Null=Start-Process $Proc -Argumentlist "getblockcount" -RedirectStandardOutput $heightout -Wait -WindowStyle Hidden -PassThru
    $LastHeight=Get-Content $heightout

    If($LastHeight -eq $Previous){
    Write-Warning "No new block, sleep for 2 sec. (Current height: $LastHeight)"
    #Write-Host "     " -BackgroundColor DarkYellow
    Start-Sleep -Seconds 2
    }Else{
    Write-Warning "New block found, going forward !"
    #Reset sleep count
    }}            
    }#End Big Loop
