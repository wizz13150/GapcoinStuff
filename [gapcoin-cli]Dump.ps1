    #1/5 PRODUCE RAW OUTPUT FROM GAPCOIN BLOCKCHAIN
    #NB: Output from gapcoin-cli.exe takes 2 sec to come and I need to wait for it, need to find a way to be way faster.
    #How to: Set line 7, put gapcoin-cli.exe in $Path directory. Run script from everywhere.
    #Lines to eventually edit : 7,148
    #Lines to eventually comment/uncomment for a custom output format : 103 to 137
    #Path for gapcoin-cli.exe and outputs
    $Path="Z:\Gapcoin\Live Dump\"

    #Repeated Variables
    $heightout="$($Path)heightout.txt";$hashout="$($Path)hashout.txt";$blockout="$($Path)blockout.txt";$lastproc="$($Path)lastproc.txt"
    $Dump="$($Path)Dump.csv";$Proc="$($Path)gapcoin-cli.exe";$DumpMersenne="$($Path)Dump_Mersenne.csv";$DumpTroisi="$($Path)Dump_Troisi.csv"
    $DumpCustom="$($Path)Dump_Custom.csv";$FDate=((Get-Date) -replace " ","_" -replace ":" -replace "/")

    #First Request for last block height value
    $Null=Start-Process $Proc -Argumentlist "getblockcount" -RedirectStandardOutput $heightout -Wait -WindowStyle Hidden -PassThru
    $LastHeight=Get-Content $heightout
    Write-Warning "Up to date last block height is $LastHeight"

    #Check if Dump_LastBlocks file already exist                                        
    Write-Warning "Searching for last processed block in Dump_LastBlocks file."
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
    $Null=Start-Process $Proc -Argumentlist "getblock $LastHash" -RedirectStandardOutput $blockout -Wait -WindowStyle Hidden -PassThru
    Write-Warning "[START]Block $LastProcessed cached in blockout.txt"
    $Block=Get-Content $blockout
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
    #Write-Host " "
    $LastProcessed=[decimal]$LastProcessed+1
    #Dump block
    Write-Warning "Processing block $LastProcessed..."
    $Null=Start-Process $Proc -Argumentlist "getblock $LastHash" -RedirectStandardOutput $blockout -Wait -WindowStyle Hidden -PassThru
    #Write-Warning "Block $LastProcessed cached in blockout"

    #Check if nextblockhash is present, or loop until
    $ToSleepOrNotToSleep = Get-Content $blockout | Select-String -SimpleMatch nextblockhash
    While(([String]::IsNullOrWhiteSpace($ToSleepOrNotToSleep)) -eq $True){
    Write-Warning "Block $LastProcessed doesn't contain 'nextblockhash' yet ! Sleep for 10 sec..."
    Start-Sleep -Seconds 10
    $Null=Start-Process $Proc -Argumentlist "getblock $LastHash" -RedirectStandardOutput $blockout -Wait -WindowStyle Hidden -PassThru
    Write-Warning "Block $LastProcessed cached in blockout.txt"
    $ToSleepOrNotToSleep=Get-Content $blockout|Select-String -SimpleMatch nextblockhash }

    #nextblockhash is present, go on
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
    #If Clean DumpBlocks file doesn't exist, create with headers
    If ((Test-Path -Path $DumpCustom -PathType Leaf) -eq $False){
    $Null=Add-Content -Path $DumpCustom -Value "Height,Date,Nonce,Adder,Difficulty,Shift,Merit,Gap,Gapstart"}
    #Adapt this to selection or swap columns
    "$height,$blockdates,$nonce,$adder,$difficulty,$shift,$Merit6,$gaplen,$gapstart"|Add-Content $DumpCustom
    
    
    #4/5 CONVERT CLEAN VARIABLES DATA INTO MERSENNE FORUM SUBMISSON FORMAT
    ###############################################
    ###### Custom Format for Mersenne Forum  ######
    ###############################################
    #If Clean DumpBlocks file doesn't exist, create with headers
    If ((Test-Path -Path $DumpMersenne -PathType Leaf) -eq $False){
    $Null=Add-Content -Path $DumpMersenne -Value "Gap,C??,Merit6,Discoverer,Date,Digits,Gapstart"}
    #If next one is edited, no more for submission
    "$gaplen,C??,$Merit6,Gapcoin,$blockdates,$Digits,$gapstart"|Add-Content $DumpMersenne


    #5/5 CONVERT CLEAN VARIABLES DATA INTO S.Troisi SUBMISSION FORMAT
    ###############################################
    ##### Custom Format for S.Troisi AutoSub  #####
    ###############################################
    #If Clean DumpBlocks file doesn't exist, create with headers
    If ((Test-Path -Path $DumpTroisi -PathType Leaf) -eq $False){
    $Null=Add-Content -Path $DumpTroisi -Value "Gap Date Discoverer Merit6 Gapstart"}
    #If next one is edited, no more for submission
    "$gaplen $blockdates Gapcoin $Merit6 $gapstart"|Add-Content $DumpTroisi

        
    }#End dumping loop, check for new block or sleep
 

    #Loop to check for new blocks or sleep 10 sec
    $Previous=$LastHeight
    while($LastHeight -le $LastProcessed){
    Write-Warning "Check for a new block..."
    $Null=Start-Process $Proc -Argumentlist "getblockcount" -RedirectStandardOutput $heightout -Wait -WindowStyle Hidden -PassThru
    $LastHeight=Get-Content $heightout

    #LastHeight est plus grand que current block, alors quelque chose de va pas, copier dernier block de DumpRaw vers DumpBadBlocks et reprendre


    If($LastHeight -eq $Previous){
    Write-Warning "No new block, sleep for 10 sec. (Current height: $LastHeight)"
    #Write-Host "     " -BackgroundColor DarkYellow
    Start-Sleep -Seconds 10}Else{Write-Warning "New block found, going forward !"}}   
         
    }#End Big Loop
