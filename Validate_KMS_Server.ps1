#Maxworkerprocesses AppPools
#Get-ItemProperty -Path "IIS:\AppPools\services" -name "processModel" | select-object 'maxProcesses'

#maxProcesses
#------------
#           1

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
write-host -foregroundcolor Darkcyan  '___________________________Verifying KMS Configuration___________________'
""
$Config = $ODBCName,$KMSDB
Foreach($Values in $Config){
$SEL = Select-String -Path 'D:\KMS\KMM\KMService.exe.config' -Pattern $Values
if($SEL -ne $null)
{
Write-Host -ForegroundColor Green "SUCCESS:: $Values Configuration is Up to date on $Hostname!!"
}
else
{
Write-host -ForegroundColor Red  "ERROR:: $Values Configuration is not Up to date on $Hostname!!"
}
}
""
write-host -foregroundcolor Darkcyan  '_____________________________________Completed____________________________'
""
write-host -foregroundcolor Darkcyan  '___________________________Verifying KMS Service__________________________'
""
$serviceName = 'KMSService'
If (Get-Service $serviceName -ErrorAction SilentlyContinue) 
{
If ((Get-Service $serviceName ).Status -eq 'Running') 

{
     write-host "SUCCESS:: $serviceName found and is running on  $Hostname!!" -ForegroundColor green
} 
else
{
     write-host "ERROR:: $serviceName found, but it is not running on $Hostname!!" -Foregroundcolor Red
} 
}
else 
{
write-host "ERROR:: $serviceName not found on $Hostname!!" -ForegroundColor Red
}
""
write-host -foregroundcolor Darkcyan  '_____________________________________Completed_____________________________'
""

Pause