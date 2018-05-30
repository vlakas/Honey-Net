FROM debian
MAINTAINER nikola.k.stamov@protonmail.com
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential wget vim net-tools
COPY vsftpd-2.3.4-infected /vsftpd-2.3.4
RUN cd /vsftpd-2.3.4 && make; exit 0
RUN cd /vsftpd-2.3.4/ && gcc -o vsftpd main.o utility.o prelogin.o ftpcmdio.o postlogin.o privsock.o tunables.o ftpdataio.o s$
RUN mkdir /usr/share/empty
RUN mkdir /usr/local/man/man8
RUN mkdir /usr/local/man/man5
RUN cd /vsftpd-2.3.4/ && make install
RUN rm /vsftpd-2.3.4/vsftpd.conf
COPY vsftpd.conf /vsftpd-2.3.4/vsftpd.conf
COPY start.sh /start.sh
RUN chown root:root /vsftpd-2.3.4/*
RUN chmod +x /start.sh
CMD /start.sh && tail -f /dev/null
