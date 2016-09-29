<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER vmname

.PARAMETER master

.PARAMETER vhdpath

.EXAMPLE

#>
[CmdletBinding()]

param (
    [Parameter(Mandatory=$True)]
    [array]$vmname,

    [Parameter(Mandatory=$True)]
    [string]$master,

    [Parameter(Mandatory=$True)]
    [array]$vhdpath
   

)
$vmname | Foreach-object {

    New-VM -Name $_ -MemoryStartupBytes 800MB -Generation 2 -BootDevice VHD -SwitchName Contoso -VHDPath "F:\VHDS\$_.vhdx"
    Set-VMMemory -VMName $_ -DynamicMemoryEnabled $True -MinimumBytes 512MB -MaximumBytes 800MB

    }