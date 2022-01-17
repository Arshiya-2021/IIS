write-host -foregroundcolor Darkcyan  '_______________________________________'
HostName
write-host -foregroundcolor Darkcyan  '_______________________________________'
""
""
$Path = Split-Path $MyInvocation.MyCommand.Path
# Determine Script Drive
$Drive = (Get-Item $Path).Root.Name
Remove-Variable -Force HOME
Set-Variable HOME $Path
###########################################Call PowerShell Variable File##############################################
. "$HOME\SetupFile.ps1"
######################################################################################################################
$Hostname = Hostname
write-host -foregroundcolor Darkcyan  '___________________________MIP Connection Test___________________________'
""
$TestCon = Test-NetConnection -computername $MIPEndPoint -port $MIPPort

if ($TestCon.TcpTestSucceeded -ne "True")
{
    Write-Host -ForegroundColor Red "ERROR:: Connection Failed" 
}
else
{
    Write-Host -ForegroundColor Green "SUCCESS:: Connection Established" 
}
write-host -foregroundcolor Darkcyan  '_____________________________________Completed____________________________________'
""
write-host -foregroundcolor Darkcyan  '___________________________HSM Connection Test___________________________'
""
$TestCon = Test-NetConnection -computername $HSMEndPoint -port $HSMPort

if ($TestCon.TcpTestSucceeded -ne "True")
{
    Write-Host -ForegroundColor Red "ERROR:: Connection Failed" 
}
else
{
    Write-Host -ForegroundColor Green "SUCCESS:: Connection Established" 
}
write-host -foregroundcolor Darkcyan  '_____________________________________Completed____________________________________'
""
Pause