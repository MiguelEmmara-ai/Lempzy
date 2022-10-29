#!/bin/bash

# Script author: Muhamad Miguel Emmara
# Add Domian + Create Database

#
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
domain2=$3
sitesEnable='/etc/nginx/sites-enabled/'
sitesAvailable='/etc/nginx/sites-available/'
domainRegex="^[a-zA-Z0-9]"

# Get PHP Installed Version
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")

# Ask the user to add domain name
while true; do

    clear
    echo "########################### SERVER CONFIGURED BY MIGUEL EMMARA ###########################"
    echo "                                   ${grn}ADD DOMAIN ONLY${end}"
    echo ""
    echo "     __                                    "
    echo "    / /   ___  ____ ___  ____  ____  __  __"
    echo "   / /   / _ \/ __ \`__ \/ __ \/_  / / / / /"
    echo "  / /___/  __/ / / / / / /_/ / / /_/ /_/ /"
    echo " /_____/\___/_/ /_/ /_/ .___/ /___/\__, /"
    echo "                   /_/          /____/_/"
    echo ""
    echo "${grn}Press [CTRL + C] to cancel...${end}"
    echo ""

    read -p ${grn}"Please provide your domain${end}: " domain
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

# Check if domain already added
if [ -e $sitesAvailable$domain ]; then
    echo "This domain already exists. Please delete your domain from the main menu options and try again"
    exit
fi

# Check if domain already added var www
if [ -e /var/www/$domain ]; then
    echo "This domain already exists. Please delete your domain from the main menu options and try again"
    exit
fi

### CREATE DATABASE ###
#nodot=${domain%%.*}
domainClear=${domain//./}
domainClear2=${domainClear//-/}
echo "Type the password for your new $domain database [eg, password123_$domainClear2]"
echo -n "followed by [ENTER]: "
read PASS

mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE database_$domainClear2;
CREATE USER 'user_$domainClear2'@'localhost' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON database_$domainClear2.* TO 'user_$domainClear2'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Add Domain to the server
mkdir /var/www/$domain

# Install ssl
mkdir -p /etc/ssl/$domain/
cd /etc/ssl/$domain/
openssl req -new -newkey rsa:2048 -sha256 -nodes -out $domain.csr -keyout $domain.key -subj "/C=US/ST=Rhode Island/L=East Greenwich/O=Fidelity Test/CN=$domain"
openssl x509 -req -days 36500 -in $domain.csr -signkey $domain.key -out $domain.crt
service nginx reload

# Add html file to the domain
if ! echo "domain has been added!" >/var/www/$domain/index.html; then
    echo "There is an ERROR create index.html file"
    exit
else
    echo "index.html has been created successfully"
fi
chown -R $USER:$USER /var/www/$domain
nginx -t
systemctl reload nginx
chown -R www-data:www-data /var/www/$domain
systemctl restart php$PHP_VERSION-fpm.service
systemctl restart nginx

# Add Cache to the server
mkdir -p /etc/nginx/mycache/$domain

# Add nginx Vhost FastCGI for domain
configName=$domain
cd $sitesAvailable
wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/vhost-fastcgi -O $domain
sed -i "s/domain.com/$domain/g" $sitesAvailable$configName
sed -i "s/phpX.X/php$PHP_VERSION/g" $sitesAvailable$configName

# PHP POOL SETTING
php_dotdeb="https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/phpdotdeb"
wget -q $php_dotdeb -O /etc/php/$PHP_VERSION/fpm/pool.d/$domain.conf
sed -i "s/domain.com/$domain/g" /etc/php/$PHP_VERSION/fpm/pool.d/$domain.conf
sed -i "s/phpX.X/php$PHP_VERSION/g" /etc/php/$PHP_VERSION/fpm/pool.d/$domain.conf
echo "" >>/etc/php/$PHP_VERSION/fpm/pool.d/$domain.conf
dos2unix /etc/php/$PHP_VERSION/fpm/pool.d/$domain.conf >/dev/null 2>&1
service php$PHP_VERSION-fpm reload

ln -s $sitesAvailable$configName $sitesEnable$configName
nginx -t
systemctl reload nginx

# Restart nginx and php-fpm
echo "Restart Nginx & PHP-FPM ..."
echo ""
sleep 1
systemctl restart nginx
systemctl restart php$PHP_VERSION-fpm.service
clear

# Success Prompt
echo "Script By"
echo ""
echo "     __                                    "
echo "    / /   ___  ____ ___  ____  ____  __  __"
echo "   / /   / _ \/ __ \`__ \/ __ \/_  / / / / /"
echo "  / /___/  __/ / / / / / /_/ / / /_/ /_/ /"
echo " /_____/\___/_/ /_/ /_/ .___/ /___/\__, /"
echo "                   /_/          /____/_/"
echo ""

echo "Complete! Your new $domain domain has been added!"
echo "PLEASE SAVE BELOW INFORMATION."
echo "Database:   database_$domainClear2"
echo "Username:   user_$domainClear2"
echo "Password:   $PASS"
echo ""
rm -f /root/domain1.sh
exit
