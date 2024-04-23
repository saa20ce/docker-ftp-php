#!/bin/bash

USER_FILE="/etc/vsftpd/virtual_users.txt"

create_user_dirs() {
    while IFS=: read -r username password; do
        useradd -m -p $(openssl passwd -1 "$password") "$username"
        mkdir -p "/ftproot/$username"
        chown -R "$username:$username" "/ftproot/$username"
    done < "$USER_FILE"
}

create_user_dirs

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
