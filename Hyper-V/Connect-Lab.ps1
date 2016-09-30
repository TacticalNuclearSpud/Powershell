$credential = Get-Credential
$computername = "192.168.0.100"
Enter-PSSession -ComputerName $computername -Credential $credential

New-PSDrive -Name S -PSProvider FileSystem -Root "\\wmt-lwd-lpt33\Powershell" -Credential "wmt-lwd-lpt33\mike" -Persist