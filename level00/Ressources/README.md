# Level 00 walkthrough

## VULNERABILITY
password decryption

## CONTEXT
In the subject, we are given the following hint:
"Find the password that will log you in with the "flag00" account."

## SOLUTION

Let's log in from a separate shell.
```
ssh level00@192.168.0.15 -p 4242
```

List all files belonging to user flag00, decluttering output by redirecting error messages to /dev/null. 
```
level00@SnowCrash:~$ find / -user flag00 2>/dev/null
/usr/sbin/john
/rofs/usr/sbin/john
```

Cat the contents of those files.
```
level00@SnowCrash:~$ cat `find / -user flag00 2>/dev/null`
cdiiddwpgswtgt
cdiiddwpgswtgt
```

This does not work as the password to flag00 or level01. Maybe it's encrypted?

We run the string through a simple Ceasar cipher https://www.dcode.fr/caesar-cipher and the top result is:
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
