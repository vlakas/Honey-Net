### ssh-ftp-hole

As this is in the Honey Net branch, you should assume that it is meant for creation of Honey Pots only.

You should never expose this build in your actual network unless you take proper precautions.

This builds a docker which holds an FTP & SSH application inside.

The FTP application has been set up to expose its port on the usual 21 port while the SSH is exposing on 2222.

The reasoning behind this bait is that the FTP allows anonymous access and after the build, already holds the root private key.

This is supposed to be an easier type of bait which is rather custom and can differentiate between scanners and actual attacks.

INSTRUCTIONS:

1. It is always best to pull the already pre-build docker image from my repository:

https://hub.docker.com/r/nksnksnks/ssh-ftp-hole/

https://store.docker.com/community/images/nksnksnks/ssh-ftp-hole

2. If you for some reason want to do it manually or configure/modify things, please download all of the files in a single directory.

3. Everything you need should be there, now can you build your Docker Image:

docker build -t ssh-ftp-vuln-final .

4. After your image is successfully built, you can raise it with:

docker run -itd -p 21:21 -p 2222:2222 <docker-image-name>

6. To enter your new container and install whatever logging system you want, you can do the following:

docker exec -u 0 -it <container-name> bash

7. Congratulations, you have a working vulnerable atmosphere.

___NOTE: The OS on which this was tested was Ubuntu 16.04 LTS with Docker CE installed.___

___NOTE 2: The image used from Docker Hub is Debian based, so any logging solution that you can think of that will work with Debian will probably work for you, only thing to keep in mind is the ports you'll need to add for said solution.___

___NOTE 3: Make sure you limit your containers resources and security so it doesn't spread to your host in any way.___

Result:

First log in to the FTP that allows anonymous access and retrieve the key:

```
root@kali-nks:~# ftp 192.168.1.3
Connected to 192.168.1.3.
220 (vsFTPd 3.0.3)
Name (192.168.1.3:root): anonymous
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> ls
200 PORT command successful. Consider using PASV.
150 Here comes the directory listing.
drwxr-xr-x    1 ftp      ftp          4096 Jun 05 12:34 pub
226 Directory send OK.
ftp> cd pub
250 Directory successfully changed.
ftp> ls
200 PORT command successful. Consider using PASV.
150 Here comes the directory listing.
-rw-r--r--    1 ftp      ftp          1679 Jun 05 12:34 id_rsa
226 Directory send OK.
ftp> get id_rsa 
local: id_rsa remote: id_rsa
200 PORT command successful. Consider using PASV.
150 Opening BINARY mode data connection for id_rsa (1679 bytes).
226 Transfer complete.
1679 bytes received in 0.00 secs (9.8234 MB/s)
ftp> quit
221 Goodbye.
```

Now use the key to enter the custom SSH port. (Make sure right permissions are used):

```
root@kali-nks:~# ssh -i id_rsa 192.168.1.3 -p 2222
The authenticity of host '[192.168.1.3]:2222 ([192.168.1.3]:2222)' can't be established.
ECDSA key fingerprint is SHA256:2/5lSfr4K9sdzvB0nsew20pq7zsJYoiBz0GRZnwihJ8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '[192.168.1.3]:2222' (ECDSA) to the list of known hosts.
Linux f0bc51d9822d 4.4.0-127-generic #153-Ubuntu SMP Sat May 19 10:58:46 UTC 2018 x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
root@f0bc51d9822d:~# 
```
