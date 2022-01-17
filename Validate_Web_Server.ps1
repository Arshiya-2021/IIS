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
write-host -foregroundcolor Darkcyan  '___________________________Verifying Source IPs of DbbScale File_________________________'
""
$target = [System.Net.Dns]::GetHostAddresses("$Hostname") | foreach {echo $_.IPAddressToString } | Select-Object -Last 1
$SEL = Select-String -Path D:\WebServer\DBBScale\dbbScale.ini -Pattern $target
if ($SEL -ne $null)
{
    Write-Host -ForegroundColor Green "SUCCESS:: $target is Present on $Hostname" 
}
else
{
    Write-Host -ForegroundColor Red "ERROR:: $target is not Present on $Hostname" 
}
""
write-host -foregroundcolor Darkcyan  '_________________________________________Completed_______________________________________'
""
write-host -foregroundcolor Darkcyan  '___________________________Verifying Sink IPs of DbbScale File___________________________'
""
##SVC 
$ec2List = Get-EC2Instance -Filter @{'name'='instance-state-name';'values'='running'}
$noAgentList = $ec2List.Instances | Where-Object {($_ | Select-Object -ExpandProperty tags | Where-Object -Property Key -eq Name ).value -like "*SVC*"}
New-Item -Path D:\ServerDetails.csv -ItemType File | Out-Null
$ec2DetailsList = $noAgentList| ForEach-Object {
$properties = [ordered]@{
#Name = ($_ | Select-Object -ExpandProperty tags | Where-Object -Property Key -eq Name).value
PrivateIP = $_.PrivateIpAddress 
}
New-Object -TypeName PSObject -Property $properties
}
$ec2DetailsList | Out-File D:\ServerDetails.csv  | Out-Null
$regexIPSpace = '(10|172|192).\d{1,3}\.\d{1,3}\.\d{1,3}\b'
$IP=Select-String -Path D:\ServerDetails.csv -Pattern $regexIPSpace | ForEach-Object { $_.Matches } | % { $_.Value } | Sort-Object -Unique
#authip1.csv is scale file from clientside
$IP1= Select-String -Path 'D:\WebServer\DBBScale\dbbScale.ini' -Pattern $regexIPSpace | ForEach-Object { $_.Matches } | % { $_.Value } | Sort-Object -Unique 
foreach($ScaleIP in $IP){
if($IP1 -contains $ScaleIP )
{
$RemoteHost = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ScaleIP -Property Name | ForEach-Object {$_.Name}
Write-Host "SUCCESS:: $RemoteHost is Present on $Hostname DbbScaleFile" -ForegroundColor green
}
else
{
write-host "ERROR:: $RemoteHost is not Present on $Hostname DbbScaleFile" -ForegroundColor red
} 
}
Remove-Item -path D:\ServerDetails.csv -Force -Recurse 
##ISSUE
$ec2List = Get-EC2Instance -Filter @{'name'='instance-state-name';'values'='running'}
$noAgentList = $ec2List.Instances | Where-Object {($_ | Select-Object -ExpandProperty tags | Where-Object -Property Key -eq Name ).value -like "*ISSUE*"}
New-Item -Path D:\ServerDetails.csv -ItemType File | Out-Null
$ec2DetailsList = $noAgentList| ForEach-Object {
$properties = [ordered]@{
#Name = ($_ | Select-Object -ExpandProperty tags | Where-Object -Property Key -eq Name).value
PrivateIP = $_.PrivateIpAddress 
}
New-Object -TypeName PSObject -Property $properties
}
$ec2DetailsList | Out-File D:\ServerDetails.csv  | Out-Null
$regexIPSpace = '(10|172|192).\d{1,3}\.\d{1,3}\.\d{1,3}\b'
$IP=Select-String -Path D:\ServerDetails.csv -Pattern $regexIPSpace | ForEach-Object { $_.Matches } | % { $_.Value } | Sort-Object -Unique
#authip1.csv is scale file from clientside
$IP1= Select-String -Path 'D:\WebServer\DBBScale\dbbScale.ini' -Pattern $regexIPSpace | ForEach-Object { $_.Matches } | % { $_.Value } | Sort-Object -Unique 
foreach($ScaleIP in $IP){
if($IP1 -contains $ScaleIP )
{
$RemoteHost = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ScaleIP -Property Name | ForEach-Object {$_.Name}
Write-Host "SUCCESS:: $RemoteHost is Present on $Hostname DbbScaleFile" -ForegroundColor green
}
else
{
write-host "ERROR:: $RemoteHost is not Present on $Hostname DbbScaleFile" -ForegroundColor red
} 
}
Remove-Item -path D:\ServerDetails.csv -Force -Recurse
##AUTH
$ec2List = Get-EC2Instance -Filter @{'name'='instance-state-name';'values'='running'}
$noAgentList = $ec2List.Instances | Where-Object {($_ | Select-Object -ExpandProperty tags | Where-Object -Property Key -eq Name ).value -like "*AUTH*"}
New-Item -Path D:\ServerDetails.csv -ItemType File | Out-Null
$ec2DetailsList = $noAgentList| ForEach-Object {
$properties = [ordered]@{
#Name = ($_ | Select-Object -ExpandProperty tags | Where-Object -Property Key -eq Name).value
PrivateIP = $_.PrivateIpAddress 
}
New-Object -TypeName PSObject -Property $properties
}
$ec2DetailsList | Out-File D:\ServerDetails.csv  | Out-Null
$regexIPSpace = '(10|172|192).\d{1,3}\.\d{1,3}\.\d{1,3}\b'
$IP=Select-String -Path D:\ServerDetails.csv -Pattern $regexIPSpace | ForEach-Object { $_.Matches } | % { $_.Value } | Sort-Object -Unique
#authip1.csv is scale file from clientside
$IP1= Select-String -Path 'D:\WebServer\DBBScale\dbbScale.ini' -Pattern $regexIPSpace | ForEach-Object { $_.Matches } | % { $_.Value } | Sort-Object -Unique 
foreach($ScaleIP in $IP){
if($IP1 -contains $ScaleIP )
{
$RemoteHost = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ScaleIP -Property Name | ForEach-Object {$_.Name}
Write-Host "SUCCESS:: $RemoteHost is Present on $Hostname DbbScaleFile" -ForegroundColor green
}
else
{
write-host "ERROR:: $RemoteHost is not Present on $Hostname DbbScaleFile" -ForegroundColor red
} 
}
Remove-Item -path D:\ServerDetails.csv -Force -Recurse 
""
write-host -foregroundcolor Darkcyan  '_________________________________________Completed_______________________________________'
""
write-host -foregroundcolor Darkcyan  '___________________________Verifying AccountSummary ConfigFile___________________________'
""
$SEL = Select-String -Path D:\WebServer\Services\CoreCardServices\CoreCardServices.svc\AccountSummary\Web.config -Pattern $AccountSummaryURL
if ($SEL -ne $null)
{
    Write-Host -ForegroundColor Green "SUCCESS:: AccountSummary ConfigFile is up to date on $Hostname" 
}
else
{
    Write-Host -ForegroundColor Red "ERROR:: AccountSummary ConfigFile is not up to date on $Hostname" 
}
""
write-host -foregroundcolor Darkcyan  '_________________________________________Completed_______________________________________'
""
write-host -foregroundcolor Darkcyan  '________________________Verifying PersonAccountSummary ConfigFile________________________'
""
$SEL = Select-String -Path D:\WebServer\Services\CoreCardServices\CoreCardServices.svc\PersonAccountSummary\Web.config -Pattern $AccountSummaryURL
if ($SEL -ne $null)
{
    Write-Host -ForegroundColor Green "SUCCESS:: PersonAccountSummary ConfigFile is up to date on $Hostname" 
}
else
{
    Write-Host -ForegroundColor Red "ERROR:: PersonAccountSummary ConfigFile is not not up to date on $Hostname" 
}
""
write-host -foregroundcolor Darkcyan  '_________________________________________Completed_______________________________________'
""
write-host -foregroundcolor Darkcyan  '_____________________________________ARR Verification____________________________________'
""
$ARRCheck = Get-WmiObject -Class Win32_Product | where Name -eq "IIS URL Rewrite Module 2"

