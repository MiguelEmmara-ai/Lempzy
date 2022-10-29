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

# Restart Services
restart_services() {
     # Get PHP Installed Version
     PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")

     if [[ "${PHP_VERSION}" == "7.2" ]]; then
          systemctl restart php7.2-fpm.service

     elif [[ "${PHP_VERSION}" == "7.3" ]]; then
          systemctl restart php7.3-fpm.service

     elif [[ "${PHP_VERSION}" == "7.4" ]]; then
          systemctl restart php7.4-fpm.service

     elif [[ "${PHP_VERSION}" == "8.1" ]]; then
          systemctl restart php8.1-fpm.service
     else
          echo -e "${red}Sorry, This script is designed for DEBIAN (10, 11), UBUNTU (18.04, 20.04, 22.04, 22.10)${end}"
          exit 1
     fi

     systemctl restart nginx
}

# Run
restart_services
