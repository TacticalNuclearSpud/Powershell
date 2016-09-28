#########################################################
#
# Name: Split-TextMessages-v1.0.ps1
# Author: Mike Brankin
# Date: 23/08/2016
# Powershell Script to go through a text message dump
# file and create a file containing all messages to/from
# a particular number
#
#########################################################

#declare variable for arraylist
[System.Collections.ArrayList]$message = @()

#path to message dump file
$messages = Get-Content -Path C:\users\mike.brankin\Desktop\sms.txt

#loop over the array created by the Get-Content command
$messages | foreach {
    if ($_.Contains("END:VMSG"))
        {
            #add last line of message to message string
            $messagetext = $messagetext + $_ + " `r`n"

            #add string containing whole message to arraylist
            $message.Add($messagetext)

            #clear message string for next pass
            $messagetext = $null   
        }
    else
        {
            #build string containing single message
            $messagetext = $messagetext + $_ + " `r`n"
        }

       }

#loop over arraylist looking for particular number
$message | foreach {
    if ($_.Contains("+447773631855"))
    {
        #write found messages to file
        $_ | Out-File C:\users\mike.brankin\Desktop\messages.txt -Append
    }
    else
    {
        #do nothing
    }
}


