---
tags:
  - f/web
---
[[flashcards]]

Who holds the actual mapping of domain name and IP address
?
Authorative nameserver

It points out to the appropriate Top Level Domain
?
Root nameservers

Holds the address of the authorative nameserver of the requested domain name or IP address
?
Top Level Domain nameservers.

Describe the three hand-way shake
?
1. Client iniates with a SYNCHRONIZE flag to server.
2. Server responds with a SYNCHRONIZE, ACKNOWLEDGE flag to client.
3. Client sends ACKNOWLEDGE flag. 
4. FIN flag is used to end connection, RST or Reset is used if the server does not want to communicate or can't process the request.

Transport Layer Security Handshake
?
1. It starts by CLIENT hello alongside the supported TLS version and encryption algorithm.
2. Both client and server agrees to what version of TLS and encryption algorithm to use.
3. The server provides its digital certificate to authenticate itself.
4. Client generates a pre-master key using the server's public key from digital certificate then sends it to the server.
5. Server decrypts the 'pre-master' with it's private key
6. Then server generates a session key from the decrypted pre-master key for further communication (Symmetric key).
