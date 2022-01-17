#Initialize-AWSDefaultconfiguration -AccessKey AKIATC4BRTUBBIJM32F5 -SecretKey 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 -Region us-east-2
#Copy-S3Object -BucketName test-bucket-june-18-2021 -KeyPrefix Reporting_Services_Configuration_Manager -LocalFolder E:\ -Force

#& "E:\SQLServerReportingServices.exe" E:\ -q -s /run /exit /SilentMode -verb runas /s /v" /qn"

$DatabaseInstance = 'DB'

$lcid = '1033'

$DatabaseName = 'ReportServer'

$UserName = 'Test\Soheb'

$Password = ConvertTo-SecureString "Password@123" -AsPlainText -Force

#$SqlCredential = (Get-Credential)

$wmiName = (Get-WmiObject –namespace root\Microsoft\SqlServer\ReportServer  –class __Namespace).Name

$rsConfig = Get-WmiObject –namespace "root\Microsoft\SqlServer\ReportServer\$wmiName\v15\Admin" -class MSReportServer_ConfigurationSetting -filter "InstanceName='SSRS'"

#CheckHResult $rsConfig.SetDatabaseConnection($DatabaseInstance, $DatabaseName, 2, $SqlCredential.UserName, $SqlCredential.GetNetworkCredential().Password)

$rsConfig.SetDatabaseConnection($DatabaseInstance, $DatabaseName, 2, $UserName, $Password )

$rsConfig.SetVirtualDirectory("ReportServerWebService","ReportServerWebService",$lcid)

$rsConfig.ReserveURL("ReportServer","http://+:80",$lcid)

$rsConfig.SetVirtualDirectory("Reports","Reports",$lcid)

$rsConfig.ReserveURL("Reports","http://+:80",$lcid)

$rsConfig.SetServiceState($true,$true,$true)