#!/bin/bash

# Script author: Muhamad Miguel Emmara
# Back up web data

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

# Ask the user to add domain name
while true; do
     clear
     clear
     echo "########################### SERVER CONFIGURED BY MIGUEL EMMARA ###########################"
     echo "                                   ${grn}BACKUP WEBSITE${end}"
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
     echo "${blu}THIS OPTION WILL BACKUP YOUR WEBSITE DATA TO A ZIP FILE (NOT INCLUDE DATABASE)${end}"
     echo "Here all the domain on you server"
     echo ""
     echo "_____________"
     echo "${blu}"
     ls -I default -I phpmyadmin -I filemanager -1 /etc/nginx/sites-enabled/
     echo "${end}_____________"
     echo ""
     read -p ${grn}"Please provide domain${end}: " domain
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
check_domain_exist() {
     FILE=/etc/nginx/sites-available/$domain
     file2=/var/www/$domain
     if [ -f "$FILE" ] || [ -f "$file2" ]; then
          clear
     else
          echo ""
          echo "$domain does not exist, please try again"
          exit
     fi
}

# BACK UP DOMAIN DATA TO A ZIP FILE
backup_domai_data() {
     domainClear=${domain//./}
     domainClear2=${domainClear//-/}
     cd /var/www/
     zip -r backup-$domainClear2.zip $domain/
     mv backup-$domainClear2.zip $domain/
     chown www-data:www-data /var/www/$domain/backup-$domainClear2.zip
}

# Run
check_domain_exist
backup_domai_data
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

echo "${blu}Complete! Your new $domain domain has been backed up!"
echo "you can download your backup .zip file from below link${end}"
echo "${grn}$domain/backup-$domainClear2.zip${end}"
echo ""
