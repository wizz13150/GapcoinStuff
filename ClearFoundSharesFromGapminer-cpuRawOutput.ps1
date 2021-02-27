Get-Content "C:\Users\Wizz\Desktop\Output - Copie.txt" | Where { $_ -match "accepted" } | ForEach {
$stuff = $_ -replace "  =>  accepted" -replace " Found Share:"," ;" -replace "]" -replace "\.",","
$stuff.Remove(0,1)
} | Set-Content C:\Users\Wizz\Desktop\Result.txt
