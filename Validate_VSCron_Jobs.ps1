# Get-AllVCJobs returns a list of all the jobs in VisualCron server for the current machine
function Get-AllVCJobs
{
    [CmdletBinding()]
    param ([string]$ComputerName,
           [int]$Port,
           [System.Management.Automation.PSCredential]$Credential,
           [switch]$Active)

    $ps = New-Object Collections.Hashtable($psBoundParameters)
    $ps.Remove('Active') | Out-Null
    # Connect to the Server
    $server = Get-VCServer @ps
    # Get all the jobs
    $server.Jobs.GetAll() `
    | ? { !($Active) -or $_.Stats.Active } `
    | Add-Member ScriptMethod Start { $server.Jobs.Run($this, $false, $false, $false, $null) }.GetNewClosure() -PassThru
}

Get-AllVCJobs | Select-Object 'Name' , 'Group'