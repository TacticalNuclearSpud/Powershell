<#
.SYNOPSIS
Get-FreeSpace checks logical disk free space on one or more computers
.DESCRIPTION
Get-FreeSpace uses WMI to retrieve the Win32_LogicalDisk instances from one or more computers. It displays each disk's drive letter, free space, total size.
.PARAMETER computername
The computer name, or names, to query. Default : localhost
.PARAMETER freespace
The freespace threshold to check for. Default: .1 (10%)
.EXAMPLE
Get-FreeSpace -ComputerName WMT-RDS01 -FreeSpace .1
#>

param (
    $computername = "localhost",
    $freespace = .1
)

Get-WmiObject win32_logicalDisk -ComputerName $computername `
    -Filter "drivetype=3" |
    Where-Object { $_.FreeSpace /$_.Size -lt "$freespace" } |
    Select-Object -Property DeviceID,FreeSpace,Size