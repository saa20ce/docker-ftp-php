FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y vsftpd && \
    mkdir -p /ftproot && \
    mkdir -p /etc/vsftpd/ && \
    chmod 755 /ftproot && \
    rm -rf /var/lib/apt/lists/*

COPY Dockerfile-ftp/ftp_users.txt /etc/vsftpd/virtual_users.txt
COPY Dockerfile-ftp/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY Dockerfile-ftp/vsftpd.sh /usr/sbin/vsftpd.sh
COPY Dockerfile-ftp/manage-users.sh /usr/sbin/manage-users.sh

RUN chmod 755 /usr/sbin/vsftpd.sh && \
    chmod 755 /ftproot && \
    chmod 644 /etc/vsftpd/virtual_users.txt && \
    chmod +x /usr/sbin/vsftpd.sh

EXPOSE 21

CMD ["/usr/sbin/vsftpd.sh"]
