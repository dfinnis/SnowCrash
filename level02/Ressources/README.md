# Level 02

## Vulnerability
packet capture & password sniffing

## Context
In our home directory, we see a .pcap file, which contains packet data captured over a network.

## Solution

Copy the password from the VM to your home machine, and change the permissions. 
```
>$ scp -P4242 level02@{VM_IP}:/home/user/level02/level02.pcap level02.pcap
>$ chmod 755 level02.pcap
```

Install Wireshark, a network protocol analyzer, and use it to read the packets from the pcap file. 
```
>$ brew install wireshark
>$ tshark -o data.show_as_text:TRUE -T fields -e data.text -r level02.pcap
```
It looks like the password is at the end of this output, but it's not quite readable... Let's clean that up.
```
>$ tshark -o data.show_as_text:TRUE -T fields -e data.text -r level02.pcap | tr -cd '\47-\177' | tail -c 22 | head -c 20 | xargs
ft_wandrNDRelL0L
```

Let's try to log in to user flag02...
```
level02@SnowCrash:~$ su flag02
Password: ft_wandrNDRelL0L
```
Run getflag!
```
flag02@SnowCrash:~$ getflag
Check flag.Here is your token : kooda2puivaav1idi4f57q8iq
```
