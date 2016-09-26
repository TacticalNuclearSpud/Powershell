workflow paralleltest {
    parallel {
        Get-CimInstance -ClassName Win32_OperatingSystem
        get-process -Name powershell*
        Get-CimInstance -ClassName Win32_OperatingSyatem
        Get-Service -Name s*
        }
}