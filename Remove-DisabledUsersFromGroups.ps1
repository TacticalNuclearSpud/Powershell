#########################################################
#
# Name: Remove-DisabledUsersFromGroups.ps1
# Author: Mike Brankin
# Date: 30/08/2016
# 
# Script that loops over distribution and security
# groups, removing all users who's accounts are disabled
#
# Script must be run using DOMAIN ADMIN credentials
#########################################################

#This line is needed if not running through RSAT
Import-Module ActiveDirectory

#Organisational Unit that contains the groups
$searchOU = "OU=Groups,DC=wmtracey,DC=local"

#Creates a list of all groups within the $searchOU.
#Line below can be tweaked to find just distribution groups, just security groups or both.
$groups = Get-ADGroup -Filter 'GroupCategory -eq "Distribution" -or GroupCategory -eq "Security"' -SearchBase $searchOU

#Loop through list of groups
$groups | ForEach-Object{ $group = $_ 
    
    #Lists members of each group and checks if the accounts are disabled.
    Get-ADGroupMember -Identity $group -Recursive | ForEach-Object { Get-ADUser -Identity $_.distinguishedName -Properties Enabled | Where-Object {$_.Enabled -eq $false}} | 
    
    #Removes disabled accounts from groups.
    ForEach-Object { $user = $_
        
        $username = $user.Name
        $groupname = $group.Name

        #Line that actually removes the accounts from the groups. Can be commented out to test script.
        Remove-ADGroupMember -Identity $group -Member $user -Confirm:$false
        
        Write-Host "Disabled user $username removed from $groupname group." -ForegroundColor Yellow

        }
}

