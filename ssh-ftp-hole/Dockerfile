FROM debian
MAINTAINER nikola.k.stamov@protonmail.com
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install sudo openssh-server nano vim net-tools vsftpd
RUN echo "Port 2222" >> /etc/ssh/sshd_config
RUN sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.orig
RUN sudo mkdir -p /var/ftp/pub
RUN sudo chown nobody:nogroup /var/ftp/pub
RUN mkdir /root/.ssh
COPY authorized_keys /root/.ssh/authorized_keys
COPY id_rsa /root/.ssh/id_rsa
RUN rm /etc/vsftpd.conf
COPY vsftpd.conf /etc/vsftpd.conf
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys
RUN cp /root/.ssh/id_rsa /var/ftp/pub
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD /start.sh; sleep infinity
