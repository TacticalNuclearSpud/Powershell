$labaddress = "192.168.0.100"
$credential = Get-Credential

Enter-PSSession -ComputerName $labaddress -Credential $credential