FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y software-properties-common

RUN add-apt-repository ppa:ondrej/php && \
    apt-get update

RUN apt-get install -y php5.6-cli php7.4-cli php8.2-cli

RUN echo '#!/bin/bash\n/usr/bin/php5.6 "$@"' > /usr/local/bin/p5 && \
    echo '#!/bin/bash\n/usr/bin/php7.4 "$@"' > /usr/local/bin/p7 && \
    echo '#!/bin/bash\n/usr/bin/php8.2 "$@"' > /usr/local/bin/p8 && \
    chmod +x /usr/local/bin/p5 /usr/local/bin/p7 /usr/local/bin/p8

WORKDIR /var/www/html

CMD ["tail", "-f", "/dev/null"]