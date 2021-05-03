FROM php:7.3-apache

#TODO : A rendre plus propre, séparer les commandes et les commenter pour expliquer leur utilité

#Synchronisation des paquets et installation de la librairie de référence officielle pour PNG   
RUN apt-get update && apt-get -y install libpng-dev

# Permet d'installer des extensions PHP avec Docker
RUN docker-php-ext-install mysqli gd exif
RUN apt install -y nginx
RUN apt install openssl

#Copie des fichiers sources vers la destination, évite d'aller chercher le zip et les opérations longues
COPY Piwigo/ /var/www/html/


#Ouvrir les droits de lecture, écriture et éxeutions aux utilisateurs
RUN chmod 777  -R /var/www/html/

RUN mkdir -p /etc/nginx/ssl/
RUN chmod 777  -R /etc/nginx/ssl/

RUN apt-get install -y python-certbot-apache

#générer une key privée / certificat ssl  
RUN openssl req -newkey rsa:4096 \
            -x509 \
            -sha256 \
            -days 3650 \
            -nodes \
            -out /etc/nginx/ssl/example.key \
            -keyout /etc/nginx/ssl/example.crt \
            -subj "/C=SI/ST=Ljubljana/L=Ljubljana/O=Security/OU=IT Department/CN=www.example.com"

# Redémarrage du serveur Apache
RUN apache2ctl restart

#Dossier de travail
WORKDIR /var/www/html

#Port sur lequel on renvoie les informations
EXPOSE 80