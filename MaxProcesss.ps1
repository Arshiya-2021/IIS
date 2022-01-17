Import-Module WebAdministration

$poolname = services

Get-ItemProperty -Path "IIS:\AppPools\$poolname" -name "processModel" | select-Object maxProcesses