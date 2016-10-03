$computername = "wmt-lwd-lpt33"

New-PSDrive S -PSProvider FileSystem -Root "\\$computername\Powershell" -Persist -Credential "$computername\mike"
