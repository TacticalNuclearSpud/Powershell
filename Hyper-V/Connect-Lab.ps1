<#
.SYNOPSIS
Connect-Lab connects to lab server
.DESCRIPTION
Connect-Lab connects to lab server and maps drive back to scripts folder on laptop
.EXAMPLE
Connect-Lab
#>

function Connect-Lab
{
    $credential = Get-Credential

    $labaddress = "192.168.0.100"

    #name of technician machine
    $computername = "wmt-lwd-lpt33"

    #Lab-host-01 is workgroup server, needs IP to connect.
    #Enter-PSSession -ComputerName $labaddress #-Credential $credential
    $session = New-PSSession -ComputerName $labaddress #-Credential $credential
 
    Invoke-Command -Session $session -ScriptBlock { param($computername) New-PSDrive -PSProvider FileSystem -Name "S" -Root "\\$computername\Powershell" -Persist -Credential "$computername\mike"} -ArgumentList $computername

    Enter-PSSession -Session $session
}