function Get-OSInfo {

   Param(
    [string]$computername = 'localhost'
    )
    Get-CimInstance -ClassName win32_operatingsystem -computername $computername 

}

#ONLY FOR TESTING PURPOSES - REMOVE IN PRODUCTION ENVIRONMENT
Get-OSInfo -computername WMT-FS2