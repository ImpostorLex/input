---
date-created: 2025-04-18
dg-publish:
---
[[]]
### Introduction
---

- Product: Deep Discovery Inspector (DDI) -- is a network security solution designed to detect and respond to advanced cyber threats—such as zero-day exploits, ransomware, and targeted attacks—**that often evade traditional defenses like firewalls, IDS/IPS, and antivirus software**. It achieves this by providing comprehensive visibility into network traffic, including lateral (east-west) movement, and employing _specialized detection techniques_ like custom sandboxing and behavioral analysis
- Monitor both **network and file level.**
- Not an IDS/IPS and honeypot.
- Supports 100+ protocols.


- Stands for **Internet Content Adaptation Protocol**. It's a protocol used to integrate Trend Micro's security appliances, such as Deep Discovery Analyzer (DDA) or InterScan Web Security Virtual Appliance (IWSVA), with other network components like proxy servers or cache servers.
	- Basically used to scan the contents of HTTP whether that is POST or GET request.
- _Prevalance_ -- refers to the **frequency** or **commonness** of a specific file, URL, or threat across the internet. This metric helps determine whether a file is widely used or potentially malicious based on its distribution and occurrence.


![[Network Defense Deep Discovery.png]]

Back:

![[Network Defense Deep Discovery-1.png]]
#### Architecture
---

![[Network Defense Deep Discovery-2.png]]
##### Deployment
---

![[Network Defense Deep Discovery-7.png]]


### Deep Discovery Analyzer
---
In summary, while both DDA and DDI are part of Trend Micro's Deep Discovery suite, DDA specializes in providing detailed analysis of files and URLs in custom sandbox environments, whereas DDI focuses on monitoring and analyzing network traffic to detect advanced threats in real-time.

- On-premised device
##### Architecture
---

![[Network Defense Deep Discovery-3.png]]
##### Deployment
---

![[Network Defense Deep Discovery-8.png]]
### Deep Discovery Email Inspector
---
- Block/quarantine/strip malicious and suspicious content.
	- Including sending malicious content in sandbox.

#### Architecture
---
![[Network Defense Deep Discovery-4.png]]
##### Deployment
---

![[Network Defense Deep Discovery'.png]]

![[Network Defense Deep Discovery-9.png]]


### Deep Discovery Director
---
It is an on-premises management platform designed to centralize and streamline the administration of Trend Micro's Deep Discovery products.

- Threat Intel Sharing - TAXII, Yara, STIX, Sandboxing.
- Network Analytics - Uncover hidden threats and plots their infection history.
- Management - Software/components update, log aggregation, monitoring, configuration synchronization and third party integration.

![[Network Defense Deep Discovery-5.png]]

Boring ass course:

![[Network Defense Deep Discovery-6.png]]
#### Deployment
---

![[Network Defense Deep Discovery-10.png]]
###### Consolidate mode
---
![[Network Defense Deep Discovery-11.png]]
###### Distributed mode
---

![[Network Defense Deep Discovery-12.png|450]]
