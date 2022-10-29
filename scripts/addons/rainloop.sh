#!/bin/bash

# Script author: Muhamad Miguel Emmara
# Install Rainloop

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
    echo "                                   ${grn}INSTALL RAINLOOP${end}"
    echo ""
    echo "     __                                    "
    echo "    / /   ___  ____ ___  ____  ____  __  __"
    echo "   / /   / _ \/ __ \`__ \/ __ \/_  / / / / /"
    echo "  / /___/  __/ / / / / / /_/ / / /_/ /_/ /"
    echo " /_____/\___/_/ /_/ /_/ .___/ /___/\__, /"
    echo "                   /_/          /____/_/"
    echo ""
    echo "${grn}Press [CTRL + C] to cancel...${end}"

    echo "Note* this will erase all of your data on your domain folder, then install rainloop webmail!"
    echo "Feel free to backup any important files before hand!"
    echo ""
    echo "Here all the domain on you server"
    echo ""
    echo "_____________"
    echo "${blu}"
    ls -I default -I phpmyadmin -I filemanager -1 /etc/nginx/sites-enabled/
    echo "${end}_____________"
    echo ""
    read -p ${grn}"Please provide domain to be installed with rainloop${end}: " domain
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
FILE=/etc/nginx/sites-available/$domain
file2=/var/www/$domain
if [ -f "$FILE" ] || [ -f "$file2" ]; then
    clear
else
    echo ""
    echo "$domain does not exist, please try again"
    exit
fi

# Change vhost to no fastcgi cache.
configName=$domain
cd $sitesAvailable
cp /root/Lempzy/scripts/vhost-nocache $sitesAvailable$domain
sed -i "s/domain.com/$domain/g" $sitesAvailable$configName

# Intstall RianLoop
rm -rf /var/www/$domain/*
cd /var/www/$domain
wget http://www.rainloop.net/repository/webmail/rainloop-latest.zip
unzip rainloop-latest.zip
rm rainloop-latest.zip
systemctl restart nginx
chown -R www-data:www-data /var/www/$domain

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

echo "${blu}Complete! $domain has been installed with RainLoop Webmail!"
echo "Navigate to $domain/?admin in your browser to configure RainLoop"
echo "The default login are:${end}"
echo ""
echo "${grn}Login: admin"
echo "Password: 12345${end}"
echo ""
