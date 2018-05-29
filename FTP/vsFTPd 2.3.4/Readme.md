vsFTPd 2.3.4

This docker container is created by downloading an approved vulnerable vsFTPd 2.3.4 version from https://www.exploit-db.com/

The provided Dockerfile manually installs, checks, optimizes and serves the vulnerable application.

If you notice, this is done on the latest debian image with certain types of protection enabled, so breaking in to the application is not straight forward.

The thing is it is not meant to be brkoen in to, but it should be used as a bait to irritate attackers in order to try multiple attack vectors and be recorded.

Instructions (This has been tested on Ubuntu 16.04 LTS Server):

Make sure you have internet connection and docker already installed on your machine.

Please download the following files in a single directory:

Dockerfile
start.sh
vsftpd.conf

They are needed in order to have a successfull build.

After it finishes, you should have a new image.

Please continue by raising it with:

docker run -itd -p 21:21 <image-name>

Note: This is the time where you give whatever ports you want exported, if you have a logging solution or specific scripts that will extract information, you can add their ports now with additional -p <#:#>

Enter, modify and install whatever you logging solution is with:

docker exec -u 0 -it <container-name> bash

Congratulations, you have a running container ready to bait attackers.