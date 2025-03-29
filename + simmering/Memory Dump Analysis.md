[[]]

- Memory Forensics’ basic concepts.  
	- Is a subset of computer forensics that analyzes volatile memory usually on Random Access Memory (RAM) this allows to view the running processes or application running and shows detailed execution flow on a system.
	- Should be the initial task to perform during an incident.

- How to access and set up the environment.
	- Tools for creating an image or snapshot of the system depends on the Operating System:
		- **Windows:** FTK imager, WinPmem
		- **Linux:** LIME
		- **macOS**: osxpmem
	- Then we can use Volatility 3 to analyze the memory dump `.mem`
- Gathering information from the compromised target.
	- Depending on the target:
		- `vol windows or linux --help`
- Output for the windows command:
![[Memory Dump Analysis.png]]

- Search for suspicious activity using the information obtained.
	- `vol -f memdump.mem windows.info` - in this way we can identify the architecture, number of processor, and version that helps correlates with other information such as this version of Windows is vulnerable to X exploit.
	- `windows.netstat` - to look for any network connection made established or listening.
	- `windows.pstree` - one of the ways of hiding malicious process is using common names with different letters such as 'critical_updat' without an 'e'.
		- Take note of the timestamp, PID, PPID, and Memory offset.
	- Here are common process names:

![[Memory Dump Analysis-1.png|200]]

- Extracting and analysing data from memory.
	- `vol -f memdump.mem windows.filescan > filescan.out` recommended to redirect the output to a file and use grep.
	- `windows.mftscan.MFTScan > mftscan_out` get time when file accessed or modified.
	- `-o . windows.memmap --dump --pid 1612` to dump a process usually recommened to a file or executable which in this case the specified process id is the executable in question.
		- A `.dmp` file will be created
	- We can use the below code to get 10 lines from above and below to see some interesting lines:

```bash
strings pid.1612.dmp |grep -B 10 -A 10 "http://key.critical-update.com/encKEY.txt"
```

- Command is great to view HTTP request headers 

