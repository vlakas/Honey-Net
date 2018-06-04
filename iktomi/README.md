### iktomi

Iktomi is a small tool melded together through Perl & Bash that acts as a Honey Pot simulator.

It basically opens well known ports, accepts/closes connections and records which addresses visited said ports.

This has been tested on Ubuntu 16.04 LTS Server and the pre requisits are as follows:

* Linux
* Perl (Most modern version should do)
* Bash
* Ps (Process Tool, which is available on most systems)

These dependancies come bundleded with most distros.

INSTRUCTIONS:

1. Download and extract the latest iktomi.tar.gz (This should hold everything that you need)

2. If you want to download everything manually make sure you keep the order of directories.

```
root@honey-net-worker1:~# ls -R iktomi/
iktomi/:
iktomi.sh  listeners  logs  scripts

iktomi/listeners:
plist21.pl  plist25.pl  plist443.pl  plist8080.pl  plist80.pl

iktomi/logs:

iktomi/scripts:
cleaner.sh  extractor.sh  shutdown.sh  startup.sh
```
3. You should operate the tool by executing iktomi.sh:

```
root@honey-net-worker1:~/iktomi# ./iktomi.sh
  ,   .                        ,    ,-.
o |   |             o         '|   /  /\
. | , |-  ,-. ;-.-. .   . ,    |   | / |
| |<  |   | | | | | |   |/     |   \/  /
' ' ` `-' `-' ' ' ' '   '   o  ' o  `-'

Please choose an option:

 1) Start Listeners
 2) Extract Summary
 3) View Current Summary
 4) Clean Up
 5) Stop Listeners
 6) Exit
```
* Start Listeners will start all the port listeners located inside the Listeners directory.
* Extract Summary will process all of the logs and give you a FINAL.log that will hold all addresses that visited you.
* View Current Summary will list out the FINAL.log and will show you all addresses that visited you so far. (For more details you can visit the logs directory to see exactly what types of connection strings passed through.)
* Clean Up will do exactly that, clean up all logs except the FINAL.log
* Stop Listeners will stop all listeners that were previously started.
* Exit will quit the program no questions asked.

Result:

```
PORT 25:

192.168.1.4

PORT 80:


PORT 21:

192.168.1.4

PORT 8080:


PORT 443:
```

It gives me all of the addresses that visited our listeners and also tells us on which ports exactly that happened.

Basically it is a low impact solution that simply throws a bait out and if you catch weird addresses scanning very specific ports or more importantly, if you catch Internal addresses scanning you it could mean that you have been infiltrated in some way.

It is a good and simple way to monitor weird activity in your network.
