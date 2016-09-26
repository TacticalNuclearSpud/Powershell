$username = Read-Host -Prompt "Enter Username"
  
Get-ADUser -Identity $username | Move-ADObject -TargetPath "OU=Disabled Accounts,DC=wmtracey,DC=local" -PassThru | Disable-ADAccount