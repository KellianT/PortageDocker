# Télécharge l'image docker su serveur PHP + Apache2
FROM php:7.3-apache

#TODO : A rendre plus propre, séparer les commandes et les commenter pour expliquer leur utilité

#Synchronisation des paquets et installation de la librairie de référence officielle pour PNG   
RUN apt-get update && apt-get -y install libpng-dev

# Permet d'installer des extensions PHP avec Docker
RUN docker-php-ext-install mysqli gd exif

#Copie des fichiers sources vers la destination, évite d'aller chercher le zip et les opérations longues
COPY Piwigo/ /var/www/html/

#Ouvrir les droits de lecture, écriture et éxeutions aux utilisateurs
RUN chmod 777  -R /var/www/html/

# Redémarrage du serveur Apache
RUN apache2ctl restart

#Dossier de travail
WORKDIR /var/www/html

#Port sur lequel on renvoie les informations
EXPOSE 80

