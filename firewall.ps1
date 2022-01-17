New-NetFirewallRule -DisplayName 'Allow-Webserver-Ports-81,82,83' -Profile @('Domain', 'Private', 'Public') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @('81', '82', '83')
New-NetFirewallRule -DisplayName 'WinRM over HTTPS and HTTP' -Profile @('Domain', 'Private', 'Public') -Direction Inbound -Action Allow -Protocol TCP -LocalPort @('5985', '5986')
