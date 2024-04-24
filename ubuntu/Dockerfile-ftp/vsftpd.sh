#!/bin/bash

USER_FILE="/etc/vsftpd/virtual_users.txt"
DB_FILE="/etc/vsftpd/vsftpd_login.db"
TMP_FILE="/tmp/virtual_users.db"

create_user_dirs() {
    while IFS=: read -r username password; do
        if id "$username" &>/dev/null; then
            echo "User $username already exists, updating password."
            echo "$username:$password" | chpasswd
        else
            useradd -m -p $(openssl passwd -1 "$password") "$username"
            mkdir -p "/ftproot/$username"
            chown -R "$username:$username" "/ftproot/$username"
            echo "User $username created with directory."
        fi
    done < "$USER_FILE"
}

create_db() {
    echo "Creating database at $DB_FILE"
    rm -f $DB_FILE $TMP_FILE

    while IFS=: read -r username password; do
        hashed_password=$(openssl passwd -1 "$password")
        echo -e "$username\0$hashed_password\0"
    done < "$USER_FILE" > $TMP_FILE

    db_load -T -t hash -f $TMP_FILE $DB_FILE

    if [ -f $DB_FILE ]; then
        echo "Database created successfully."
        chmod 600 $DB_FILE
    else
        echo "Failed to create database."
    fi
}

create_user_dirs
create_db

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
