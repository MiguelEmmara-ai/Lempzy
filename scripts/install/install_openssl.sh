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

# Install OPENSSL
install_openssl() {
     echo "${grn}Installing OPENSSL${end}"
     echo ""
     sleep 3
     cd /etc/ssl/certs/
     openssl dhparam -dsaparam -out dhparam.pem 4096
     cd
     sudo ufw allow 'Nginx Full'
     sudo ufw delete allow 'Nginx HTTP'
     echo ""
     sleep 1
}

# Run
install_openssl
