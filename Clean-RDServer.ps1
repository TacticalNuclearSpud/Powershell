<#
.SYNOPSIS

Clean-RSServer removes leftover profiles from Remote Desktop Services Farm Server. 
.DESCRIPTION
Clean-RDServer pulls a list of leftover roaming profiles from the named server and removes them, with the exception of my own admin account
.PARAMETER computername
The name of the Remote Desktop Services Server to clean.
.EXAMPLE
Clean-RDServer -ComputerName WMT-RDS01
#>
[CmdletBinding()]

param (
    [Parameter(Mandatory=$True)]
    [string]$computername
)

$currentuser = [Environment]::UserName

#list user profiles excluding service accounts any local accounts and my own admin account.
Get-WmiObject -Class win32_userprofile -ComputerName $computername | `
    Where-Object -Filter {$_.RoamingConfigured -eq $true} | `
        Where-Object -Filter {$_.LocalPath -notlike "*$currentuser*"} | `

        #loop through profiles, remove profile and delete folder.
        ForEach-Object {
            
            $profileSID = New-Object System.Security.Principal.SecurityIdentifier($_.SID)
            $currentProfile = ($profileSID.Translate([System.Security.Principal.NTAccount])).Value
            write-host $currentProfile
            
            #delete profile
            #$_.Delete()

        }
        
      