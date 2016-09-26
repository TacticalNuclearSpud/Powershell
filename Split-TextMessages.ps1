[System.Collections.ArrayList]$message = @()

$messages = Get-Content -Path C:\users\mike.brankin\Desktop\sms.txt

$messages | foreach {
    if ($_.Contains("END:VMSG"))
        {
            $messagetext = $messagetext + $_ + "`n"
            $message.Add($messagetext)
            $messagetext = $null   
        }
    else
        {
            $messagetext = $messagetext + $_ + "`n"
        }

       }

$message | foreach {
    if ($_.Contains("+447773631855"))
    {
        Write-Host $_
    }
    else
    {
        #do nothing
    }
}


