# Level 02

## Vulnerability
packet capture & password sniffing

## Context
In our home directory, we see a .pcap file, which contains packet data captured over a network.

## Solution

Copy the password from the VM to your home machine, and change the permissions. 
```
scp -P4242 level02@{VM_IP}:/home/user/level02/level02.pcap level02.pcap
chmod 755 level02.pcap
```

Install Wireshark, a network protocol analyzer that we will use to read the packets. 
```
brew install wireshark
tshark -o data.show_as_text:TRUE -T fields -e data.text -r level02.pcap
-e Add a field to the list of fields to display
-o preference:value
-r read_file
-T Set the format of the output when viewing decoded packet data
```
It looks like the password is ft_wandrNDRelLOL


Let's try to log in to user flag02...
```
level01@SnowCrash:~$ su flag02
Password: ft_wandrNDRelLOL
```
Run getflag!
```
flag01@SnowCrash:~$ getflag
Check flag.Here is your token : 
```
