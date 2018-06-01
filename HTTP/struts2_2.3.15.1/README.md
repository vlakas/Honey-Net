### Struts2 2.3.15.1

As this is in the Honey Net branch, you should assume that it is meant for creation of Honey Pots only.

You should never expose this build in your actual network unless you take proper precautions.

This is an assembly of multiple components to create a vulnerable Struts environment for exploitation.

The Jakarta Multipart parser in Apache Struts 2 2.3.x before 2.3.32 and 2.5.x before 2.5.10.1 has incorrect exception handling and error-message generation during file-upload attempts, which allows remote attackers to execute arbitrary commands via a crafted Content-Type, Content-Disposition, or Content-Length HTTP header, as exploited with a Content-Type header containing a #cmd= string. 

Since this is a well known vulnerability, it will do well in a Honey Pot, more specifically, it will be useful to filter out typical scanners from someone that is actually trying to exploit your network.

When this kind of action is logged in whatever solution you want to use, you can blacklist that IP before it continues attacking the rest of your network.

Since attackers usually go for weaker targets first, they should focus on this kind of application before anything else, which will give you ample time to prepare and blacklist. This can also serve for re-search purposes, as depending on your logging software, you can log what the attacker is doing once they gain access.

INSTRUCTIONS:
