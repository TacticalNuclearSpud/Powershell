function Get-SystemInfo {

    [CmdletBinding()]
    param(
        [string[]]$ComputerName,
        [string]$ErrorLog
    )
    BEGIN {
    }
    PROCESS {
       foreach ($computer in $ComputerName) {
            $os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $Computer
            $comp = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computer
            $bios = Get-WmiObject -Class Win32_BIOS -ComputerName $computer
            $props = @{'ComputerName'=$computer;
                        'OSVersion'=$os.version;
                        'SPVersion'=$os.servicepackmajorversion;
                        'BIOSSerial'=$bios.serialnumber;
                        'Model'=$comp.model}
            $obj = New-Object -TypeName psobject -Property $props
            Write-Output $obj
       }
    }
    END {}
}
Get-SystemInfo -ErrorLog x.txt -ComputerName localhost,localhost