#!/bin/bash
cd /usr/local/tomcat/bin; ./startup.sh
wget --http-user=admin --http-password=admin "http://localhost:8080/manager/text/deploy?war=file:/struts2_2.3.15.1-showcase.war&path=/struts2_2.3.15.1-showcase" -O -
