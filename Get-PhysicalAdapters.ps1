<#
.SYNOPSIS
Get-PhysicalAdapters retrieves network adapter information from one or more computers.
.DESCRIPTION
Get-PhysicalAdapter uses WMI to retrieve the Win32_NetworkAdapter instances from one or more computers. It displays each adapters MAC Address, Adapter Type, Device ID, Name and Speed.
.PARAMETER computername
The computer name, or names, to query.
.EXAMPLE
Get-PhysicalAdapters -computername SERVER-R2 
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [Alias('hostname')]
    [string]$computername
)
write-verbose "Connecting to $computername"     
Get-WmiObject win32_networkadapter -ComputerName $computername | 
    where { $_.PhysicalAdapter } |
    select MACAddress,AdapterType,DeviceID,Name,Speed

Write-Verbose "Disconnecting from $computername"