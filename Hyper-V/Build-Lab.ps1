<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER vmname
Name of VM or VMs you wish to create.

.PARAMETER master
Path to master vhd

.PARAMETER vhdpath
Path to VHD storage

.PARAMETER generation
Generation 1 or 2 VM. Default 1.

.EXAMPLE
Build-lab -VMName SERVER-1, SERVER-2 -Master "E:\MASTER.vhdx" -VHDPath "E:\VHDS\"
#>
[CmdletBinding()]

param (
    [Parameter(Mandatory=$True)]
    [array]$vmname,

    [Parameter(Mandatory=$True)]
    [string]$master,

    [Parameter(Mandatory=$True)]
    [array]$vhdpath,

    [int]$generation = 1
   

)

$vmname | Foreach-object {

    #set destination directory for new vhdx files
    $destination = "$vhdpath$_.vhdx"

    #copy and rename master image to vhd path
    Write-Verbose "Copying $master to $destination"
    Copy-Item -Path $master -Destination $destination

    #create VM's
    Write-Verbose "Creating $_ VM"
    New-VM -Name $_ -MemoryStartupBytes 800MB -Generation $generation -BootDevice VHD -SwitchName Contoso -VHDPath $destination

    #Set dynamic memory, min and max
    Write-Verbose "Setting dynamic memory min and max for VM $_"
    Set-VMMemory -VMName $_ -DynamicMemoryEnabled $True -MinimumBytes 512MB -MaximumBytes 800MB
    

    }