#!/bin/bash

# Script author: Muhamad Miguel Emmara
# Install Laravel

set -e

# Colours
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# Check if you are root
if [ "$(whoami)" != 'root' ]; then
     echo "You have no permission to run $0 as non-root user. Use sudo"
     exit 1
fi

# Variables
domain=$1
domain2=$2
sitesEnable='/etc/nginx/sites-enabled/'
sitesAvailable='/etc/nginx/sites-available/'
domainRegex="^[a-zA-Z0-9]"

# Get PHP Installed Version
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")

# Ask the user to add domain name
while true; do
     clear
     clear
     echo "########################### SERVER CONFIGURED BY MIGUEL EMMARA ###########################"
     echo "                                   ${grn}INSTALL FILERUN${end}"
     echo ""
     echo "     __                                    "
     echo "    / /   ___  ____ ___  ____  ____  __  __"
     echo "   / /   / _ \/ __ \`__ \/ __ \/_  / / / / /"
     echo "  / /___/  __/ / / / / / /_/ / / /_/ /_/ /"
     echo " /_____/\___/_/ /_/ /_/ .___/ /___/\__, /"
     echo "                   /_/          /____/_/"
     echo ""
     echo "${grn}Press [CTRL + C] to cancel...${end}"

     echo "Note* this will erase all of your data on your domain folder, then install Filerun!"
     echo "Preferably install Filerun on your subdomain [eg, manage.domain.com]"
     echo "Feel free to backup any important files before hand!"
     echo ""
     echo "Here all the domain on you server"
     echo ""
     echo "_____________"
     echo "${blu}"
     ls -I default -I phpmyadmin -I filemanager -1 /etc/nginx/sites-enabled/
     echo "${end}_____________"
     echo ""
     read -p ${grn}"Please provide domain [eg, manage.domain.com]${end}: " domain
     read -p ${grn}"Please type your domain one more time${end}: " domain2
     echo
     [ "$domain" = "$domain2" ] && break
     echo "Domain you provide does not match, please try again!"
     read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
done

until [[ $domain =~ $domainRegex ]]; do
     echo -n "Enter valid domain: "
     read domain
done

# Check if domain is not there
check_if_domain_exist() {
     FILE=/etc/nginx/sites-available/$domain
     file2=/var/www/$domain
     if [ -f "$FILE" ] || [ -f "$file2" ]; then
          echo ""
     else
          echo ""
          echo "$domain does not exist, please try again"
          exit
     fi
}

# Create Database
create_database() {
     echo -n "Type the name for your database [eg, db-example-app], followed by [ENTER]: "
     read DB

     #check if database is exist
     DATABASE=/var/lib/mysql/$DB
     if [ -e $DATABASE ]; then
          echo ""
          echo "$DB does exist in the database already, please try again"
          exit
     else
          echo ""
     fi

     echo -n "Type the username for your database [eg, usr-example-app], followed by [ENTER]: "
     read USR

     echo ""
     echo -n "Type the password for your new user [eg, pass-example-app!@#_domain], followed by [ENTER]: "
     read PASS

     mysql -uroot <<MYSQL_SCRIPT
     CREATE DATABASE $DB;
     CREATE USER '$USR'@'localhost' IDENTIFIED BY '$PASS';
     GRANT ALL PRIVILEGES ON $DB.* TO '$USR'@'localhost';
     FLUSH PRIVILEGES;
MYSQL_SCRIPT
}

# Change vhost to no fastcgi cache.
change_vhost() {
     configName=$domain
     cd $sitesAvailable
     cp /root/Lempzy/scripts/vhost-nocache $sitesAvailable$domain
     sed -i "s/domain.com/$domain/g" $sitesAvailable$configName
     sed -i "s/phpX.X/php$PHP_VERSION/g" $sitesAvailable$configName
}

# Install Laravel
install_laravel() {
     rm -rf /var/www/$domain/*
     cd /var/www/$domain/

     while true; do
          echo ""
          read -p ${grn}"Please Provide Your App Name [eg, example-app]${end}: " appname
          read -p ${grn}"Please Type Your App Name One More Time${end}: " appname2
          echo
          [ "$appname" = "$appname2" ] && break
          echo "App Name you provide does not match, please try again!"
          read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
     done

     composer create-project laravel/laravel $appname2 --no-interaction
     cd $appname2

     sed -i "s/APP_URL=.*/APP_URL=https:\\/\\/$domain/g" .env
     sed -i "s/DB_DATABASE=.*/DB_DATABASE=$DB/g" .env
     sed -i "s/DB_USERNAME=.*/DB_USERNAME=$USR/g" .env
     sed -i "s/DB_PASSWORD=.*/DB_PASSWORD=$PASS/g" .env

     chown -R www-data.www-data /var/www/$domain/$appname2/storage
     chown -R www-data.www-data /var/www/$domain/$appname2/bootstrap/cache

     sed -i "s/root \\/var\\/www\\/$domain;/root \\/var\\/www\\/$domain\\/$appname2\\/public;/g" /etc/nginx/sites-available/$domain

     sed -i "s/xxx/xxx/g" /etc/nginx/sites-available/$domain

     php artisan migrate:fresh

}

# Restart nginx and php-fpm
restart_service() {
     echo "Restart Nginx & PHP-FPM ..."
     echo ""
     sleep 1
     systemctl restart nginx
     systemctl restart php$PHP_VERSION-fpm.service
}

# Run
check_if_domain_exist
create_database
change_vhost
install_laravel
restart_service

# Success Prompt
clear
echo "Script By"
echo ""
echo "     __                                    "
echo "    / /   ___  ____ ___  ____  ____  __  __"
echo "   / /   / _ \/ __ \`__ \/ __ \/_  / / / / /"
echo "  / /___/  __/ / / / / / /_/ / / /_/ /_/ /"
echo " /_____/\___/_/ /_/ /_/ .___/ /___/\__, /"
echo "                   /_/          /____/_/"
echo ""

echo "Complete! $domain has been installed with Laravel PHP Frameworks!"
echo "Navigate to ${grn}$domain${end} in your browser and start making awesome apps!"
echo ""
echo "Database Name: $DB"
echo "User Name: $USR"
echo "Password: $PASS"
echo ""
