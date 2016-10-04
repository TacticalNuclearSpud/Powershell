function Get-SystemInfoA {

    [CmdletBinding()]
    param(
        [string[]]$computername,
        [string]$ErrorLog
    )
    BEGIN {
        Write-Host $computername
        Write-Host $ErrorLog
    }
    PROCESS {
       }
    END {
    }
}

Get-SystemInfoA -computername one,two,three -ErrorLog x.txt