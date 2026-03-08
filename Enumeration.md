Techniques shown are more over post - exploitation system and have carried out privilege escalation as some techniques requires administrator or root privileges some technique is still useful with unprivileged account.

- [[Lay of the Land]].
- Built-in tools for enumeration.

## Linux Enumeration
---

- [Linux Network Analysis]
- [Linux Process Analysis]

## Windows Enumeration
---

```C
system
```

Installed updates: see how quickly systems are being patched and updated.

```C
wmic qfe get Caption,Description
```

**Installed Services:**

```C
net start
```

Expect a long output.

**Installed Apps:**

```C
wmic product get name,version,vendor
```


```C
whoami /priv
```
Or
```C
whoami /groups
```

**View users:**

```C
net user
```

**View Available groups:**

```C
net group
```

If system is not Windows Domain Controller:

```C
net localgroup
```

**List all users that belongs to administrator:**

```C
net localgroup administrators
```

**See local/domain joined settings:**

```C
net accounts
```


```C
net accounts /domain
```

This command helps learn about password policy, such as minimum password length, maximum password age, and lockout duration.

**Networking:**

```C
ipconfig /all
```

```C
netstat -abno
```

- `-a` display listening and active connections.
- `-b` display binary involved in the connections.
- `-n` avoid resolving IP addresses and port number.
- `-o` display the PID.

Discover other systems on the same LAN that recently communication with your system.

```C
arp -a
```

## DNS, SMB, and SNMP

A copy of all the records that a DNS server is responsible for answering, you might discover hosts you did not know existed.

One way is DNS zone transfer is via:

```C
dig -t AXFR DOMAIN_NAME @DNS_SERVER
```

- `- AXFR` requesting a zone transfer.
- `@` precedes the DNS_SERVEr that you want to query regarding the records related to the specified `DOMAIN_NAME`.
- Zone transfer might be restricted.

**SMB:**

View shared folders:

```C
net share
```

**Simple Network Management Protocol (SNMP):**

It was designed to help collect information about different devices on the network. It lets you know about various network events, from a server with a faulty disk to a printer out of ink.

```C
/opt/snmpcheck/snmpcheck.rb 10.48.173.163 -c COMMUNITY_STRING
```