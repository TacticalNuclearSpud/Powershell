function Get-SystemInfoA {

    [CmdletBinding()]
    param(
        [string[]]$ComputerName,
        [string]$ErrorLog = "C:\Errors.txt"
    )
    BEGIN {
    }
    PROCESS {
        foreach ($computer in $ComputerName){
            $comp = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computer
            $bios = Get-WmiObject -class Win32_BIOS -ComputerName $computer
            $os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computer

            $apwdstatus = $comp.adminpasswordstatus
            switch ($apwdstatus){
                1 {$apwdstatus = "Disabled"}
                2 {$apwdstatus = "Enabled"}
                3 {$apwdstatus = "N/A"}
                4 {$apwdstatus = "Unknown"}
            }

            $props = @{ 'ComputerName' = $computer;
                        'Workgroup'= $comp.workgroup;
                        'AdminPasswordStatus' = $apwdstatus;
                        'Model' = $comp.model;
                        'Manufacturer' = $comp.manufacturer;
                        'SerialNumber' = $bios.SerialNumber;
                        'Version' = $os.Version;
                        'ServicePackMajorVersion' = $os.ServicePackMajorVersion
                        }
            $obj = New-Object -TypeName psobject -Property $props
        }
       }
    END {
        Write-Output $obj
    }
}

Get-SystemInfoA -computername localhost, localhost