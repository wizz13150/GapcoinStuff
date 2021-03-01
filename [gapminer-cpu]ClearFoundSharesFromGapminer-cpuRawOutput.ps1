Get-Content "C:\Temp\Output.txt" | Where { $_ -match "accepted" } | ForEach {
$stuff = $_ -replace "  =>  accepted" -replace " Found Share:"," ;" -replace "]" -replace "\.",","
$stuff.Remove(0,1)
} | Set-Content C:\Temp\Result.txt
