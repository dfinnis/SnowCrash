# Level 09

## Vulnerability

## Context

In our home directory, we find an executable with suid and a token which we can ```cat``` but whose contents appear encrypted. 
```
level09@SnowCrash:~$ ls -l
total 12
-rwsr-sr-x 1 flag09 level09 7640 Mar  5  2016 level09
----r--r-- 1 flag09 level09   26 Mar  5  2016 token
level09@SnowCrash:~$ cat token
f4kmm6p|=�p�n��DB�Du{��
```

## Solution

Let's pass some other input to the binary to see what happens. 
```
level09@SnowCrash:~$ ./level09 "oh hi"
oi"km
level09@SnowCrash:~$ ./level09 abcdef
acegik
level09@SnowCrash:~$ ./level09 12345
13579
```
