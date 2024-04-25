FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y php5.6 php5.6-fpm php5.6-mysql php5.6-gd php5.6-xml php5.6-mbstring && \
    mkdir -p /run/php && \
    chown -R www-data:www-data /run/php

CMD ["/usr/sbin/php-fpm5.6", "--nodaemonize"]
