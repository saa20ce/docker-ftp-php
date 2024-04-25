#!/bin/bash

create_user_dirs() {
    while IFS=: read -r user pass; do
        if ! id "$user" &>/dev/null; then
            useradd -m -d "/ftproot/$user" -s /bin/bash "$user"
            echo "$user:$pass" | chpasswd
            mkdir -p "/ftproot/$user/$user"
            chown -R "$user:$user" "/ftproot/$user/$user"
            chmod 700 "/ftproot/$user/$user"
            echo "Created directory /ftproot/$user for user $user"
        fi
    done < /etc/vsftpd/ftp_users.txt
}

create_user_dirs

chmod 755 /ftproot
find /ftproot -mindepth 1 -maxdepth 1 -type d -exec chmod 700 {} \;
find /ftproot -mindepth 1 -maxdepth 1 -type d -exec chown $(basename {}):{} \;

ls -la /ftproot
cat /var/log/vsftpd.log

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
