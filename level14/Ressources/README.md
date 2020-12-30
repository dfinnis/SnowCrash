# Level 14

## Vulnerability
getflag binary

## Context
No shortcuts to call getflag, so we'll have to find a vulnerability in the getflag binary itself

## Solution
Fancy a hint?
```
flag14@SnowCrash:~$ gdb getflag
...
(gdb) run
Starting program: /bin/getflag
You should not reverse this
```
Lets copy the getflag binary outside of the vm
```
scp -P 4242 scp://level00@{VM_IP}/../../../bin/getflag getflag
```
Then inspect it using [IDA](https://www.hex-rays.com/products/ida/support/download_freeware/)

We find 15 calls to ft_des, these could correspond to the 15 passwords.

Lets have a look at the corresponding memory addresses in gdb
```
level14@SnowCrash:~$ gdb getflag
...
(gdb) b main
Breakpoint 1 at 0x804894a
(gdb) r
Starting program: /bin/getflag

Breakpoint 1, 0x0804894a in main ()
(gdb) ju *0x8048BF3
Continuing at 0x8048bf3.
x24ti5gi3x0ol2eh4esiuxias
```
Great, thats the flag for level00. Searching through the other addresses we find...
```
(gdb) ju *0x8048DE5
Continuing at 0x8048de5.
7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
```
THE END!!!!
```
level14@SnowCrash:~$ su flag14
Password: 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
Congratulation. Type getflag to get the key and send it to me the owner of this livecd :)
flag14@SnowCrash:~$ getflag
Check flag.Here is your token : 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
```
