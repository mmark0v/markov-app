FROM ubuntu

SHELL ["/bin/bash", "-c"]
RUN apt-get update -y
RUN apt-get install apache2 -y

WORKDIR /var/www/html/

RUN source /etc/apache2/envvars
COPY . /var/www/html/
RUN echo "ServerName 172.0.0.1" >> /etc/apache2/apache2.conf

EXPOSE 80

CMD apachectl -D FOREGROUND






