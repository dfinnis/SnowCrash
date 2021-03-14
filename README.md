# SnowCrash

Discover cyber security through 15 little challenges

For each level:

* ```flag``` password for next level

* ```README.md``` how to find password for each level

See the [subject](https://github.com/dfinnis/SnowCrash/blob/master/subject.pdf) for more details.


## Getting Started

### Virtual Machine setup

First download from 42 [*SnowCrash.iso*](https://projects.intra.42.fr/uploads/document/document/2831/SnowCrash.iso).

On Mac OSX, install [VirtualBox](https://www.virtualbox.org/).

In VirtualBox create a new VM (click new).

* Name and operating system - Type: Linux, Version: (Oracle 64-bit).

Continue through all the next steps with the default settings:

* Memory size: 4MB
* Hard disk: Create a disk now
* Hard disk file type: VDI(VirtualBox Disk Image)
* Storage on physical hard disk: Dynamically allocated
* File size: 12,00GB

Next click settings > Network > Adapter 1 > Attached to: Bridged Adapter.

Still in settings click Storage > Right of "Controller: IDE" there is a CD icon with a + sign (add optical drive).

Click Add Disk Image, and select *SnowCrash.iso*

Finally click start, it should show the VM IP address and prompt user to login.

### SSH connect

Let's log in from a separate shell as user *level00* with password *level00*.

```ssh level00@{VM_IP} -p 4242```

<img src="https://github.com/dfinnis/SnowCrash/blob/master/img/ssh.png" width="500">


## Levels Overview

0 - Weak password ecryption

1 - Password stored in publicly readable file, weak encryption

2 - Packet capture & password sniffing

3 - Environment variables

4 - CGI code injection

5 - Cron

6 - PHP code injection

7 - Environment variables

8 - Weak filename check

9 - Ecryption vulnerable to reverse engineering

10 - Symlink attack

11 - Code injection

12 - CGI code injection

13 - Register manipulation using gdb

14 - getflag binary


## Team

I wrote this project in a team with the wonderful [@Anya Schukin](https://github.com/anyashuka)
