#Disables AD User, moves to "Disabled Users", Sets expiration in two weeks from termination
#Asks for username and stores in variable
Param (
[Parameter(Mandatory=$true)]
[string]$Username
)
Import-Module ActiveDirectory
Disable-ADAccount -Identity $Username #disables account
$SecPaswd = convertto-securestring "7&VPlMas%E" -asplaintext -force #convert password to secure string
Set-ADAccountPassword -Identity $Username -NewPassword $SecPaswd -Reset #reset password for specified user using password that was converted above
Unlock-ADAccount –Identity $Username
Get-ADUser $Username | Move-ADObject -TargetPath 'OU=Disabled Users, DC=reports, DC=aurico, DC=com' #move user to specified path
Set-ADAccountExpiration -Identity $Username -TimeSpan "14" #set expiration date for ad user in 14 days