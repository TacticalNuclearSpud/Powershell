function Get-SystemInfoC {

    [CmdletBinding()]
    param(
        [string[]]$ComputerName
    )
    BEGIN {
    }
    PROCESS {
        foreach ($computer in $ComputerName){
            $services = Get-WmiObject -class Win32_Service -ComputerName $computer | Where {$_.State -eq "Running"}
            foreach ($service in $services){
                $process = Get-WmiObject -class Win32_Process -ComputerName $computer | Where {$_.ProcessID -eq $service.ProcessID}

                $props = @{'ComputerName' = $computer;
                            'ThreadCount' = $process.threadcount;
                            'ProcessName' = $process.name;
                            'Name' = $service.name;
                            'VMSize' = $process.VM;
                            'PeakPageFile' = $process.peakpagefileusage;
                            'DisplayName' = $service.displayname
                           }
                New-Object -TypeName psobject -Property $props

                }
                Remove-Variable -name service

        }
       }
    END {
        
    }
}

Get-SystemInfoC -ComputerName localhost