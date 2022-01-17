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
write-host -foregroundcolor Darkcyan '___________________________Verifying WCF AppPool___________________________'
""
Import-Module WebAdministration
$webapps = Get-WebApplication
$AppPool1 = "WCF"
$AppPoolList = $AppPool1

foreach($AppPoolName in $AppPoolList){
$list = @()
foreach ($webapp in get-childitem IIS:\AppPools\ | where Name -Match $AppPoolName )
{

Get-ChildItem  IIS:\AppPools\ | where {$_.enable32BitAppOnWin64 -eq $true | Out-Null } 
$AppPool = Get-ChildItem iis:\apppools\ | where Name -Match $AppPoolName
ForEach($pool in $AppPool){

if($pool.enable32BitAppOnWin64 -eq $true){

Write-Host  "32Bit IS" $pool.enable32BitAppOnWin64 "FOR" $AppPoolName  -ForegroundColor Green `n
}
else{

Write-Host  "32Bit IS" $pool.enable32BitAppOnWin64 "FOR" $AppPoolName  -ForegroundColor Red `n
} 
}

$name = "IIS:\AppPools\" + $webapp.name
$item = @{}
$item.server = $computer;
$item.WebAppName = $webapp.name
$item.Version = (Get-ItemProperty $name managedRuntimeVersion).Value
$item.State = (Get-WebAppPoolState -Name $webapp.name).Value
$item.UserIdentityType = $webapp.processModel.identityType
$item.Username = $webapp.processModel.userName
$item.Password = $webapp.processModel.password
$obj = New-Object PSObject -Property $item 
$list += $obj

if((Get-WebAppPoolState -Name $webapp.name).Value -eq 'started'){

Write-Host "Status of" $webapp.name "is"(Get-WebAppPoolState -Name $webapp.name).Value -ForegroundColor Green 

$list | Format-Table -a -Property "WebAppName", "Version", "State", "UserIdentityType", "Username"
write-host -foregroundcolor Darkcyan '__________________________________________________________________________________'
""
}
else
{
Write-Host "Status of" $webapp.name "is" (Get-WebAppPoolState -Name $webapp.name).Value -ForegroundColor Red 
write-host -foregroundcolor Darkcyan '__________________________________________________________________________________'
""
}
}
}
write-host -foregroundcolor Darkcyan '_____________________________________Completed____________________________________'
""
write-host -foregroundcolor Darkcyan '___________________________Verifying CoreCARDServices AppPool_____________________'
""
Import-Module WebAdministration
$webapps = Get-WebApplication
$AppPool1 = "CoreCardServices"
$AppPoolList = $AppPool1

foreach($AppPoolName in $AppPoolList){
$list = @()
foreach ($webapp in get-childitem IIS:\AppPools\ | where Name -Match $AppPoolName )
{

Get-ChildItem  IIS:\AppPools\ | where {$_.enable32BitAppOnWin64 -eq $true | Out-Null } 
$AppPool = Get-ChildItem iis:\apppools\ | where Name -Match $AppPoolName
ForEach($pool in $AppPool){

if($pool.enable32BitAppOnWin64 -eq $false){

Write-Host  "32Bit IS" $pool.enable32BitAppOnWin64 "FOR" $AppPoolName  -ForegroundColor Green `n
}
else{

Write-Host  "32Bit IS" $pool.enable32BitAppOnWin64 "FOR" $AppPoolName  -ForegroundColor Red `n
} 
}

$name = "IIS:\AppPools\" + $webapp.name
$item = @{}
$item.server = $computer;
$item.WebAppName = $webapp.name
$item.Version = (Get-ItemProperty $name managedRuntimeVersion).Value
$item.State = (Get-WebAppPoolState -Name $webapp.name).Value
$item.UserIdentityType = $webapp.processModel.identityType
$item.Username = $webapp.processModel.userName
$item.Password = $webapp.processModel.password
$item.MaxWorkerProcess = $webapp.processModel.maxProcesses
$obj = New-Object PSObject -Property $item 
$list += $obj

if((Get-WebAppPoolState -Name $webapp.name).Value -eq 'started'){

Write-Host "Status of" $webapp.name "is"(Get-WebAppPoolState -Name $webapp.name).Value -ForegroundColor Green 

$list | Format-Table -a -Property "WebAppName", "Version", "State", "UserIdentityType", "Username", "MaxWorkerProcess"
write-host -foregroundcolor Darkcyan '__________________________________________________________________________________'
""
}
else
{
Write-Host "Status of" $webapp.name "is" (Get-WebAppPoolState -Name $webapp.name).Value -ForegroundColor Red 
write-host -foregroundcolor Darkcyan '__________________________________________________________________________________'
""
}
}
}
write-host -foregroundcolor Darkcyan '_____________________________________Completed____________________________________'
""
write-host -foregroundcolor Darkcyan  '___________________________Verifying WCF AppSettings_________________________'
""
$AppSettings = $KMS,$CoreIssueURL
Foreach($Values in $AppSettings){
$SEL = Select-String -Path 'D:\WebServer\WCF\configuration\appSettings.config' -Pattern $Values
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
write-host -foregroundcolor Darkcyan  '_____________________________________Completed_______________________________'
""
write-host -foregroundcolor Darkcyan  '___________________________Verifying CoreCARD Services_______________________'
""
$DBName = $CoreIsseDB,$CoreAuthDB,$CoreLibraryDB,$DBServer
Foreach($Values in $DBName){
$SEL = Select-String -Path 'D:\WebServer\CoreCardServices\connectionStrings.config' -Pattern $Values
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

write-host -foregroundcolor Darkcyan  '_____________________________________Completed_______________________________'
""
write-host -foregroundcolor Darkcyan  '____________________Verifying CoreIssue Site Accessibility___________________'
""
$HTTP_Request = curl $CoreIssueURL
$HTTP_Status = $HTTP_Request.StatusCode
if ($HTTP_Status -eq 200) {
    Write-Host -ForegroundColor Green "SUCCESS:: CoreIssue Site is Accessible on $Hostname"
}
Else {
    Write-Host -ForegroundColor Red "ERROR:: CoreIssue Site is not Accessible on $Hostname"
}
write-host -foregroundcolor Darkcyan  '____________________________________Completed_________________________________'
""

Pause