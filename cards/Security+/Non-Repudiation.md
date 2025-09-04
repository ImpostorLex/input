---
tags:
  - sec
---
[[sec plus]]

One of the foundation of cryptography.
- "There is no taking back what you said or did"
- **Hashing** provides proof of integrity however it does not provide a proof that the said person actually sends it.
- Anyone can see the file.
- **Digital Signature**:
	 1. Sender hashes the messages and encrypts it with his/her private key.
	 2. Sender sends the messages along side the encrypted hash.
	 3. Receiver decrypts encrpyted hash with sender's public key.
	 4. Receiver performs the same hashing algorithm to the message and compare the sender's hash with the receiver's hash.
		- This provides **integrity** to the message.
		- This serves as proof that the owner really did sent it because of the public key succesfully decrypting it (**authenticity**).
