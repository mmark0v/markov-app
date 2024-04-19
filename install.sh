#!/usr/bin/env bash

. /root/config

cat << EOF >> /root/000-default-le-ssl.conf
<IfModule mod_ssl.c>
<VirtualHost *:${PORT}>
	# The ServerName directive sets the request scheme, hostname and port that
	# the server uses to identify itself. This is used when creating
	# redirection URLs. In the context of virtual hosts, the ServerName
	# specifies what hostname must appear in the request's Host: header to
	# match this virtual host. For the default virtual host (this file) this
	# value is not decisive as it is used as a last resort host regardless.
	# However, you must set it for any further virtual host explicitly.
	#ServerName www.example.com

	ServerAdmin webmaster@${FQDN}
	DocumentRoot /var/www/html

	# Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
	# error, crit, alert, emerg.
	# It is also possible to configure the loglevel for particular
	# modules, e.g.
	#LogLevel info ssl:warn

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

	# For most configuration files from conf-available/, which are
	# enabled or disabled at a global level, it is possible to
	# include a line for only one particular virtual host. For example the
	# following line enables the CGI configuration for this host only
	# after it has been globally disabled with "a2disconf".
	#Include conf-available/serve-cgi-bin.conf


ServerName www.${FQDN}
ServerAlias ${FQDN}


</VirtualHost>
</IfModule>
EOF

cp /root/000-default-le-ssl.conf /etc/apache2/sites-available/
ln -s /etc/apache2/sites-available/000-default-le-ssl.conf /etc/apache2/sites-enabled/000-default-le-ssl.conf


# # check if certs are installed and remove the cron job if it's done.
# if [[ $(certbot certificates | grep "No certificates found.") ]] 
# then 
#     echo "`date`: No certificates found." | tee -a /var/log/certbot-install.log
#     certbot ${TEST_CERT} -d www.${FQDN} -d ${FQDN} -m ${EMAIL} -n --agree-tos --apache
    
# else 
#     echo "`date`: Certificates found" | tee -a /var/log/certbot-install.log
#     echo "`date`: Checking certificates" | tee -a /var/log/certbot-install.log
#     certbot certificates | tee -a /var/log/certbot-install.log

#     echo "`date`: Removing installation files" | tee -a /var/log/certbot-install.log
#     rm /etc/cron.d/010-install_certbot /root/000-default-le-ssl.conf /root/config /root/install.sh
# fi


# # Adding missing entries in the vhost
# if [[ ! $(grep letsencrypt /etc/apache2/sites-available/*) ]]
# then 
#     sed -i '/ServerAlias/a SSLCertificateKeyFile /etc/letsencrypt/live/www.${FQDN}/privkey.pem' /etc/apache2/sites-available/000-default-le-ssl.conf
#     sed -i '/ServerAlias/a SSLCertificateFile /etc/letsencrypt/live/www.${FQDN}/fullchain.pem' /etc/apache2/sites-available/000-default-le-ssl.conf
#     sed -i '/ServerAlias/a Include /etc/letsencrypt/options-ssl-apache.conf' /etc/apache2/sites-available/000-default-le-ssl.conf
#     /usr/sbin/apachectl restart
# fi