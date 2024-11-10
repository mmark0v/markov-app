FROM ubuntu

SHELL ["/bin/bash", "-c"]
RUN apt-get update -y
RUN apt-get install apache2 -y

# Default self-signed SSL
RUN set -eux; \
    apt-get install ssl-cert; \
    a2enmod ssl; \
    a2ensite default-ssl

WORKDIR /var/www/html/

RUN source /etc/apache2/envvars
COPY site/. /var/www/html/
RUN echo "ServerName 172.0.0.1" >> /etc/apache2/apache2.conf

EXPOSE 80
EXPOSE 443

CMD apachectl -D FOREGROUND






