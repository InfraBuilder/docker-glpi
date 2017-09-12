FROM ubuntu:16.04

RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
	&& apt-get install -y \
		apache2 \
		libapache2-mod-php \
		php-mbstring \
		php7.0-curl \
		php7.0-gd \
		php7.0-imap \
		php7.0-json \
		php7.0-ldap \
		php7.0-mysql \
		php7.0-xml \
		php7.0-xmlrpc \
		openssl \
	&& apt-get clean

COPY glpi/ /var/www/html/

RUN chown -R www-data:www-data /var/www/html \
	&& sed -i '/DocumentRoot /a <Directory /var/www/html>\n\t\tAllowOverride all\n\t</Directory>' /etc/apache2/sites-enabled/000-default.conf

VOLUME /var/www/html/config
VOLUME /var/www/html/files

CMD ["apachectl","-DFOREGROUND"]
