#command to check NAT IP
command : curl checkip.amazonaws.com
o/p: 18.232.205.211

#to check DC details
Get-ADDomainController
Get-ADDomainController –ForceDiscover -Discover -Service ADWS

#command to list users in DC
Get-ADForest | fl Name,ForestMode
Get-ADDomain | fl Name,DomainMode
Get-ADUser -Filter * -Properties samAccountName | select samAccountName

#command to create new-user
New-ADUser -Name "Jack Robinson" -GivenName "Jack" -Surname "Robinson" -SamAccountName "J.Robinson" -UserPrincipalName "J.Robinson@enterprise.com" -Path "OU=Managers,DC=enterprise,DC=com" -AccountPassword(Read-Host -AsSecureString "Input Password") -Enabled $true

#create new domain user
New-ADUser -Name $NewUser -DisplayName $NewName -GivenName $firstname -Surname $lastname -AccountPassword (Read-Host "New Password" -AsSecureString)

#command to list configured users 
Get-ADUser -Filter * -SearchBase "CN=Users,DC=contoso,DC=com" | Format-Table Name, samAccountName, ObjectClass, Enabled
Get-ADUser -Filter * -Properties samAccountName | select samAccountName
Get-ADUser -Filter * -SearchBase "CN=Users,DC=contoso,DC=com" 
Get-ADUser -Filter * -SearchBase "CN=Users,DC=contoso,DC=com" | Format-Table Name, samAccountName, ObjectClass

add-computer -computername (get-content servers.txt) -domainname ad.contoso.com –credential AD\adminuser -restart –force

#join or unjoin workgroup
$computer = Get-WmiObject Win32_ComputerSystem 
$computer.UnjoinDomainOrWorkGroup("AdminPassw0rd", "AdminAccount", 0) 
$computer.JoinDomainOrWorkGroup("DomainName", "AdminPassw0rd", "AdminAccount", $null, 3) 
Restart-Computer -Force

#