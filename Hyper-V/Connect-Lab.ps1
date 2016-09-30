$credential = Get-Credential

$labaddress = "wmt-apps"
#$labaddress = "192.168.0.100"

#name of technician machine
$computername = "wmt-lwd-lpt33"
$provider = "FileSystem"

#Lab-host-01 is workgroup server, needs IP to connect.
Enter-PSSession -ComputerName $labaddress #-Credential $credential

Invoke-Command -ScriptBlock { param($computername) New-PSDrive -PSProvider FileSystem -Name "S" -Root "\\$computername\Powershell" -Persist -Credential "$computername\mike" -Verbose; Get-ChildItem S: } -ComputerName $labaddress -ArgumentList $computername