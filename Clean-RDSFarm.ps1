[CmdletBinding()]
param (
    [Parameter(Mandatory=$True)]
    [string]$computername
)
#list user profiles excluding service accounts any local accounts and my own admin account.
Get-WmiObject -Class win32_userprofile -ComputerName $computername | `
    Where-Object -Filter {$_.RoamingConfigured -eq $true} | `
        Where-Object -Filter {$_.LocalPath -notlike '*mike.brankin.admin*'} | `

        #loop through profiles, remove profile and delete folder.
        ForEach-Object {
            
            $profileSID = New-Object System.Security.Principal.SecurityIdentifier($_.SID)
            $currentProfile = ($profileSID.Translate([System.Security.Principal.NTAccount])).Value
            write-host $currentProfile
            
            #delete profile
            #$_.Delete()

        }
        
      