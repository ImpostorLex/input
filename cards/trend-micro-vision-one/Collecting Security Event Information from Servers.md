### Collecting Security Event Information from Servers
---
There are two ways:

#### Collecting security event information from Windows or Linux servers managed by Deep Security software in an on-premises installation requires these three tasks:
---
1. Connect Deep Security Software with Trend Micro Vision One.
2. Install Endpoint Basecamp servivces.
3. Enable the XDR sensor on the server.

#### Collecting security event information from Windows or Linux servers managed by Cloud One - Workload Security requires these three tasks:
---

1. Connect Cloud One .... to TM V1
2. Create a policy with Activity Monitoring enabled.
3. Assign the policy to a server protected by Cloud One Workload Security.

#### Creating Policies to Enable Activity Monitoring
---
1. Log into Cloud One - Workload Security as an administrator with appropriate privileges.
2. Click **Policies** and click either **New** to create a new policy, or double-click an existing policy to edit.
3. Click the **Activity Monitoring** protection module in the left-hand frame and set the state to **On** and save the policy.

#### Assigning the Policy to Servers
---
Once **Activity Monitoring** is enabled in a policy, any servers managed by Cloud One - Workload Security using that policy will send security event details to the Trend Micro Vision One data lake.

1. In Cloud One - Workload Security, click **Computers** to display the list of protected servers.
2. Double-click the servers you wish to assign the policy to and from the policy list, select a policy with **Activity Monitoring** enabled.

![[Vision One for Administrators-6.png|450]]

[Video](https://youtu.be/kKpCFdWW7xc)
#### Enabling Activity Monitoring Directly on Servers
---
In Cloud One - Workload Security, it is possible to enable the **Activity Monitoring** protection module directly on a computer, instead of through a policy. In this scenario, settings assigned directly to a server will override any assignments inherited through a policy.

1. In the **Computers** list, double click a computer on which you would like to enable **Activity Monitoring**.
2. Click the **Activity Monitoring** protection module in the left-hand pane and set the configuration to **On** and click **Save**.

