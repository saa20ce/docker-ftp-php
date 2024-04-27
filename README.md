# docker-ftp-php

Run docker containers
```bash
docker compose build
docker compose up -d
```

On all subsequent launches, you can use
```bash
# for start containers
docker compose start 
# for go to ftp container
docker exec -it ubuntu-ftp-server-1 bash 
# for go to php container
docker exec -it ubuntu-php-container-1 bash 
# for exit to container
exit;
# for stop containers
docker compose stop 
```

Manage FTP Users
```bash
# Adding a new user
docker exec ubuntu-ftp-server-1 ./manage-users.sh add username password

# Deleting a user
docker exec ubuntu-ftp-server-1 ./manage-users.sh delete username
```
