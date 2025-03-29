---
tags:
  - sunday
  - template
aliases: 
date-created: 
dg-publish:
---
[[cards/web/web]]
### Introduction 
---
Also known as the interface to the Internet, where 75% of cybercrime happens according to the research of Accunetix.
## Prerequisites

- [[How the web works]]

## Hyper Text Transfer Protocol (HTTP)

- A web request![[Web.png]]
- A web response ![[Web-1.png]]
### SQL Injection Detection
---
- Check all areas that comes from the users, it is also important to look at the header as well.
- SQL Keywords such as INSERT, SELECT, and WHERE.
- Special characters such as apostrophes ('), dashes (-). or parenthesis.
- Automated tools modifies the User-Agent header.
- Logs usually logs the responses, one work around is to look at the response size assuming the output results into the same page.

- [[Cross-Site Scripting]]
## Conclusion


