---
tags: 
aliases: 
date-created: 2025-04-19
dg-publish:
---
[[]]

### Workload Security
---
Trend Micro Cloud One™ – Workload Security is a comprehensive security solution designed to protect workloads across physical, virtual, cloud, and container environments. It offers a unified platform that combines multiple security capabilities into a single agent, simplifying management and enhancing protection.

Including:

- Anti-Malware
- Firewall
- Web Reputation
- Application Control -- restricts the execution of unauthorized applications
- Intrusion Prevention
- Integrity Monitoring
- Log Inspection
- Container Protection

#### Basic Workflow
---

1. **Add Your Cloud Account to Cloud One**  
    Navigate to the Cloud One console and add your cloud account (e.g., AWS, Azure, GCP). This integration allows Cloud One to discover and manage your cloud resources.
    
2. **Install the Agent on Your Instances**  
    Once your cloud account is connected, you can deploy the Trend Micro agent to your instances. This can be done manually or using deployment scripts provided by Cloud One.
    
3. **Activate the Agent**  
    After installation, activate the agent to start protecting your workloads.
    
4. **Assign Security Policies**  
    Apply appropriate security policies to your instances to define the level of protection and monitoring.

## 🔐 Core Components
---

1. **Workload Security Console**  
    A centralized, web-based management interface for configuring security policies and deploying protection to workloads.
    
2. **Deep Security Agent**  
    A lightweight agent deployed directly on servers or virtual machines, providing real-time protection through various modules.
    
3. **Relay Module**  
    Facilitates efficient distribution of software and security updates across the network.
    
4. **Notifier**  
    A system tray application that communicates security status and events to the local machine.

