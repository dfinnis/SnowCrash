# Level 02

## Vulnerability
password sniffing

## Context
In our home directory, we see a .pcap file, which contains packet data captured over a network.

## Solution

```
brew install wireshark
scp -P4242 level02@192.168.0.15:/home/user/level02/level02.pcap level02.pcap
chmod 755 level02.pcap

tshark -o data.show_as_text:TRUE -T fields -e data.text -r level02.pcap
-e Add a field to the list of fields to display
-o preference:value
-r read_file
-T Set the format of the output when viewing decoded packet data
