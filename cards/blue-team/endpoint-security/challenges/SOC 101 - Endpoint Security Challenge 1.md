---
tags: 
date-created: 2025-01-26
dg-publish: true
---
[[Endpoint Security MOC]]

Determining if there is a file share mounted:

```Powershell
net view \\127.0.0.1
```

Output:

![[SOC 101 - Endpoint Security Challenge 1.png]]
Viewing file location:

```
net share
```

Output:

![[SOC 101 - Endpoint Security Challenge 1-1.png]]
`net view` but navigating to the **exfill's directory** is empty and as for the other one: it is empty as well. (Note: exfill share is from our previous lesson not challenge)

Determinig suspicious process with:

```
netstat -anob
```

Output shows that challenge.exe is listening for incoming network connection:

![[SOC 101 - Endpoint Security Challenge 1-2.png]]
Then analyzing `.dll` files used by **challenge.exe**:

```
tasklist -m -fi "PID eq 2088"
```

Output:
![[SOC 101 - Endpoint Security Challenge 1-3.png]]
Determining parent's process ID and image name:
```Powershell
wmic process get name, parentprocessid, processid | find "6980"
```

Output shows that **challenge.exe** was executed using **cmd.exe**:
![[SOC 101 - Endpoint Security Challenge 1-4.png]]
No arguments were given:

```Powershell
wmic process get commandline, parentprocessid | find "6980"
```

Output:

![[SOC 101 - Endpoint Security Challenge 1-5.png]]
Then performing registry analysis, we can see that there is a new user created in our machine and it will run a binary once the user **tcm** logs on:

```Powershell
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"
```

Output:

![[SOC 101 - Endpoint Security Challenge 1-6.png]]
In scheduled task, there is a different named task name:

```bash
schtasks /query /fo TABLE 
```

Output:

![[SOC 101 - Endpoint Security Challenge 1-7.png]]
We can see that this tasks executes **beac0n.exe** to run daily at 3:30 AM:

```bash
schtasks /query /tn "ayttpnzc" /v /fo LIST
```

Output:

![[SOC 101 - Endpoint Security Challenge 1-8.png]]

(not found in initial investigation)
Using autoruns from sysinternal we found this suspicious service:

![[SOC 101 - Endpoint Security Challenge 1-9.png]]

```
sc qc WindowsActiveService
```

Output:

![[SOC 101 - Endpoint Security Challenge 1-10.png]]

