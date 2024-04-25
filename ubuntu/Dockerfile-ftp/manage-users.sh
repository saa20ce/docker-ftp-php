#!/bin/bash

USER_FILE="/etc/vsftpd/ftp_users.txt"

add_user() {
    local username=$1
    local password=$2

    echo "$username:$password" >> "$USER_FILE"
    echo "User $username added successfully."

    mkdir -p "/ftproot/$username"
    chown -R ftp:ftp "/ftproot/$username" 
    echo "Directory /ftproot/$username created successfully and assigned to ftp user."
}

delete_user() {
    local username=$1

    sed -i "/^$username:/d" "$USER_FILE"
    echo "User $username deleted successfully."

    if [ -d "/ftproot/$username" ]; then
        rm -rf "/ftproot/$username"
        echo "Directory /ftproot/$username deleted successfully."
    else
        echo "Directory /ftproot/$username not found."
    fi
}


if [ "$#" -eq 0 ]; then
    echo "Usage: manage-users.sh add <username> <password>"
    echo "       manage-users.sh delete <username>"
    exit 1
fi

case "$1" in
    "add")
        if [ "$#" -ne 3 ]; then
            echo "Usage: manage-users.sh add <username> <password>"
            exit 1
        fi
        add_user "$2" "$3"
        ;;
    "delete")
        if [ "$#" -ne 2 ]; then
            echo "Usage: manage-users.sh delete <username>"
            exit 1
        fi
        delete_user "$2"
        ;;
    *)
        echo "Unknown command. Usage: manage-users.sh add <username> <password> | delete <username>"
        exit 1
        ;;
esac

exit 0
