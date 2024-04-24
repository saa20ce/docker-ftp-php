FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y vsftpd openssl libpam-runtime libpam-modules db-util && \
    mkdir -p /ftproot /etc/vsftpd/ && \
    chmod 755 /ftproot && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /etc/ssl/private /etc/ssl/certs && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ssl-cert-snakeoil.key -out /etc/ssl/certs/ssl-cert-snakeoil.pem -subj "/C=US/ST=New York/L=New York/O=Global Security/OU=IT Department/CN=example.com"

COPY Dockerfile-ftp/ftp_users.txt /etc/vsftpd/ftp_users.txt
RUN while IFS=':' read -r username password; do \
    echo "$username:$(openssl passwd -1 $password)" >> /etc/vsftpd/virtual_users.txt; \
    done < /etc/vsftpd/ftp_users.txt

COPY Dockerfile-ftp/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY Dockerfile-ftp/vsftpd.sh /usr/sbin/vsftpd.sh
COPY Dockerfile-ftp/manage-users.sh /usr/sbin/manage-users.sh

RUN chmod 755 /usr/sbin/vsftpd.sh && \
    chmod 755 /ftproot && \
    chmod 644 /etc/vsftpd/virtual_users.txt && \
    echo "auth required pam_userdb.so db=/etc/vsftpd/vsftpd_login" >> /etc/pam.d/vsftpd && \
    echo "account required pam_userdb.so db=/etc/vsftpd/vsftpd_login" >> /etc/pam.d/vsftpd && \
    echo "session required pam_loginuid.so" >> /etc/pam.d/vsftpd && \
    chmod +x /usr/sbin/manage-users.sh 
    

EXPOSE 21

CMD ["/usr/sbin/vsftpd.sh"]