    #1/4 PRODUCE RAW OUTPUT FROM GAPCOIN BLOCKCHAIN
    #Sections 2,3,4 can be used separately with partial DumpBlocks_* file. Only need line 7 variables to run. 
    #NB: Output from gapcoin-cli.exe takes 2 sec to come and I need to wait for it, need to find a way to be way faster.
    #How to: Set line 8, put gapcoin-cli.exe in $Path directory. Run script from everywhere.
    #Lines to eventually edit : 8,180
    #Lines to eventually comment/uncomment for a custom output format : 86 to 152
    #Path for gapcoin-cli.exe and outputs
    $Path="C:\Temp\Test\"

    #Repeated Variables
    $heightout="$($Path)heightout.txt";$hashout="$($Path)hashout.txt";$blockout="$($Path)blockout.txt";$lastproc="$($Path)lastproc.txt"
    $Dump="$($Path)Dump_LastBlocks_Test.csv";$Proc="$($Path)gapcoin-cli.exe";$DumpMersenne="Dump_LastBlocks_Test_Mersenne"
    $DumpCustom="Dump_LastBlocks_Test_Custom";$FDate=((Get-Date) -replace " ","_" -replace ":" -replace "/")

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
    Write-Warning "Last proccessed block in Dump file is $LastProcessed"}
    Else{
    Write-Warning "No proccessed block nor hash found, so request new hash" 
    #Ask for starting block
    $userinput = Read-Host "No Dump file found, enter first block to dump (Default is 1)"
    if(-not($userinput)){$userinput = '1'}#else{Write-output "Input a ete saisi"}
    $LastProcessed=$userinput
    
    #Request hash from last processed block
    $Null=Start-Process $Proc -Argumentlist "getblockhash $LastProcessed" -RedirectStandardOutput $hashout -Wait -WindowStyle Hidden -PassThru
    $LastHash=Get-Content $hashout
    Write-Warning "Last hash to use is $LastHash" 
    #Dump block
    Write-Warning "Processing raw data for block $LastProcessed..."
    $Null=Start-Process $Proc -Argumentlist "getblock $LastHash" -RedirectStandardOutput $blockout -Wait -WindowStyle Hidden -PassThru
    $Block=Get-Content $blockout
    $Null=New-Item $Dump -ItemType file
    $Block|Add-Content $Dump} #}

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
    while($LastProcessed -lt $LastHeight){
    $LastProcessed=[decimal]$LastProcessed+1
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
    
    
    #2/4 CONVERT RAW DATA INTO VARIABLES
    ###############################################
    ######Custom Format Output from RAW datas######
    ###############################################
    Write-Warning "Processing variables..."
    $In=Get-Content $blockout
    #$hash=$In|Where{$_ -match '"hash" :'}
    #$hash=$hash -replace '    "hash" : ' -replace '"'
    #$hash=@("hash,") + $hash
    #$confirmations=$In|Where{$_ -match '"confirmations" :'}
    #$confirmations=$confirmations -replace '    "confirmations" : '
    #$confirmations=@("confirmations,") + $confirmations
    #$size=$In|Where{$_ -match '"size" :'}
    #$size=$size -replace '    "size" : '
    #$size=@("size,") + $size
    $height=$In|Where{$_ -match "height"}
    $height=$height -replace '    "height" : '
    $height=@("height,") + $height
    #$version=$In|Where{$_ -match "version"}
    #$version=$version -replace '    "version" : '
    #$version=@("version,") + $version
    #$merkleroot=$In|Where{$_ -match "merkleroot"}
    #$merkleroot=$merkleroot -replace '    "merkleroot" : ' -replace '"'
    #$merkleroot=@("merkleroot,") + $merkleroot
    ##$tx=$In|Where{$_ -match "tx"}                         #Ligne +1 ToDo, doesn't works
    ##$tx=$tx -replace '    "tx" : ' -replace '"'           #Ligne +1 ToDo, doesn't works
    ##$tx=@("tx,") + $tx                                    #Ligne +1 ToDo, doesn't works
    $time=$In|Where{$_ -match "time"}
    $time=$time -replace '    "time" : ' -replace ',' 
    $blockdates=ForEach ($ut in $time){
    $origin = New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0
    $origin.AddSeconds($ut).ToString(“dd-MM-yyyy”) + ','}
    $Date=@("Date,") + $blockdates
    $nonce=$In|Where{$_ -match "nonce"}
    $nonce=$nonce -replace '    "nonce" : '
    $nonce=@("nonce,") + $nonce
    $difficulty=$In|Where{$_ -match "difficulty"}
    $difficulty=$difficulty -replace '    "difficulty" : '
    $difficulty=@("difficulty,") + $difficulty
    $shift=$In|Where{$_ -match "shift"}
    $shift=$shift -replace '    "shift" : '
    $shift=@("shift,") + $shift
    $adder=$In|Where{$_ -match "adder"}
    $adder=$adder -replace '    "adder" : ' -replace '"'
    $adder=@("adder,") + $adder
    $gapstart=$In|Where{$_ -match "gapstart"}
    $gapstart=$gapstart -replace '    "gapstart" : ' -replace '"' -replace ','    
    $Digits=ForEach($line in $gapstart){
    $measure=$line|Measure-Object -Character
    $gapstartcount=$measure.Characters
    $gapstartcount}    
    $gapstart=$gapstart|foreach { $_ + ',' }
    $gapstart=@("Gapstart,") + $gapstart
    $Digits=@("Digits") + $Digits
    #$gapend=$In|Where{$_ -match "gapend"}
    #$gapend=$gapend -replace '    "gapend" : ' -replace '"'
    #$gapend=@("gapend,") + $gapend
    $gaplen=$In|Where{$_ -match "gaplen"}
    $gaplen=$gaplen -replace '    "gaplen" : '
    $Gap=@("Gap,") + $gaplen
    $merit=$In|Where{$_ -match "merit"}
    $merit=$merit -replace '    "merit" : '
    $Merit6=ForEach($long in $merit){$long.Substring(0,$long.length-3)}
    $Merit6=@("Merit6") + $Merit6
    #$chainwork=$In|Where{$_ -match "chainwork"}
    #$chainwork=$chainwork -replace '    "chainwork" : ' -replace '"'
    #$chainwork=@("chainwork,") + $chainwork
    #$previousblockhash=$In|Where{$_ -match "previousblockhash"}
    #$previousblockhash=$previousblockhash -replace '    "previousblockhash" : ' -replace '"'
    #$previousblockhash=@("previousblockhash,") + $previousblockhash
    #$nextblockhash=$In|Where{$_ -match "nextblockhash"}
    #$nextblockhash=$nextblockhash -replace '    "nextblockhash" : ' -replace '"'
    #$nextblockhash=@("nextblockhash,") + $nextblockhash

    
    #3/4 CONVERT CLEAN VARIABLES DATA INTO CUSTOM FORMAT
    ###############################################
    ######Custom Format Output from RAW datas######
    ###############################################
    Write-Warning "Processing Custom Format Output..."
    #If Clean DumpBlocks file exist, rename with formatted date
    #If ((Test-Path -Path "$($Path)$($DumpCustom).csv" -PathType Leaf) -eq $True){
    #$Null=Rename-Item -Path "$($Path)$($DumpCustom).csv" -NewName "$($DumpCustom)_$($FDate).csv" -Force -ErrorAction Ignore}
    for($c = 0; $c -lt $height.Count; $c++){
    #Adapt this to selection or swap columns
    ('{0}{1}{2}{3}{4}{5}{6}{7}{8}' -f $height[$c],$Date[$c],$nonce[$c],$adder[$c],$difficulty[$c],$shift[$c],$Merit6[$c],$Gap[$c],$gapstart[$c])|Add-Content "$($Path)$($DumpCustom).csv"}
    Write-Warning "Custom Format Output is '$($Path)$($DumpCustom).csv'"


    
    #4/4 CONVERT CLEAN VARIABLES DATA INTO MERSENNE FORUM SUBMISSON FORMAT
    ###############################################
    ###### Custom Format for Mersenne Forum  ######
    ###############################################
    Write-Warning "Processing MersenneForum Format Output..."
    #If MersenneForum DumpBlocks file exist, rename with formatted date
    #If ((Test-Path -Path "$($Path)$($DumpMersenne).csv" -PathType Leaf) -eq $True){
    #$Null=Rename-Item -Path "$($Path)$($DumpMersenne).csv" -NewName "$($DumpMersenne)_$($FDate).csv" -Force -ErrorAction Ignore}
    for($c = 0; $c -lt $height.Count; $c++){
    #If next is edited, no more for submission
    ('{0}C??,{2},Gapcoin,{4}{5},{6}' -f $Gap[$c],'C??,',$Merit6[$c],'Gapcoin,',$Date[$c],$Digits[$c],$gapstart[$c])|Add-Content "$($Path)$($DumpMersenne).csv"}
    Write-Warning "MersenneForum Format Output is '$($Path)$($DumpMersenne).csv'"
    }#End dumping loop
    
    
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
        
    }#End Dump Loop
