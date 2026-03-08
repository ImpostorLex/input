
1. Default Passwords
2. Weak Passwords
3. Leaked Passwordsls 
4. Combined wordlists
5. Customized Wordlists

```C
cewl -w list.txt -d 5 -m 5 http://target.labs
```

- `-w` will write the contents to a file. In this case, list.txt.

- `-m 5` gathers strings (words) that are 5 characters or more

- `-d 5` is the depth level of web crawling/spidering (default 2)

6. Username Wordlists

When you have an employee’s first and last name, you can generate many **possible username combinations** that attackers might try during enumeration. A username generator script helps automate this process by combining the parts in common formats.

- **{first name}:** john
- **{last name}:** smith
- **{first name}{last name}:  johnsmith** 
- **{last name}{first name}:  smithjohn**  
- first letter of the **{first name}{last name}: jsmith** 
- first letter of the **{last name}{first name}: sjohn**  
- first letter of the **{first name}.{last name}: j.smith** 
- first letter of the **{first name}-{last name}: j-smith** 
- and so on

Then use `username_generator` that could help create a list with most of the possible combinations if we have a first name and last name.

7. Keyspace techniques

#### Crunch
---
By specifying a range of characters, numbers, and symbols in your wordlist.

```C
crunch 2 2 01234abcd -o crunch.txt
```

- `2 2` Min and Max
- `01234abcd` create a wordlist from these characters and numbers.

Other options that creates different combination of your choice:

`@` - lower case alpha characters

`,` - upper case alpha characters

`%` - numeric characters

`^` - special characters including space

Assume a part of the password is known to you, starting with the word '**pass**' and followed by two numbers, you can use `%` symbol to match numbers:

```C
crunch 6 6 -t pass%%
```

#### Common User Passwords Profiler
---
It is an automatic and interactive tool written in Python for creating custom wordlists.

For example: if you know some details about a specific target, such as their birthdate, pet name, company name, etc., this could be a helpful tool to generate passwords based on this known information.

It also supports for `1337/leet mode` , which substitutes the letters a, i,e, t, o, s, g, z  with numbers.

```C
python3 cupp.py -i
```

- `-i` interactive mode where it asks you questions, press `ENTER` to skip.

```C
python3 cupp.py -l
```

- List down all pre-created wordlists that can be downloaded into your machine.

```C
python3 cupp.py -a
```

- `-a` provide default username and passwords from the Alecto database.

**Offline Attacks:**

9. Brute-force Attacks

Aims to try all combinations of a character or characters wherein dictionary uses pre-created wordlists.

```C
hashcat -a 3 ?d?d?d?d --stdout
```

- `-a 3 ` sets the attacking mode as a brute-force attack

- `?d?d?d?d` the ?d tells hashcat to use a digit. In our case, ?d?d?d?d for four digits starting with 0000 and ending at 9999

- `--stdout` print the result to the terminal

Assume you know it's a four digit PIN number against MD5:

```C
hashcat -a 3 -m 0 05A5CF06982BA7892ED2A6D38FE832D6 ?d?d?d?d
```

10. Rule-based attacks

This attack assumes the attacker knows something about the password policy.

- Pre-existing wordlists maybe useful when generating passwords - for example, manipulating a password such as 'password': `p@ssword`, `Pa$$word`, and so on.

```C
cat /etc/john/john.conf|grep "List.Rules:" | cut -d"." -f3 | cut -d":" -f2 | cut -d"]" -f1 | awk NF
```

[Show list of rules available to John The Ripper]

```C
john --wordlist=/tmp/single-password-list.txt --rules=best64 --stdout | wc -l
```

- `--wordlist=` to specify the wordlist or dictionary file. 

- `--rules` to specify which rule or rules to use.

- `--stdout` to print the output to the terminal.

- `|wc -l`  to count how many lines John produced.

- `KoreLogic` is one of the best rules available to John.

**Custom Rules:**

Assume the following: you want to add special characters to the beginning of each word and add numbers 0-9 at the end. The format will be as follows:

`[symbols]word[0-9]`

Add the following to the end of `john.conf`:

```C
[List.Rules:THM-Password-Attacks] 
Az"[0-9]" ^[!@#$]
```

- `^` means **add something to the beginning** of the word

- `[!@#$]` means **choose one character from this set**

- `Az` means **append something to the end of the word** from the original wordlist/dictionary using `-p`.

- `"[0-9]"` means **add one digit from 0 to 9**. For two digits, we can add `[0-9][0-9]`  and so on.

- `[List.Rules:THM-Password-Attacks]` specify the rule name THM-Password-Attacks.

What is the password? Note that the password format is as follows: `[symbol][dictionary word][0-9][0-9]`.

```C
[List.Rules:clinic-attack] 
Az"[0-9][0-9]" ^[!@#$]
```

```C
hydra -l phillips -P pass.txt 10.48.147.10 http-get-form "/login-get/index.php:username=^USER^&password=^PASS^:S=logout.php" -f 
```

11. Password Spray Attacks

Opposite of brute force attack: one password for many usernames.

