# Level 13

## Vulnerability

## Context
```
level13@SnowCrash:~$ ls -l
-rwsr-sr-x 1 flag13 level13 7303 Aug 30  2015 level13
```
## Solution
Looks like a binary. Let's try running it. 
```
level13@SnowCrash:~$ ./level13
UID 2013 started us but we we expect 4242
```
It looks like it wants our UID (user id) to be 4242.
Let's verify our username and user id.
```
level13@SnowCrash:~$ whoami
level13
level13@SnowCrash:~$ echo $UID
2013
```
Unforunately, you cannot change your user's UID when it is logged in a session. <br/>
We're going to have to find another way. 
