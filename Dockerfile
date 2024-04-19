FROM ubuntu

SHELL ["/bin/bash", "-c"]
RUN apt-get update -y
RUN apt-get install apache2 -y
RUN apt-get install libaugeas0 python3 python3-venv vim cron -y


# Default self-signed SSL
RUN set -eux; \
    apt-get update; \
    apt-get install ssl-cert; \
    a2enmod ssl; \
    a2ensite default-ssl

# Install Certbot 
RUN mkdir /etc/letsencrypt
RUN /usr/bin/python3 -m venv /opt/certbot/
RUN /opt/certbot/bin/pip install --upgrade pip; 
RUN /opt/certbot/bin/pip install certbot certbot-apache 
RUN ln -s /opt/certbot/bin/certbot /usr/bin/certbot


# Install scripts
COPY     config /root
COPY     install.sh /root/
RUN      chmod 755 /root/install.sh

# Install Cron
RUN echo '* * * * * root /bin/bash /root/install.sh;  echo "`date`: running Install Script...." >> /var/log/certbot-cron.log 2>&1' >> /etc/cron.d/010-install_certbot
RUN echo '5 0 */2 * * root /usr/bin/certbot renew;  echo "`date`: running Certbot Renew...." >> /var/log/certbot-cron.log 2>&1' >> /etc/cron.d/099-renew_cron


# Apache files
WORKDIR /var/www/html/
RUN     source /etc/apache2/envvars
COPY    site/. /var/www/html/
RUN     echo "ServerName 172.0.0.1" >> /etc/apache2/apache2.conf

WORKDIR /var/log
EXPOSE  80
EXPOSE  443

CMD ["bash", "-c", "/usr/sbin/cron && /usr/sbin/apachectl -D FOREGROUND"]
