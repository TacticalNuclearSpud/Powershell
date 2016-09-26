#########################################################
#
# Name: RDSFarm-Cleanup-v1.0.ps1
# Author: Mike Brankin
# Date: 20/09/2016
# Powershell Script to attempt to automate removing
# roaming profiles from RDSFarm servers.
#
#########################################################

#enter server name
$server = Read-Host "Which RDSFarm Server do you want to clean?"

#list user profiles excluding service accounts any local accounts and my own admin account.
Get-WmiObject -Class win32_userprofile -ComputerName $server | `
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
        
      