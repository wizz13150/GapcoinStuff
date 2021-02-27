    #1/4 PRODUCE RAW OUTPUT FROM GAPCOIN BLOCKCHAIN
    #Sections 2,3,4 can be used separately with partial DumpBlocks_* file. Only need line 7 variables to run. 
    #NB: Output from gapcoin-cli.exe takes 2 sec to come and I need to wait for it, need to find a way to be way faster.
    #How to: Set line 8, put gapcoin-cli in $Path directory. Run script from everywhere.
    #Lines to eventually edit : 8,131.
    #Lines to eventually comment/uncomment for a custom output format : 50 to 116.
    #First & Last block (+1 excluded). Dir Path
    $f=$s=1;$Last=1001;$Path="C:\Temp\Test\"

    #Repeated variables & Date
    $stdout="$($Path)stdout.txt";$hashout="$($Path)hashout.txt";$Proc="$($Path)gapcoin-cli.exe"
    $FDate=((Get-Date) -replace " ","_" -replace ":" -replace "/")
    #If DumpBlocks file exist, rename with formatted date
    If ((Test-Path -Path "$($Path)DumpBlocks_$($s)-$($Last-1).csv" -PathType Leaf) -eq $True){
    $Null=Rename-Item -Path "$($Path)DumpBlocks_$($s)-$($Last-1).csv" -NewName "$($Path)DumpBlocks_$($s)-$($Last-1)_$($FDate).csv" -Force -ErrorAction Ignore}
    #Request first Hash & Block before loop
    Write-Warning "Processing First Hash, Block and NextHash."
    $Null=Start-Process $Proc -Argumentlist "getblockhash $f" -Wait -RedirectStandardOutput $hashout -WindowStyle Hidden -PassThru
    $FirstHash=Get-Content $hashout
    $Null=Start-Process $Proc -Argumentlist "getblock $FirstHash" -Wait -RedirectStandardOutput $stdout -WindowStyle Hidden -PassThru
    $FirstHash=Get-Content $hashout
    $FirstBlock=Get-Content $stdout
    $FirstBlock|Add-Content "$($Path)DumpBlocks_$($s)-$($Last-1).csv"
    $NextHash=$FirstBlock| Where {$_ -match "nextblockhash"}
    $Array=$NextHash.ToString()
    $NextHash=$Array.Split('"')[3]
    $f++
    Write-Warning "Starting Loop..."
    #Start Loop
while($f -lt $Last){$Timer=Measure-Command{    
    Write-Warning "Processing Block $f/$($Last-1.)"
    $Null=Start-Process $Proc -Argumentlist "getblock $NextHash" -Wait -RedirectStandardOutput $stdout -ErrorAction Continue -WindowStyle Hidden -PassThru
    $Output=Get-Content $stdout
    $Output|Add-Content "$($Path)DumpBlocks_$($s)-$($Last-1).csv"
    $Stuff=$output|Select-String -SimpleMatch nextblockhash
    $Array=$Stuff.ToString()
    $NextHash=$Array.Split('"')[3]}
    $f++
    Write-Warning "$($Timer.TotalSeconds) sec ellapsed."}
    Remove-Item $hashout -Force
    Remove-Item $stdout -Force
    Write-Warning "Final Raw Output is '$($Path)DumpBlocks_$($s)-$($Last-1).csv'"
    

    #2/4 CONVERT RAW DATA INTO VARIABLES
    ###############################################
    ######Custom Format Output from RAW datas######
    ###############################################     
    $In=(Get-Content "$($Path)DumpBlocks_$($s)-$($Last-1).csv")
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
    ##$tx=$In|Where{$_ -match "tx"}                 #Ligne +1 ToDo, doesn't works
    ##$tx=$tx -replace '    "tx" : ' -replace '"'   #Ligne +1 ToDo, doesn't works
    ##$tx=@("tx,") + $tx                            #Ligne +1 ToDo, doesn't works
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
    #If Clean DumpBlocks file exist, rename with formatted date
    If ((Test-Path -Path "$($Path)DumpBlocks_$($s)-$($Last-1)_Clean.csv" -PathType Leaf) -eq $True){
    $Null=Rename-Item -Path "$($Path)DumpBlocks_$($s)-$($Last-1)_Clean.csv" -NewName "$($Path)DumpBlocks_$($s)-$($Last-1)_Clean_$($FDate).csv" -Force -ErrorAction Ignore}
    for($c = 0; $c -lt $height.Count; $c++){
    #Adapt this to selection or swap columns
    ('{0}{1}{2}{3}{4}{5}{6}{7}{8}' -f $height[$c],$Date[$c],$nonce[$c],$adder[$c],$difficulty[$c],$shift[$c],$Merit6[$c],$Gap[$c],$gapstart[$c])|Add-Content "$($Path)DumpBlocks_$($s)-$($Last-1)_Clean.csv"}
    Write-Warning "Final Clean Output is '$($Path)DumpBlocks_$($s)-$($Last-1)_Clean.csv'"


    #4/4 CONVERT CLEAN VARIABLES DATA INTO MERSENNE FORUM SUBMISSON FORMAT
    ###############################################
    ###### Custom Format for Mersenne Forum  ######
    ###############################################
    #If MersenneForum DumpBlocks file exist, rename with formatted date
    If ((Test-Path -Path "$($Path)DumpBlocks_$($s)-$($Last-1)_MersenneForum.csv" -PathType Leaf) -eq $True){
    $Null=Rename-Item -Path "$($Path)DumpBlocks_$($s)-$($Last-1)_MersenneForum.csv" -NewName "$($Path)DumpBlocks_$($s)-$($Last-1)_MersenneForum_$($FDate).csv" -Force -ErrorAction Ignore}
    for($c = 0; $c -lt $height.Count; $c++){
    #If next is edited, no more for submission
    ('{0}C??,{2},Gapcoin,{4}{5},{6}' -f $Gap[$c],'C??,',$Merit6[$c],'Gapcoin,',$Date[$c],$Digits[$c],$gapstart[$c])|Add-Content "$($Path)DumpBlocks_$($s)-$($Last-1)_MersenneForum.csv"}
    Write-Warning "Final MersenneForum Output is '$($Path)DumpBlocks_$($s)-$($Last-1)_MersenneForum.csv'"
