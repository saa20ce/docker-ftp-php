FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y software-properties-common vim cron

RUN add-apt-repository ppa:ondrej/php && \
    apt-get update

RUN apt-get install -y php5.6-cli php7.4-cli php8.2-cli

RUN echo "alias p5='php5.6'" >> /etc/bash.bashrc && \
    echo "alias p7='php7.4'" >> /etc/bash.bashrc && \
    echo "alias p8='php8.2'" >> /etc/bash.bashrc

COPY Dockerfile-php/cronjob /etc/cron.d/my-cronjob
RUN chmod 0644 /etc/cron.d/my-cronjob
RUN crontab /etc/cron.d/my-cronjob
RUN touch /var/log/cron.log

CMD cron && tail -f /var/log/cron.log    
#CMD ["tail", "-f", "/dev/null"]