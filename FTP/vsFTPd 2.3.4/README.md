### vsFTPd 2.3.4

This is a build of an older vulnerable piece of software, known to be backdoored. Multiple exploits are looming around so it is well known. 

It is perfect in order to know what kind of type of exploit to expect and to filter out random attacks against specific ones.

Thus making it good enough for a logging solution to know exactly what to expect and report. 

As this is a part of the Honey Net branch, as the name suggests it should be used to bait attackers in order to try out exploits and blacklist them before they get to your actual network. What type of logging solution you use is completely your choice. Pretty much anything that will work with the Debian image is OK.

This docker container is created by downloading an approved vulnerable vsFTPd 2.3.4 version from https://www.exploit-db.com/

The provided Dockerfile manually installs, checks, optimizes and serves the application.

___This vulnerable app is a dud in terms of exploitation, since you should not open the 6200 backdoor docker port that will be activated from any successful attack. Preferably only port 21 should be open. If you notice, this is not done on the ideal un-supported, un-safe type of OS but on the latest Debian Image from Docker store. It is not meant to be broken in to, but it should be used as bait to irritate attackers in order to try multiple attack vectors and be recorded.___

Instructions (This has been tested on Ubuntu 16.04 LTS Server with Docker installed):

Make sure you have internet connection and Docker already installed on your machine.

Please download the following files in a single directory:

- Dockerfile
- start.sh
- vsftpd.conf

They are needed in order to have a successfull build.

Run the following command to build the image when you are in said directory:

`docker build -t vsftpd.2.3.4 .`

After it finishes, you should have a new image.

Please continue by raising it with:

`docker run -itd -p 21:21 vsftpd.2.3.4`

Note: This is the time where you give whatever ports you want exported, if you have a logging solution or specific scripts that will extract information, you can add their ports now with an additional -p <#:#>

Enter, modify and install whatever you logging solution is with:

`docker exec -u 0 -it <container-name> bash`

Congratulations, you have a running container ready to bait attackers.

Freely add or remove things that you find useful or not to the dockerfile and image overall in order to make it work best with your solution.

___NOTE: Link used to download the package can be seen in the Dockerfile. If for some reason it gets broken in the future, please let me know or REPLACE it in the Dockerfile with the same package I have uploaded on my GitHub account. It is named as 2ea5d19978710527bb7444d93b67767a-vsftpd-2.3.4.tar.gz | This is the same one as the one on Exploit DB downloaded at that point in time. So it should work perfectly.___

For the same package you can either download it manually from my GitHub account and replace it in the Dockerfile or replace the line RUN wget https://www.exploit-db.com/apps/2ea5d19978710527bb7444d93b67767a-vsftpd-2.3.4.tar.gz with the link that downloads the new file hosted on GitHub such as: https://github.com/n-ks/Honey-Net/raw/master/FTP/vsFTPd%202.3.4/2ea5d19978710527bb7444d93b67767a-vsftpd-2.3.4.tar.gz

This is just in case Exploit DB stops serving the broken applications one day, so yo have it here as well.

If everything worked as it should, you should have a running container serving the new bait. To test this you can do a small Nmap scan from another machine:

```
root@kali-nks:~# nmap -Pn -sV -T4 192.168.1.3
Starting Nmap 7.70 ( https://nmap.org ) at 2018-05-30 09:52 CEST
Nmap scan report for 192.168.1.3
Host is up (0.000093s latency).
Not shown: 998 closed ports
PORT   STATE SERVICE VERSION
21/tcp open  ftp     vsftpd 2.3.4
```

If this is what you see, this is what attackers will see as well.

To test if it is really a dud, try the official exploit:

```
Module options (exploit/unix/ftp/vsftpd_234_backdoor):

   Name   Current Setting  Required  Description
   ----   ---------------  --------  -----------
   RHOST  192.168.1.3      yes       The target address
   RPORT  21               yes       The target port (TCP)


Exploit target:

   Id  Name
   --  ----
   0   Automatic


msf exploit(unix/ftp/vsftpd_234_backdoor) > exploit

[*] 192.168.1.3:21 - Banner: 220 (vsFTPd 2.3.4)
[*] 192.168.1.3:21 - USER: 331 Please specify the password.
[*] Exploit completed, but no session was created.
msf exploit(unix/ftp/vsftpd_234_backdoor) > 
```
Since the backdoor 6200 should not be ported back and the OS on which this is hosted is not the ideal setup, you should have a hard time getting through. But what really matters is shown in the logs:

```
root@4189cf203123:/# cd /var/log
root@4189cf203123:/var/log# ls
alternatives.log  apt  btmp  dpkg.log  faillog  lastlog  vsftpd.log  wtmp
root@4189cf203123:/var/log# cat vsftpd.log
Wed May 30 07:52:03 2018 [pid 10] CONNECT: Client "192.168.1.4"
Wed May 30 07:55:50 2018 [pid 12] CONNECT: Client "192.168.1.4"
Wed May 30 07:55:50 2018 [pid 11] [7fld:)] FAIL LOGIN: Client "192.168.1.4"
root@4189cf203123:/var/log#
```

We notice that the attack has been recorded, with the exploit being a Smiley Face after any random string of characters in the username.

You can optimize your logging solutions to specifically look for this, then you know that someone is using a specific exploit on your property and once caught, you should locate and blacklist that IP before they go for the rest of your network.

As said before, this is a great way to keep safe, but also at the same time filter random scans from actual exploits.
