foreach ($ip in ([System.IO.File]::ReadLines("D:\Ip_list.txt")))
{
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value $ip
$Session = New-PSSession -ComputerName $ip -Credential "Test\soheb"
Copy-Item "D:\WebServer\ScaleService\tmp\*.ini" -Destination "D:\DBBSETUP\ScaleFiles\" -ToSession $Session -Recurse
}


