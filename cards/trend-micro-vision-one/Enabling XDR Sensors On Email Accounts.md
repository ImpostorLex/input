### Enabling XDR Sensors On Email Accounts
---
It supports for many cloud-based applications including Office 365, Exchange Online, and more: Trend Micro Cloud App Security protects email systems from phishing and advanced malware through the use of a virtual sandbox, document-exploit detection, and web reputation. (Disabled by default.)

![[Vision One for Administrators-1.png|350]]

- For email services, scanning occurs when an email message arrives at a protected mailbox.
- For cloud storage applications, scanning occurs when a user uploads, creates, synchronizes, or modifies a file.
- For Salesforce, scanning occurs when a user updates an object record.
- For Teams Chat, scanning occurs when a user sends a private Chat message.

Administrators must create a service account for each protected cloud service and grant Cloud App Security access to the service data to perform its threat scanning operations.
#### Configuring Trend Micro Cloud App Security to work with Exchange Online
---
Provision a **service account** for Exchange Online to allow Cloud App Security to run advanced threat protection and data loss prevention scanning on email messages in protected Office 365 mailboxes.

1. Login to [Trend Micro Cloud App Security](https://admin.tmcas.trendmicro.com/) and then click **Open console** for **Trend Micro Cloud App Security**.
2. In the console, hover the mouse over the **Exchange Online** service and click **Provision**. (the label and checkbox).
3. A window displaying the steps for provisioning the Exchange Online account is displayed.
	 - In Step 1, click the link and log into a Windows account with administrative permissions.
	- In Step 2, click the link to provide permissions to access the mailboxes.
	- In Step 3, select which users and groups to synchronize from the list, and click **Done**.
4. An Exchange Online Protection Policy must also be in place. Click **Advanced Threat Protection** and click **Add** > **Add Exchange Policy.**
5. On the **Advanced Threat Protection Policy** page that is displayed, toggle the switch to **Enable Real-time scanning**. Provide a name for the policy, select your targets, and click **Save**.
6. The Automation and Integration APIs for Threat Investigation must be enabled in Cloud App Security.
	- Click **Administration** > **Automation and Integration APIs.**
	- Click **Add** > **Default Organization** > **For Trend Micro Service / Product**.
	- Select **Managed Detection and Response Service**.
7. Some APIs require authorization to provide Cloud App Security with sufficient service data. In the **Add Authentication Token** window, provide a name for the token and click **Create Token**. Click **OK** to authorize the operation.

#### Provisioning Trend Micro Cloud App Security for Gmail
---
Allow Cloud App Security to run advanced threat protection and data loss prevention scanning on email messages in protected Gmail mailboxes:


1. Click **Open console** for **Trend Micro Cloud App Security**.
2. In the console, hover the mouse over the **Gmail** service and click **Provision**.
3. A window pops-up ![[Vision One for Administrators-2.png]]
	- Click the link to open Google Workspace Marketplace. The Trend Micro Cloud App Security application screen in the Google Workspace Marketplace is displayed.
	- Click the link and in the new window that appears, click your Google Super Admin account. On the authorization screen

### Connecting Cloud App Security to Trend Micro Vision One
---
To enable sweeping and checking email telemetry during threat investigation, Cloud App Security needs to be connected to Trend Micro Vision One

1. Click the link: [portal.xdr.trendmicro.com](https://portal.xdr.trendmicro.com/)
2. Click **Open console** for **Trend Micro Vision One**.
3. Expand **Point Product Connection** and click the **Product Connector app**.
4. Select one or both: ![[Vision One for Administrators-3.png]]
XDR sensors must enabled for the protected email accounts which are added through the **Email Account Inventory** app.

5. Click the **Email Account Inventory** App. Any email accounts with the XDR sensor enabled are displayed in the list. 
6. Click **Manage Mailbox Sensors**.
7. Type and user or group names in the **Search field** and move them to **Selected Accounts:** ![[Vision One for Administrators-4.png|350]]
8. The email accounts with a sensor enabled are now displayed in the **Email Account Inventory** app.
![[Vision One for Administrators-5.png|450]]
