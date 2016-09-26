Write-host "Mike's Password Reset Script"
$username = Read-Host "Enter Username"

$password = Read-Host -AsSecureString "Provide New Password"

Set-ADAccountPassword -Identity $username -Reset -NewPassword $password
