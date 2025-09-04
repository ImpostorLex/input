
```C
$RDPAuths = Get-WinEvent -LogName 'Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational' -FilterXPath '<QueryList><Query Id="0"><Select>*[System[EventID=1149]]</Select></Query></QueryList>'

$xml = $RDPAuths | ForEach-Object { [xml]$_.ToXml() }

$EventData = foreach ($event in $xml) {
    New-Object PSObject -Property @{
        TimeCreated = Get-Date $event.Event.System.TimeCreated.SystemTime -Format 'yyyy-MM-dd HH:mm:ss'
        User        = $event.Event.UserData.EventXML.Param1
        Domain      = $event.Event.UserData.EventXML.Param2
        Client      = $event.Event.UserData.EventXML.Param3
    }
}

# View as table
$EventData | Format-Table -AutoSize

# Optional: Export to CSV
$EventData | Export-Csv "$env:USERPROFILE\Desktop\RDPAuths.csv" -NoTypeInformation

```

Answer: > 2025-06-30 16:33:18

Why? based on the instruction

"While Emily worked on the issue from a local admin account, the threat actor continued the attack. With the entry point secured and Emily's domain credentials stolen".

Task 2:

Task scheduler - > Retrieve Hash -> VirusTotal.

Task 3:

Answer found on VirusTotal -> Community.

Task 4:

"Emily created a periodic system checker automation." based on this hint - there should be an output stored somewhere - (HINT at documents) then decode.

Task 5:

Locate the binary from the previous question and then execute the same command then transfer to kali linux then decode.

Transfer via:

```Kali
sudo service ssh start
```

Then Kali

```C
scp C:\Users\emily.ross\Documents\text.txt.dmp kaliuser@10.23.145.87:/home/kali/Desktop
```

Once transferred:

```C
pypykatz lsa minidump test.txt.dmp
```

Nothing useful but looking back at the powershell encoded b64 dumps:

command start time is: 2025-06-30 18:28:52 (last command) therefore we can assume the lateral movement is later

2025-06-30 18:28:30


---

Task 6:

Use autospy.

```C
Get-WinEvent -FilterHashtable @{LogName='Security'; ID=4624} | ForEach-Object {
    $ip = ($_.Properties[18].Value) # IP Address
    $user = $_.Properties[5].Value  # TargetUserName
    $time = $_.TimeCreated          # Timestamp
    $logonType = $_.Properties[8].Value

    if ($logonType -eq 10) { # Only RDP logins (Type 10)
        [PSCustomObject]@{
            TimeStamp = $time.ToString("yyyy-MM-dd HH:mm:ss")
            User      = $user
            IPAddress = $ip
        }
    }
} | Sort-Object TimeStamp | Format-Table -AutoSize

```