FROM php:7.3-apache

WORKDIR /var/www/html


#TODO : A rendre plus propre, séparer les commandes et les commenter pour expliquer leur utilité

RUN apt-get update && apt-get -y install curl libzip-dev unzip && apt-get install -y libpng-dev && \
cd /var/www && curl -o piwigo.zip http://piwigo.org/download/dlcounter.php?code=latest && \
unzip piwigo.zip && rm piwigo.zip && rm -rf html && mv piwigo html && docker-php-ext-install mysqli && \ 
sed 's/# The directory where shm and other runtime files will be stored./ServerName localhost/' /etc/apache2/apache2.conf && \
sudo apt-get -y install php-common php-mbstring php-xmlrpc php-gd php-xml php-intl php-mysql php-cli php-ldap php-zip php-curl && \
docker-php-ext-install gd 

RUN apache2ctl restart

EXPOSE 80

