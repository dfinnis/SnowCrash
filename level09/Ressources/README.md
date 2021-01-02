# Level 09

## Vulnerability
Ecryption vulnerable to reverse engineering

## Context

In our home directory, we find an executable with suid and a token which we can ```cat``` but whose contents appear encrypted. 
```
level09@SnowCrash:~$ ls -l
total 12
-rwsr-sr-x 1 flag09 level09 7640 Mar  5  2016 level09
----r--r-- 1 flag09 level09   26 Mar  5  2016 token
level09@SnowCrash:~$ cat token
f4kmm6p|=�p�n��DB�Du{��
```

## Solution
Let's see what the executable does.
```
level09@SnowCrash:~$ ./level09
You need to provide only one arg.
level09@SnowCrash:~$ ./level09 token
tpmhr
```
Strange. Let's experiment by passing some other input to the executable. 
```
level09@SnowCrash:~$ ./level09 aaaaa
abcde
level09@SnowCrash:~$ ./level09 11111
12345
```
It looks like the executable expects a string as the first argument, and outputs that string with each character rotated [char + index in string].

We can create a simple C file to decrypt this:
```
#include <stdio.h>
#include <unistd.h>
int main(int ac, char **argv)
{
	if (ac != 2)
		return (0);
	int i = -1;
	while (argv[1][++i])
		argv[1][i] -= i;
	printf("Flag09 password : %s\n", argv[1]);
	return (1);
}
```
Let's save the VM level09 token to our local machine.
```
>$ scp -P 4242 level09@192.168.0.15:token token

[... VM prompt for level09 password...]
password: 25749xKZ8L7DkSCwJkT9dyv6f

>$ ls
decrypt.c token
>$ chmod 755 token
```
Then we compile ```decrypt.c``` and run with the token to find the decrypted password.
```
>$ gcc decrypt.c -o decrypt
>$ ./decrypt `cat token`
Flag09 password : f3iji1ju5yuevaus41q1afiuq
```
Et voilà ! Let's use this to log into flag09.
```
level09@SnowCrash:~$ su flag09
Password: f3iji1ju5yuevaus41q1afiuq
Don't forget to launch getflag !
flag09@SnowCrash:~$ getflag
Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z
```
