---
tags: 
date-created: 2025-01-04
dg-publish: true
---
[[Phishing]]
### Methodolgy
---
- **Initial Triage**
	- **Quickly assess and prioritize**: taking notes of the obvious.
	- Potential phishing against the CEO versus a low-level employee so which first? the CEO of course.
- [[Headers to look out for|Header and Sender Examination]] 
	- Analyzing metadata such as: IP address, [[Email#Introduction|MTAs]], and more.
	- Goal is to identify true origin and check authenticty.
- [[Content Examination]]
	- Social Engineering flags
	- Double check `content-transfer-encoding` header
- [[URL Analysis|Web and URL Examination]]
	- VirusTotal, CiscoTalos
	- urlscan.io, hybridanalysis
	- urlhaus for malware analysis link
- [[Attachment Examination]]
	- hybridanalysis, VirusTotal's hash
	- **Keep in mind the things you upload - check company policy first.**
- **Context Examination**
	- Identify patterns: recent or current incidents.
	- Is this a recurring sender email address?
- **Defense Measures**
	- [[Reactive Phishing Defense]] and [[Proactive Phishing Defense]] action.
	- Communicate with users and stakeholders.
- **Documentation and Reporting**
	- All of the steps taken literally.
	- [[Challenges TimeKeeping#Phishing|Challenges]]

## Questions
---
> What about Message-ID that make uses of proton server to send but has a custom domain? such as alex@proexample[.]com




