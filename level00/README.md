# Level 00

## Vulnerability

Weak password ecryption

## Context

In the subject, we are given the following hint:
*Find the password that will log you in with the "flag00" account.*

## Solution

Let's log in from a separate shell.
```
ssh level00@{VM_IP} -p 4242
```

Find all files belonging to user *flag00*, decluttering output by redirecting error messages to /dev/null. 
```
level00@SnowCrash:~$ find / -user flag00 2>/dev/null
/usr/sbin/john
/rofs/usr/sbin/john
```

Cat those files.
```
level00@SnowCrash:~$ cat `find / -user flag00 2>/dev/null`
cdiiddwpgswtgt
cdiiddwpgswtgt
```

This does not work as the password to flag00 or level01. Maybe it's encrypted?

We run the string through a simple [Ceasar cipher](https://www.dcode.fr/caesar-cipher). The top result is:
**nottoohardhere**

Let's try to log in to user flag00...
```
level00@SnowCrash:~$ su flag00
Password: nottoohardhere
```

Run getflag, as indicated by the subject.
```
flag00@SnowCrash:~$ getflag
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
```
