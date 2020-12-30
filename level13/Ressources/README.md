# Level 13

## Vulnerability
Privilege escalation via register manipulation using gdb

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
We can use gdb to change the owner of a currently running process, like this:
```
level13@SnowCrash:~$ gdb ./level13
(gdb) attach process_id
(gdb) call putenv ("UID=4242")
(gdb) detach
```
Unfortunately, when we try this we get the following message:
```
No symbol table is loaded.  Use the "file" command.
```
GDB is telling you is that your binary has been stripped of debugging symbols (a.k.a. debug info).<br/>
Without debug info, you can only debug at the ASM level.<br/>
Let's dump the assembler code. 
```
(gdb) disas main
[...]
   0x08048595 <+9>:	call   0x8048380 <getuid@plt>
   0x0804859a <+14>:	cmp    $0x1092,%eax
[...]
```
It looks like...
Let's try to change the value of eax directly.
```
(gdb) break *main+14
(gdb) r
Starting program: /home/user/level13/level13

Breakpoint 1, 0x0804859a in main ()
(gdb) set $eax=4242
(gdb) print $eax
$1 = 4242
```
Great! Let's resume the program.
```
(gdb) cont
Continuing.
your token is 2A31L79asukciNyi8uppkEuSx
```
Success!