### Signing up for an Cloud one Account.
---
A free 30 days trial: [https://cloudone.trendmicro.com](https://cloudone.trendmicro.com/)

## Adding and Protecting AWS workloads
---
_Amazon EC2_ -- In short a scalable virtual machine that can act as a server with any OS and applications running.

Ideally add accounts via Cloud One's computer > **Add AWS Account**.

https://cdn5.dcbstatic.com/files/t/r/trendmicroeducation_docebosaas_com/1745035200/2-xzsGfq_m6whNxwBIwrbg/tincan/13040_1606939492_p1eoigod81gba1c2eqif931mq14_zip/course/en/assets/5f68d60f3f2b173e12d53e11/video.mp4

## Installing Agents
---
The Agent is the software component deployed directly on a server to provide protection through the protection modules.

Agents are supported on a variety of platforms and operating systems and enforce the policy settings configured in the Workload Security Web console. The Agents return event details to Workload Security on a regular basis, allowing administrators to view security events occurring on the protected servers.
### Installing Agent on a Server
---
To apply protection to servers, an Agent is installed on the computer, the device is added to the **Computers** list in the Workload Security Web console and the Agent is activated. Activation is required for Agents to accept commands from Workload Security, and report its status.

  
Behind the scenes, activation performs the following operations:

1. The SSL certificate and the URL of Workload Security are transferred to the Agent.
2. A Global Unique Identifier (GUID) is generated and returned to the Agent.
3. Information about the Agent’s NICs is retrieved.
4. The Registered Agent information is stored in the database.

The ideal method is using **deployment scripts** [here](https://cloudone.trendmicro.com/docs/workload-security/computers-add-deployment-scripts/):

![[Cloud One.png|450]]

- The **Platform** that will be hosting the Agent (Windows, Linux, or Unix)
- The **Policy** to apply to servers activated using this script. The policy dictates what protection is applied to the computer.
- The **Group** to which the server will belong. Groups help organize the **Computers**
- The **Relay Group** to which the server will belong. Typically, Relays are managed by Trend Micro as part of the service, but you could specify other Relays you might have manually installed in your organization.
- The **Proxy** that is to be used to contact Workload Security or the Relays, if required.
- Then a code at the bottom pane will be provided.

It is also worth **noting** that the deployment script can be added in **Amazon Machine Image** template by adding the script in the **Advanced Detail** section.

## Managing Agents - Workload security
---
This module will cover how to manage, reset, and group Workload Security agents. The Agent is the software component deployed directly on a server to provide protection through the protection modules.

### Resetting the Agent
---
This will effectively remote previously deployed security policy and implemented within the agent

```Manually-at-Server
dsa_control -r
```

At the **web console** > **computers** > choose a server then **right click** and select deactivate.

### Grouping Computers
---
To simplify computer administration in a broad implementation, you can create groups organized according to company requirements. Administrators can create and sort groups based on any organizational structure and then add computers to those groups. Computers can be moved into a different group at any time through the **Computer Details** window. Grouping computers is done for organization purposes only; changing the group does not affect policy.

1. Create groups from the **Add** menu in the **Computers** list. Click **Create Groups** and type a name, description, and location in the structure for the group.
2. Add existing servers to the group through **Details**. Double-click a computer to open its **Details** and select a group from the list
	- You can also add a server to a group by indicating your choice from the Computer Group list in the deployment script window.
### Cleaning up Inactive Agents
---
In some deployments, Workload Security can accumulate large numbers of computers that no longer exist.

To address this issue, an **Inactive Agent Cleanup** system setting under **Administrations > System Settings > Agents** deletes Agents that have not communicated with Workload Security in a configurable period.

![[Cloud One-1.png|450]]

**Inactive Agent Cleanup** will check hourly for computers that have been offline and inactive for a specified period of time (from 2 weeks to 12 months) and remove them from the **Computers** list

#### Enabling Agent Self - Protection
---
Agent self-protection prevents local users from tampering with the agent. When enabled, if a user tries to tamper with the agent, a message such as "**Removal or modification of this application is prohibited by its security settings"** will be displayed.

- To update or uninstall the Agent or Relay or create a diagnostic package for support, you must temporarily disable agent self-protection.
- Anti-Malware protection must be **On** to prevent users from stopping the agent and from modifying agent-related files and Windows registry entries. It is not required, however, to prevent uninstalling the agent
- Available only in Windows.
#### Web console
---
To configure self-protection through the Policy Editor, click **Settings > General**. In the **Agent Self-Protection** section, for "**Prevent local end-users from uninstalling, stopping, or otherwise modifying the Agent"**, select **Yes**. For "**Local override requires a password"**, select **Yes** and type an authentication password.

![[Cloud One-2.png|450]]

The authentication password is highly recommended because it prevents unauthorized use of the _dsa_control_ command-line utility

#### Command Line 
---
The command line has one limitation: you cannot specify an authentication password. You will need to use the Workload Security Web console for that

Enable:

```
dsa_control --selfprotect=1
```

Disable:

```
dsa_control --selfprotect=0 -p <password>
```

### Adding Additional Relays
---
Workload Security provides Relays. To use them, verify that your computers can connect to the listening port number on Workload Security. However, if you need more Relays in other locations, you can use some Agents as Relays. Before you enable a computer to act as a Relay, check that the computer meets the requirements.

In **Trend Micro Cloud One™ – Workload Security**, **relays** are agents configured to redistribute software and security updates to other agents, enhancing performance and scalability. They act as distribution points, reducing external bandwidth usage and providing redundancy for update delivery

1. In the Workload Security Web console, click **Administration > Updates > Relay Management**. Create a new Relay group.
2. Click **Add Relay** and from the **Available Agents** list, select a computer and click **Enable Relay and Add to Group**.
3. The computer is added to the Relay group and displays a Relay icon. Workload Security tells the new Relay to get security updates.

## Agent Policy, Distrubition and Overrides
---
The deployment of protection policies to the Workload Security agents. The Agent is the software component deployed directly on a server to provide protection through the protection modules.

![[Cloud One-4.png|450]]

Policies are collections of rules and configuration settings saved for easier assignment to multiple servers

![[Cloud One-3.png|450]]

A policy can include the following items:
- **Protection Module state**: The policy can enable or disable Protection Modules on servers using this policy
- **Settings**: Individual settings for the Protection Modules can also be set in the policy
- **Rules**: Some Protection Modules use rules to detect specific conditions and define actions when detecting the condition. The policy can automatically assign the rules to servers.

![[Cloud One-5.png]]

- Policy hierarchy: can apply base policy to apply all child policies and (if applicable) sub-policies, **or** use only child policy (will apply sub-policies) and so on.

**To assign the policy**, select a server in the **Computers** list, and double-click to open its **Details**. Select the required policy and click **Save**. The configured policy deploys to the selected server, which in turn applies the protection settings. The Agent enforces the security settings defined in the policy. Administrators can view which servers use these policies through the **Policy** column in the **Computers** list.
### Inheritance
---
- **Inheritance**: By default, child policies inherit settings from their parent policies. For example, if the Base policy has a setting enabled, the child policy will inherit that setting unless specified otherwise.​
- **Overrides**: At the child policy level, you can modify inherited settings. These modifications will apply to all systems assigned to that child policy, allowing for customized configurations without affecting the parent policy or other child policies.
### Creating Policies
---
To create a new policy, click the **Policies** menu and, click **New > New Policy**. Select an existing policy from the list as the parent. The policy inherits the elements from the parent and the new policy is created as a child of the selection.


Another method commonly used is to duplicate an existing policy, and rename this duplicate to create a new policy. Modify the duplicate with the new required elements.

## WLS - Protecting Servers from Malware
---
The Anti-Malware module provides Agent computers with real-time, on-demand, and scheduled protection against file-based threats, including malware, viruses, Trojans, ransomware, and spyware. Workload Security also provides security settings that you can apply to Windows servers that are protected by an Agent to enhance your malware and ransomware detection and clean rate. These settings go beyond malware pattern matching and identify suspicious files that could potentially contain emerging malware that has not yet been added to the anti-malware patterns.

- Compare local hard drive against threat database.
- Checks for certain characteristics, such as compression and known exploit code.

#### Timing
---
- **Real-Time Scanning** is a persistent and ongoing scan, designed to detect file infection and/or malware creation attempts as they happen. Each time a file is received, opened, downloaded, copied, or modified, the Agent scans the file for security risks. If no security risk is detected, the file remains in its location and users can proceed to access the file.
- **Manual Scan** -- Full or quick scan.
- **Scheduled Scan** runs automatically on the appointed date and time to automate routine scans and improve scan management efficiency. A Timeout setting defines an allowable scan duration. If this preset limit is reached, the scan is suspended.
### Defining actions and parameters for scanning
---
A Malware Scan Configuration defines the settings and options such as _what files to examine_, _when the scan is performed_, _exclusions_, _what actions to carry out if malware is detected_, and more.

Default Malware Scan Configurations are displayed in the Workload Security Web console from the Common Objects list. These can be used as defined or edited to create new configurations.

![[Cloud One-6.png]]

New Malware Scan Configuration that is created is added to the Common Objects list allowing these configuration settings to be easily applied within policies or on computers

![[Cloud One-7.png|450]]

Then apply to a policy:

![[Cloud One-8.png]]
## Web Protection
---
The Web Reputation module protects servers against web threats by blocking access to malicious URLs.

Agents access databases from the Trend Micro Smart Protection Network to check the reputation of Web sites that are being accessed.

- High -  credibility score of 81 or higher are allowed.
- Medium - with a score of 66 or higher are allowed.
- Low - 0 and 50.
- Untested - block pages that has not been tested by Trend Micro.

Allow or block regardless of rating at Web Reputation's Exceptions tab:

![[Cloud One-9.png|450]]

In the event tab, the user can add a match to allow list:

![[Cloud One-10.png|450]]

## Filtering Traffic with Firewall Module
---
The Firewall module enables bidirectional stateful inspection of incoming and outgoing traffic, ensuring that packets originating from unauthorized sources do not reach applications on the Agent-protected host.

Firewall rules are created as **Common Objects** and can be reused in different policies as needed.

- The **Bypass** action allows traffic to bypass both firewall and intrusion prevention analysis. Only the port, direction, and protocol can be set with this action. The bypass action is designed for media-intensive protocols where filtering by the Firewall or Intrusion Prevention modules is neither required nor desired.
- **Force Allow** rules are designed to permit specific traffic that might otherwise be blocked by Deny or Allow rules.
- The **Log Only** action will only generate an event if the packet in question is not subsequently stopped by either a rule using a Deny action or a rule using an Allow action that excludes it. If the packet is stopped by one of those two actions, those rules will generate the event and not the rule using Log Only.
### Network Engine
---
#### 🔄 Tap Mode
---
- **Behavior**: Traffic is monitored without modification.
- **Impact**: No packets are dropped; issues are logged for review.
- **Use Case**: Ideal for testing firewall rules without affecting network traffic.​[Deep Security Help Center+2Trend Micro Success Center+2Deep Security Help Center+2](https://success.trendmicro.com/en-US/solution/KA-0016443?utm_source=chatgpt.com)
    
#### 🔀 Inline Mode
---
- **Behavior**: Traffic passes through the network engine, where rules are applied.
- **Impact**: Packets may be allowed or blocked based on rule configurations.
- **Use Case**: Active enforcement of security policies.

### Creating a Firewall Rule
---
Trend Micro provides default list of firewall rule:

![[Cloud One-11.png|450]]
## Firewall Types
---
Firewall policies use one of two design strategies. Either they permit any service unless it expressly denied or they deny all services unless expressly allowed

- **Restrictive** -- Deny all by default and Allow only explicit traffic, If the primary goal of your planned firewall is to block unauthorized access, the emphasis needs to be on restricting rather than enabling connectivity.
- **Permissive** firewall -- permits all traffic by default and only blocks traffic believed to be malicious based on rules, signatures, or other information. A permissive firewall is easy to implement but it provides minimal security and requires complex rules.

> In Workload Security, as soon as you assign a single Allow rule, the firewall will operate in restrictive mode. In general, restrictive policies are preferred and permissive policies should be avoided.


Use **Block Traffic** to set the number of minutes an IP address should be blocked when encountering a reconnaissance scan.


- **Computer OS Fingerprint Probe**: Agents will recognize and react to active TCP stack OS fingerprinting attempts
- **Network or Port Scan**: Agents will recognize and react to port scans
- **TCP Null Scan**: Agents will refuse packets with no flags set
- **TCP SYNFIN Scan**: Agents will refuse packets with only the SYN and FIN flags set.
- **TCP Xmas Scan**: Agents will refuse packets with only the FIN, URG, and PSH flags set or a value of 0xFF (every possible flag set).

![](https://cdn5.dcbstatic.com/files/t/r/trendmicroeducation_docebosaas_com/1745067600/3QyLI5WKaBB-D3sCBZ26uQ/tincan/13040_1606939886_p1eoih8nt44qv1s2r16mq7bt1rsgb5_zip/course/en/assets/5f9309a17d3b333188936129/small.png)

For each type of attack, the Agent and can be instructed to send the information to Workload Security where an Alert will be triggered by enabling **Notify DSM Immediately**.
### 🔐 How Stateful Firewall Works
---
The **stateful firewall** mechanism ensures secure and efficient traffic management by analyzing each packet in the context of its connection state and protocol-specific behaviors.​

1. **Rule Evaluation**: The packet must first pass the static firewall rule conditions to be considered for stateful inspection.​
2. **Connection Tracking**: The system checks if the packet belongs to an existing connection by examining its headers and comparing them against a state table.​
3. **Protocol Validation**: For TCP traffic, the system verifies the correctness of the TCP header, including sequence numbers and flags, to ensure the packet is part of a legitimate session.