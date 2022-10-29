#!/bin/bash

set -e

# Colours
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# Install and start nginx
install_nginx() {
     echo "${grn}Installing NGINX ...${end}"
     echo ""
     sleep 3
     apt-get install nginx -y
     sudo ufw allow 'Nginx HTTP'
     systemctl start nginx
     echo ""
     sleep 1
}

# Config to make PHP-FPM working with Nginx
configuring_php_fpm_nginx() {
     echo "${grn}Configuring to make PHP-FPM working with Nginx ...${end}"
     echo ""
     sleep 3
     rm -rf /etc/nginx/nginx.conf
     cd /etc/nginx/
     cp /root/Lempzy/scripts/nginx.conf nginx.conf
     dos2unix /etc/nginx/nginx.conf
     cd
     echo ""
     sleep 1
}

# Run
install_nginx
configuring_php_fpm_nginx
