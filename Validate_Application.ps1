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
write-host -foregroundcolor Darkcyan  '___________________________Verifying DSLs Version___________________________'
""
$SEL = Select-String -Path D:\DBBSetup\DSLs\CI\About.dsl -Pattern $ApplicationVersion
$SEL = Select-String -Path D:\DBBSetup\DSLs\CoreAuth\About.dsl -Pattern $ApplicationVersion
if ($SEL -ne $null)
{
    Write-Host -ForegroundColor Green "SUCCESS:: DSL is Up to date on $HostName" 
}
else
{
    Write-Host -ForegroundColor Red "ERROR:: DSL is not Up to date on $HostName" 
}
""
write-host -foregroundcolor Darkcyan  '_____________________________________Completed_______________________________'
""
write-host -foregroundcolor Darkcyan  '___________________________Verifying Platform Version________________________'
""
$SEL = Select-String -Path D:\CC_Runtime\appsys30.dsl -Pattern $PlatformVersion
if ($SEL -ne $null)
{
    Write-Host -ForegroundColor Green "SUCCESS:: PlatformCode is Up to date on $HostName" 
}
else
{
    Write-Host -ForegroundColor Red "ERROR:: PlatformCode is not Up to date on $HostName" 
}
""
write-host -foregroundcolor Darkcyan  '_____________________________________Completed_______________________________'
""
write-host -foregroundcolor Darkcyan  '___________________________Verifying SetupCI Configuration___________________'
""
$Config = $CoreIsseDB,$CoreAuthDB,$CoreCreditDB,$CoreLibraryDB,$CoreAppDB,$CoreCollectDB,$ODBCName,$DBServer
Foreach($Values in $Config){
$SEL = Select-String -Path 'D:\DBBSetup\BatchScripts\CoreIssue\SetupCI.bat' -Pattern $Values
if($SEL -ne $null)
{
Write-Host -ForegroundColor Green "SUCCESS:: $Values SetupCI is up to date on $Hostname!!"
}
else
{
Write-host -ForegroundColor Red  "ERROR:: $Values SetupCI is up to date on $Hostname!!"
}
}
""
write-host -foregroundcolor Darkcyan  '_____________________________________Completed________________________________'
""
write-host -foregroundcolor Darkcyan  '___________________________Verifying CoreAuthSetup Configuration______________'
""
$Config = $CoreIsseDB,$CoreAuthDB,$CoreCreditDB,$CoreLibraryDB,$CoreAppDB,$CoreCollectDB,$ODBCName,$DBServer
Foreach($Values in $Config){
$SEL = Select-String -Path 'D:\DBBSetup\BatchScripts\CoreAuth\CoreAuthSetup.bat' -Pattern $Values
if($SEL -ne $null)
{
Write-Host -ForegroundColor Green "SUCCESS:: $Values Database is present on $Hostname!!"
}
else
{
Write-host -ForegroundColor Red  "ERROR:: $Values Database is not present on $Hostname!!"
}
}
""
write-host -foregroundcolor Darkcyan  '_____________________________________Completed_________________________________'
""
Pause