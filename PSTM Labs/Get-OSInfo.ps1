Param(
    [string]$computername = 'localhost'
    )
Get-CimInstance -ClassName win32_operatingsystem -computername $computername