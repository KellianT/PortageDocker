FROM php:7.3-apache

WORKDIR /var/www/html

RUN apt-get update && apt-get -y install curl libzip-dev unzip && apt-get install -y libpng-dev && \
cd /var/www && curl -o piwigo.zip http://piwigo.org/download/dlcounter.php?code=latest && \
unzip piwigo.zip && rm piwigo.zip && rm -rf html && mv piwigo html && docker-php-ext-install mysqli && \ 
sed 's/# The directory where shm and other runtime files will be stored./ServerName localhost/' /etc/apache2/apache2.conf && \
docker-php-ext-install gd 

RUN apache2ctl restart

EXPOSE 80

