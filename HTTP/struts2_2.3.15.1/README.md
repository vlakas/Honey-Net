### Struts2 2.3.15.1

As this is in the Honey Net branch, you should assume that it is meant for creation of Honey Pots only.

You should never expose this build in your actual network unless you take proper precautions.

This is an assembly of multiple components to create a vulnerable Struts environment for exploitation.

The Jakarta Multipart parser in Apache Struts 2 2.3.x before 2.3.32 and 2.5.x before 2.5.10.1 has incorrect exception handling and error-message generation during file-upload attempts, which allows remote attackers to execute arbitrary commands via a crafted Content-Type, Content-Disposition, or Content-Length HTTP header, as exploited with a Content-Type header containing a #cmd= string. 

Since this is a well known vulnerability, it will do well in a Honey Pot, more specifically, it will be useful to filter out typical scanners from someone that is actually trying to exploit your network.

When this kind of action is logged in whatever solution you want to use, you can blacklist that IP before it continues attacking the rest of your network.

Since attackers usually go for weaker targets first, they should focus on this kind of application before anything else, which will give you ample time to prepare and blacklist. This can also serve for re-search purposes, as depending on your logging software, you can log what the attacker is doing once they gain access.

INSTRUCTIONS:

1. Follow the links and instructions on my Docker account:

https://hub.docker.com/r/nksnksnks/apache-struts-jakarta-vuln-cve-2017-5638/

https://store.docker.com/community/images/nksnksnks/apache-struts-jakarta-vuln-cve-2017-5638

Pull the image from here with:

```
docker pull nksnksnks/apache-struts-jakarta-vuln-cve-2017-5638
```

If this is successfull, skip to step 4 and add the appropriate image name or better yet follow the instructions on the Link above.

If for some reason you can't pull and wan't do to it manually, follow the steps below.

2. Download all of the files from the repository, including the vulnerable application.

3. Everything you need should be there, now can you build your Docker Image:

```
docker build -t <docker-image-name> .
```

Note that since it will install,update,upgrade stuff this can take a while. (Some errors are also normal, especially in the manual build)

5. After your image is successfully built, you can raise it with:

```
docker run -itd -p 8080:8080 <docker-image-name>
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
root@kali-nks:~/Desktop/naaledge/strut# python exploit3.py id
[Execute]: id

uid=0(root) gid=0(root) groups=0(root)
```

I've used a specific exploit that is forked on my account from IMMUNIO.
