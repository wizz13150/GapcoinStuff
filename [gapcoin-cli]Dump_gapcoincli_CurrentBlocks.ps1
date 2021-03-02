    #1/4 PRODUCE RAW OUTPUT FROM GAPCOIN BLOCKCHAIN
    #NB: Output from gapcoin-cli.exe takes 2 sec to come and I need to wait for it, need to find a way to be way faster.
    #How to: Set line 7, put gapcoin-cli.exe in $Path directory. Run script from everywhere.
    #Lines to eventually edit : 7,145
    #Lines to eventually comment/uncomment for a custom output format : 101 to 135
    #Path for gapcoin-cli.exe and outputs
    $Path="C:\Temp\test\old\"

    #Repeated Variables
    $heightout="$($Path)heightout.txt";$hashout="$($Path)hashout.txt";$blockout="$($Path)blockout.txt";$lastproc="$($Path)lastproc.txt"
    $Dump="$($Path)Dump_LastBlocks.csv";$Proc="$($Path)gapcoin-cli.exe";$DumpMersenne="Dump_LastBlocks_Mersenne"
    $DumpCustom="Dump_LastBlocks_Custom";$FDate=((Get-Date) -replace " ","_" -replace ":" -replace "/")

    #First Request for last block height value
    $Null=Start-Process $Proc -Argumentlist "getblockcount" -RedirectStandardOutput $heightout -Wait -WindowStyle Hidden -PassThru
    $LastHeight=Get-Content $heightout
    Write-Warning "Up to date last block height is $LastHeight"

    #Check if Dump_LastBlocks file already exist                                        
    Write-Warning "Searching for last processed block in Dump_LastBlocks file."
    If((Test-Path -Path $Dump -PathType Leaf) -eq $True){
    #And then get last proccessed block height and next hash from it                     #Looong for big files, need to change that
    $LastProcessed=Get-Content -Path $Dump|Where {$_ -match "height"}
    $LastProcessed=$LastProcessed -replace '    "height" : ' -replace ','
    $LastProcessed=$LastProcessed.split()[-1]
    $LastProcessed|Set-Content $lastproc
    #Get next hash from Dump_LastBlocks file
    $LastHash=Get-Content -Path $Dump|Where {$_ -match "nextblockhash"}
    $Lasthash=($Lasthash -replace '    "nextblockhash" : ' -replace '"').Split()[-1]
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
    Write-Warning "Hash for block $LastProcessed is $LastHash"
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
    Write-Warning "Block $LastProcessed cached in blockout"

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
    Write-Warning "Nextblockhash found in block $LastProcessed is $LastHash"
    #Save last processed block height
    $LastProcessed|Set-Content $lastproc
    #Write-Warning "Raw data dumped in $Dump"
    
    
    #2/4 CONVERT RAW DATA INTO VARIABLES
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
    $time=$In|Where{$_ -match "time"}
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
    
    #3/4 CONVERT CLEAN VARIABLES DATA INTO CUSTOM FORMAT
    ###############################################
    ######Custom Format Output from RAW datas######
    ###############################################
    #If Clean DumpBlocks file doesn't exist, create with headers
    If ((Test-Path -Path "$($Path)$($DumpCustom).csv" -PathType Leaf) -eq $False){
    $Null=Add-Content -Path "$($Path)$($DumpCustom).csv" -Value "Height,Date,Nonce,Adder,Difficulty,Shift,Merit,Gap,Gapstart"}
    #Adapt this to selection or swap columns
    "$height,$blockdates,$nonce,$adder,$difficulty,$shift,$Merit6,$gaplen,$gapstart"|Add-Content "$($Path)$($DumpCustom).csv"#}
    #Write-Warning "Custom Format Output added to $DumpCustom.csv"
    
    
    #4/4 CONVERT CLEAN VARIABLES DATA INTO MERSENNE FORUM SUBMISSON FORMAT
    ###############################################
    ###### Custom Format for Mersenne Forum  ######
    ###############################################
    
    #If Clean DumpBlocks file doesn't exist, create with headers
    If ((Test-Path -Path "$($Path)$($DumpMersenne).csv" -PathType Leaf) -eq $False){
    $Null=Add-Content -Path "$($Path)$($DumpMersenne).csv" -Value "Gap,C??,Merit6,Discoverer,Date,Digits,Gapstart"}
    #If next one is edited, no more for submission
    "$gaplen,C??,$Merit6,Gapcoin,$blockdates,$Digits,$gapstart"|Add-Content "$($Path)$($DumpMersenne).csv"
    #Write-Warning "MersenneForum Format Output added to $DumpMersenne.csv"
        
    }#End dumping loop, check for new block or sleep
 

    #Loop to check for new blocks or sleep 10 sec
    $Previous=$LastHeight
    while($LastHeight -le $LastProcessed){
    Write-Warning "Check for a new block..."
    $Null=Start-Process $Proc -Argumentlist "getblockcount" -RedirectStandardOutput $heightout -Wait -WindowStyle Hidden -PassThru
    $LastHeight=Get-Content $heightout
    If($LastHeight -eq $Previous){
    Write-Warning "No new block, sleep for 10 sec. (Current height: $LastHeight)"
    Write-Host "     " -BackgroundColor DarkYellow
    Start-Sleep -Seconds 10}Else{Write-Warning "New block found, going forward !"}}   
         
    }#End Big Loop
