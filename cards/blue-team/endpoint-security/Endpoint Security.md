---
tags: 
date-created: 
dg-publish: true
---
[[blue-team]]

- **Endpoint** are hardware or devices that is connected to our network.
	- Point of entry for security threats.
	- Servers - host business resources such as email, web, file servers and more.
- Heavily relies on **baseline** to be effective.
- **No baseline**? DEPLOY A clean image of an endpoint and compare.
## Endpoint Security Monitoring
---
- [[Windows Process Analysis|Process Execution]] | [[Linux Process Analysis]]
	- Monitoring running processes.
	- Executable files, PIDs, command-line arguments.
	- Parent-child process hierarchy.
- **File System Changes**
	- Create, modification, deletion
	- File Integrity Monitoring
- [[Windows Network Analysis|Network Connections]]
	- Traffic and connection from the endpoint.
	- Associated processes and executables
- [[Windows Registry|Registry Modifications]]
	- Monitor registry keys and values.
	- Detect backdoor, persistence, and detection evasion.
- [[Windows Event Logs]]
## Security Controls
---
- **Antivirus**
	- Scans files and activities based on patterns and signatures
- **Endpoint Detection and Response**
	- Real-time monitoring and response - agent based deployment
	- Monitor process, files, registry, and network activity.
- **Extended Detection and Response (XDR)**
	- Integration of multiple security controls and telemetry.
	- Runbooks and automated response.
- **Data Loss Prevention (DLP)**
	- Protect sensitive data at transit, rest, and processing.
- **User and Entity Behavior Analytics (UBA)**
	- Monitoring user behavior patterns includes historic and contextual baseline through the use of Machine Learning.
- **Host-based Firewall**


