#!/bin/bash

#read -p "Enter Your Name: "  username
#read -p "Enter ip: "  ip
#read -s -p "Enter Password: " pswd
#
#echo "Welcome $username!"
#echo $pswd
#
#ssh $username@$ip

#sudo apt upate
#sudo apt upgrade

#sudo apt-get install aptitude vim
#sudo aptitude install apache2 php composer git

sudo rm -rf /var/www/public_html

sudo a2dissite 000-default.conf
sudo systemctl reload apache2

read -p "Nom de domaine : " domain

sudo echo "<VirtualHost *:80>" > /temp/install/"$domain".conf
sudo echo "    ServerAdmin webmaster@localhost" >> /temp/install/"$domain".conf
sudo echo "    DocumentRoot /var/www/$domain" >> /temp/install/"$domain".conf
sudo echo "" >> /temp/install/"$domain".conf
sudo echo "    ErrorLog /var/www/$domain/logs/error.log" >> /temp/install/"$domain".conf
sudo echo "    CustomLog /var/www/$domain/logs/access.log combined" >> /temp/install/"$domain".conf
sudo echo "</VirtualHost>" >> /temp/install/"$domain".conf

sudo mv /tmp/"$domain".conf /etc/apache2/sites-available/"$domain".conf

sudo git clone https://github.com/hayanisaid/bootstrap4-website.git /var/www/"$domain"

sudo mkdir -p /var/www/"$domain"/logs
sudo chmod -R 755 /var/www/"$domain"/logs

sudo a2ensite "$domain".conf
sudo systemctl reload apache2
