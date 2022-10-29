#!/bin/bash

# Script author: Muhamad Miguel Emmara
# Install Invoice Ninja

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
     echo "                                   ${grn}INSTALL INVOICE NINJA${end}"
     echo ""
     echo "     __                                    "
     echo "    / /   ___  ____ ___  ____  ____  __  __"
     echo "   / /   / _ \/ __ \`__ \/ __ \/_  / / / / /"
     echo "  / /___/  __/ / / / / / /_/ / / /_/ /_/ /"
     echo " /_____/\___/_/ /_/ /_/ .___/ /___/\__, /"
     echo "                   /_/          /____/_/"
     echo ""
     echo "${grn}Press [CTRL + C] to cancel...${end}"

     echo "Note* this will erase all of your data on your domain folder, then install Invoice Ninja!"
     echo "Preferably install Invoice Ninja on your subdomain [eg, invoiceninja.domain.com]"
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
FILE=/etc/nginx/sites-available/$domain
file2=/var/www/$domain
if [ -f "$FILE" ] || [ -f "$file2" ]; then
     clear
else
     echo ""
     echo "$domain does not exist, please install your domain and try again"
     exit
fi

# Install InvoiceNinja
install_invoice_ninja() {
     rm -rf /var/www/$domain/*
     cd /var/www/$domain/
     wget https://github.com/invoiceninja/invoiceninja/releases/download/v5.5.35/invoiceninja.zip
     unzip invoiceninja.zip
     chown -R www-data:www-data /var/www/$domain
     chown -R www-data:www-data /var/www/$domain
     sudo chmod -R g+s /var/www/$domain
     chown www-data:www-data /var/www/
     chown -R $USER:$USER /var/www/$domain       # JUST TO MAKE SURE
     chown -R www-data:www-data /var/www/$domain # JUST TO MAKE SURE
}

# Change vhost to no fastcgi cache made for InvoiceNinja
vhost_switch() {
     configName=$domain
     cd $sitesAvailable
     cp /root/Lempzy/scripts/vhost-nocache $sitesAvailable$domain
     sed -i "s/domain.com/$domain/g" $sitesAvailable$configName
}

# Create NEW Database For Invoice Ninja
create_new_db_invoice() {
     domainClear=${domain//./}
     domainClear2=${domainClear//-/}

     # Generate random password and save it to password_invoiceNinja variable.
     password_invoiceNinja=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)

     mysql -uroot <<MYSQL_SCRIPT
     CREATE DATABASE invoice_db_$domainClear2;
     CREATE USER 'invoice_usr_$domainClear2'@'localhost' IDENTIFIED BY '$password_invoiceNinja';
     GRANT ALL PRIVILEGES ON invoice_db_$domainClear2.* TO 'invoice_usr_$domainClear2'@'localhost';
     FLUSH PRIVILEGES;
MYSQL_SCRIPT
}

# Configure InvoiceNinja
configure_invoice_ninja() {
     cd /var/www/$domain/
     cp .env.example .env
     sed -i "s/DB_DATABASE=ninja/DB_DATABASE=invoice_db_$domainClear2/g" .env
     sed -i "s/DB_USERNAME=ninja/DB_USERNAME=invoice_usr_$domainClear2/g" .env
     sed -i "s/DB_PASSWORD=ninja/DB_PASSWORD=password_invoiceNinja/g" .env

     # Optimize artisan
     cd /var/www/$domain

     # Create and override .env file's APP_KEY value (php artisan key:generate)
     while IFS="" read -r p || [ -n "$p" ]; do
          if printf '%s' "$p" | grep -Eq '^APP_KEY'; then
               key=$(php artisan key:generate --show)
               echo "APP_KEY=$key" >>.envv
               printf '%s\n' "APP_KEY generated and set"
          else
               #printf '%s\n' "$p"
               echo "$p" >>.envv
          fi

     done <.env

     cp .envv .env
     rm .envv

     php artisan optimize
     cd
}

# Run
install_invoice_ninja
vhost_switch
create_new_db_invoice
configure_invoice_ninja

# Restart nginx and php-fpm
echo "Restart Nginx & PHP-FPM ..."
echo ""
sleep 1
systemctl restart nginx
systemctl restart php$PHP_VERSION-fpm.service

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

echo "Complete! $domain has been installed with Invoice Ninja!"
echo "Navigate to ${grn}$domain${end} in your browser to configure Invoice Ninja"
echo ""
echo "Database Name: invoice_db_$domainClear2"
echo "User Name: invoice_usr_$domainClear2"
echo "Password: $password_invoiceNinja"
