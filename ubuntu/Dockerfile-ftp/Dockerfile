FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y vsftpd whois


COPY Dockerfile-ftp/ftp_users.txt /etc/vsftpd/ftp_users.txt
COPY Dockerfile-ftp/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY Dockerfile-ftp/vsftpd.sh /usr/local/bin/vsftpd.sh
COPY Dockerfile-ftp/manage-users.sh /manage-users.sh

RUN mkdir -p /var/run/vsftpd/empty && \
    chown root:root /var/run/vsftpd/empty && \
    chmod 755 /var/run/vsftpd/empty && \
    mkdir -p /ftproot && \
    chmod 755  /ftproot 
    

EXPOSE 21

CMD ["vsftpd.sh"]