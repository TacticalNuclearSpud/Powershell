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

    #Lab-host-01 is workgroup server, needs IP to connect.
    $labaddress = "192.168.0.100"

    #name of technician machine
    $computername = "wmt-lwd-lpt33"

    $session = New-PSSession -ComputerName $labaddress -Credential $credential
 
    Invoke-Command -Session $session -ScriptBlock { param($computername) New-PSDrive -PSProvider FileSystem -Name "S" -Root "\\$computername\Powershell" -Persist -Credential "$computername\mike"} -ArgumentList $computername

    Enter-PSSession -Session $session
}