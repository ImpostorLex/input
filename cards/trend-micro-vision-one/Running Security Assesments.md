## Running Security Assesments
---
## **Learning Objectives**
---
- Describe the use of the Security Assessment tool
- Describe the use of the Targeted Attack Detection tool
- Run security assessments on endpoint computers, servers and mailboxes
### Assessing an Endpoint Computer
---
The assessment tool scans endpoint computers or servers for threats associated with attack campaigns, file-based indicators, malicious files, and critical vulnerabilities.

1. In the Trend Micro Vision One console, expand **Assessment** in the left-hand pane and click the **Security Assessment** app.

2. In the **At-Risk Endpoint Assessment** frame, click **Start Assessment** and select the operating system on which the assessment will be run, either Windows or macOS.

![[Vision One for Administrators-12.png|450]]

3. Click **Download Assessment Tool** and save the file to a location accessible from the Windows or Mac endpoints you wish to assess.
4. After downloading the assessment tool, execute or run the file - then check the status back in the download section.
5. Click the **generate report preview** button and then the report should appear: ![[Vision One for Administrators-13.png]]
#### Assessing Cloud Mailbox
---
The assessment tool can also scan cloud mailboxes, including Office 365 and Google Workspace. This scan will examine messages sent and received in the last 15 to 30 days (including spam).

https://youtu.be/FaKb5M3iaxA - 365 Mailboxes

##### Google Workspace Mailboxes
---
1. Assessment > Select **At-Risk Cloud Mailbox Assessment** and select **Google Workspace** as the email provider.
2. **Install App** will be redirected to Google Workspace Marketplace.
3. Once redirected: **Install** (requires administrative privileges) then sign-in with administrator credentials.

### Targeted Attack Detection
---
It scans Smart Protection Network data regularly which allows Trend Micro Vision One to identify previously isolated detections that are likely to be part of complex attack chains

**Targeted Attack Detection** requires that certain security features be enabled in your products:

- Predictive Machine Learnin.
- Smart Feedback.
- Behavior Monitoring.