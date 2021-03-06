    #Line to eventually edit : 4,5,128.
    #Line to eventually comment/uncomment for a custom format : 14 to 80.
    #Dir and Files paths
    $Path="C:\Temp\test\old\";$Raw="Dump.csv"
    $DumpMersenne="$($Path)Dump_Mersenne.csv";$DumpCustom="$($Path)Dump_Custom.csv"
    $DumpTroisi="$($Path)Dump_Troisi.csv"
    $FDate=((Get-Date) -replace " ","_" -replace ":" -replace "/")
      

    #1/3 CONVERT RAW DATA INTO VARIABLES
    ###############################################
    ######Custom Format Output from RAW datas######
    ###############################################
    $In=(Get-Content "$($Path)$($Raw)")
    #$hash=$In|Where{$_ -match '"hash" :'}
    #$hash=$hash -replace '    "hash" : ' -replace '"'
    #$hash=@("hash,") + $hash
    #$size=$In|Where{$_ -match '"size" :'}
    #$size=$size -replace '    "size" : '
    #$size=@("size,") + $size
    $height=$In|Where{$_ -match "height"}
    $height=$height -replace '    "height" : '
    $height=@("height,") + $height
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
    $gaplen=$In|Where{$_ -match "gaplen"}
    $gaplen=$gaplen -replace '    "gaplen" : '
    $Gap=@("Gap,") + $gaplen
    $merit=$In|Where{$_ -match "merit"}
    $merit=$merit -replace '    "merit" : '
    $Merit6=ForEach($long in $merit){$long.Substring(0,$long.length-3)}
    $Merit6=@("Merit6") + $Merit6


    #2/3 CONVERT CLEAN VARIABLES DATA INTO CUSTOM FORMAT
    ###############################################
    ######Custom Format Output from RAW datas######
    ###############################################
    #If Clean DumpBlocks file exist, rename with formatted date
    If ((Test-Path -Path $DumpCustom -PathType Leaf) -eq $True){
    $Null=Rename-Item -Path $DumpCustom -NewName "$($DumpCustom)_$($FDate).csv" -Force -ErrorAction Ignore}
    for($c = 0; $c -lt $height.Count; $c++){
    #Adapt this to selection or swap columns
    ('{0}{1}{2}{3}{4}{5}{6},{7}{8}' -f $height[$c],$Date[$c],$nonce[$c],$adder[$c],$difficulty[$c],$shift[$c],$Merit6[$c],$Gap[$c],$gapstart[$c])|Add-Content "$($Path)$($DumpCustom)"}
    Write-Warning "Final Clean Output path is $DumpCustom"


    #3/3 CONVERT CLEAN VARIABLES DATA INTO MERSENNE FORUM SUBMISSON FORMAT
    ###############################################
    ###### Custom Format for Mersenne Forum  ######
    ###############################################
    #If MersenneForum DumpBlocks file exist, rename with formatted date
    If ((Test-Path -Path $DumpMersenne -PathType Leaf) -eq $True){
    $Null=Rename-Item -Path $DumpMersenne -NewName "$($DumpMersenne)_$($FDate).csv" -Force -ErrorAction Ignore}
    for($c = 0; $c -lt $height.Count; $c++){
    #If next is edited, no more for submission
    ('{0}C??,{2},Gapcoin,{4}{5},{6}' -f $Gap[$c],'C??,',$Merit6[$c],'Gapcoin,',$Date[$c],$Digits[$c],$gapstart[$c])|Add-Content $DumpMersenne }
    Write-Warning "Final MersenneForum Output path is $DumpMersenne"


    #5/5 CONVERT CLEAN VARIABLES DATA INTO S.Troisi SUBMISSION FORMAT
    ###############################################
    ##### Custom Format for S.Troisi AutoSub  #####
    ###############################################
    #If Clean DumpBlocks file doesn't exist, create with headers
    If ((Test-Path -Path $DumpTroisi -PathType Leaf) -eq $False){
    $Null=Add-Content -Path $DumpTroisi -Value "Gap Date Discoverer Merit6 Gapstart"}
    #If next one is edited, no more for submission
    "$gaplen $blockdates Gapcoin $Merit6 $gapstart"|Add-Content $DumpTroisi
    Write-Warning "S.Troisi Format Output path is $DumpTroisi"