if ($ARRCheck.Name -ne $null)
{
    Write-Host -ForegroundColor Green "SUCCESS:: IIS URL Rewrite Module 2 is Available" 
}
else
{
    Write-Host -ForegroundColor Red "ERROR:: IIS URL Rewrite Module 2 is not Available" 
}
write-host -foregroundcolor Darkcyan  '_____________________________________Completed____________________________________'
""
write-host -foregroundcolor Darkcyan  '___________________________Verifying Services Handler Version_____________________'
""
Import-Module WebAdministration
$IP = (Get-WebBinding "Services" |Select-Object -ExpandProperty bindingInformation|Select-Object -Last 1)
$IP = $IP.Substring(0,$IP.Length-4)
Write-Host $IP
$URL = "http://$IP/appServices.aspx?getservletversion=1"
$WebCall = (curl $URL | Select-Object Content | Select-string $PlatformVersion)
if ($WebCall -ne $null)
{
    Write-Host -ForegroundColor Red "ERROR:: Handler is not Up to date on $Hostname" 
}
else
{
    Write-Host -ForegroundColor Green "SUCCESS:: Handler is Up to date on $Hostname" 
}
write-host -foregroundcolor Darkcyan  '_____________________________________Completed____________________________________'
""
write-host -foregroundcolor Darkcyan  '_________________________Verifying CoreIssue Handler Version______________________'
""
Import-Module WebAdministration
$IP = (Get-WebBinding "CoreIssue" |Select-Object -ExpandProperty bindingInformation|Select-Object -Last 1)
$IP = $IP.Substring(0,$IP.Length-4)
Write-Host $IP
$URL = "http://$IP/appCoreIssue.aspx?getservletversion=1"
$WebCall = (curl $URL | Select-Object Content | Select-string $PlatformVersion)
if ($WebCall -ne $null)
{
    Write-Host -ForegroundColor Red "ERROR:: Handler is not Up to date on $Hostname" 
}
else
{
    Write-Host -ForegroundColor Green "SUCCESS:: Handler is Up to date on $Hostname" 
}
write-host -foregroundcolor Darkcyan  '_____________________________________Completed____________________________________'
""
write-host -foregroundcolor Darkcyan  '_______________________________Verifying API Status_______________________________'
""
Import-Module WebAdministration
$IP = (Get-WebBinding "CoreIssue" |Select-Object -ExpandProperty bindingInformation|Select-Object -Last 1)
$IP = $IP.Substring(0,$IP.Length-4)
Write-Host $IP
$URL = "http://$IP/CoreCardServices/CoreCardServices.svc/IsOnline"
$WebCall = (curl $URL | Select-Object Content | Select-string LoginFailure)
if ($WebCall -ne $null)
{
    Write-Host -ForegroundColor Red "ERROR:: APIs are not working on $Hostname" 
}
else
{
    Write-Host -ForegroundColor Green "SUCCESS:: APIs are working on $Hostname" 
}
write-host -foregroundcolor Darkcyan  '_____________________________________Completed_________________________________'
""
write-host -foregroundcolor Darkcyan  '_______________________________CoreCredit Status_______________________________'
""
Import-Module WebAdministration
$IP = (Get-WebBinding "CoreIssue" |Select-Object -ExpandProperty bindingInformation|Select-Object -Last 1)
$IP = $IP.Substring(0,$IP.Length-4)
Write-Host $IP
$URL = "http://$IP/WebServices/Monitoring/MonitoringServices.asmx/AppVersion"
$WebCall = (curl $URL | Select-Object Content | Select-string CoreCredit_Is_UP)
if ($WebCall -ne $null)
{
    Write-Host -ForegroundColor Red "ERROR:: CoreCredit is not working on $Hostname" 
}
else
{
    Write-Host -ForegroundColor Green "SUCCESS:: CoreCredit is working on $Hostname" 
}
write-host -foregroundcolor Darkcyan  '_____________________________________Completed_________________________________'
""

Pause