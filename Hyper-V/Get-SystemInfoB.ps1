function Get-SystemInfoB {

    [CmdletBinding()]
    param(
        [string[]]$ComputerName,
        [string]$ErrorLog = "C:\Errors.txt"
    )
    BEGIN {
    }
    PROCESS {
        foreach ($computer in $computername){
            $vols = Get-WmiObject -Class Win32_Volume -ComputerName $computer -Filter "DriveType=3"
            Foreach ($vol in $vols){
                $size="{0:N2}" -f ($vol.capacity/1GB)
                $freespace="{0:N2}" -f ($vol.freespace/1GB)

                $props = @{'FreeSpace' = $freespace;
                            'Drive' = $vol.name;
                            'ComputerName' = $vol.SystemName;
                            'Size' = $size
                           }
                New-Object -TypeName psobject -Property $props
            }
            Remove-Variable -Name $vols
        }
       }
    END {
       
    }
}
Get-SystemInfoB -ComputerName localhost
