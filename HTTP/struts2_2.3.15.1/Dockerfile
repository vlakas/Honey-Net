FROM ubuntu:16.04
MAINTAINER nikola.k.stamov@protonmail.com
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y unzip default-jdk build-essential wget vim net-tools
COPY apache-tomcat-9.0.8.tar.gz /apache-tomcat-9.0.8.tar.gz
RUN tar xvf apache-tomcat-9.0.8.tar.gz
RUN mkdir /usr/local/tomcat
RUN mv /apache-tomcat-9.0.8/* /usr/local/tomcat
COPY struts-2.5.10-all.zip /struts-2.5.10-all.zip
RUN unzip struts-2.5.10-all.zip
RUN mv struts-2.5.10 struts2
COPY apache-maven-3.5.3-bin.tar.gz /apache-maven-3.5.3-bin.tar.gz
RUN tar xvf apache-maven-3.5.3-bin.tar.gz -C /opt/
RUN cd /opt/apache-maven-3.5.3/bin; yes | ./mvn archetype:generate -DgroupId=com.vulnshit -DartifactId=myWebApp -DarchetypeArtifactId=maven-archetype-webapp
RUN rm /opt/apache-maven-3.5.3/bin/myWebApp/pom.xml
COPY pom.xml /opt/apache-maven-3.5.3/bin/myWebApp
RUN cd /opt/apache-maven-3.5.3/bin/myWebApp; ../mvn clean package
COPY tomcat-users.xml /usr/local/tomcat/conf
COPY manager.xml /usr/local/tomcat/conf/Catalina/localhost/manager.xml
RUN cd /usr/local/tomcat/bin; ./startup.sh
COPY struts2_2.3.15.1-showcase.war /struts2_2.3.15.1-showcase.war
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD /start.sh && tail -f /dev/null
