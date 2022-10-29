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

# Installing IONCUBE
install_ioncube() {
     echo "${grn}Installing IONCUBE ...${end}"
     echo ""
     sleep 3

     # PHP Modules folder
     MODULES=$(php -i | grep ^extension_dir | awk '{print $NF}')

     # PHP Version
     PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")

     # Download ioncube
     wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
     tar -xvzf ioncube_loaders_lin_x86-64.tar.gz
     rm -f ioncube_loaders_lin_x86-64.tar.gz

     # Copy files to modules folder
     sudo cp "ioncube/ioncube_loader_lin_${PHP_VERSION}.so" $MODULES

     if [[ "${PHP_VERSION}" == "7.2" ]]; then
          # Copy files to modules folder
          echo "zend_extension=$MODULES/ioncube_loader_lin_${PHP_VERSION}.so" >>/etc/php/7.2/fpm/php.ini
          echo "zend_extension=$MODULES/ioncube_loader_lin_${PHP_VERSION}.so" >>/etc/php/7.2/cli/php.ini

     elif [[ "${PHP_VERSION}" == "7.3" ]]; then
          # Copy files to modules folder
          echo "zend_extension=$MODULES/ioncube_loader_lin_${PHP_VERSION}.so" >>/etc/php/7.3/fpm/php.ini
          echo "zend_extension=$MODULES/ioncube_loader_lin_${PHP_VERSION}.so" >>/etc/php/7.3/cli/php.ini

     elif [[ "${PHP_VERSION}" == "7.4" ]]; then
          # Copy files to modules folder
          echo "zend_extension=$MODULES/ioncube_loader_lin_${PHP_VERSION}.so" >>/etc/php/7.4/fpm/php.ini
          echo "zend_extension=$MODULES/ioncube_loader_lin_${PHP_VERSION}.so" >>/etc/php/7.4/cli/php.ini

     elif [[ "${PHP_VERSION}" == "8.1" ]]; then
          # Copy files to modules folder
          echo "zend_extension=$MODULES/ioncube_loader_lin_${PHP_VERSION}.so" >>/etc/php/8.1/fpm/php.ini
          echo "zend_extension=$MODULES/ioncube_loader_lin_${PHP_VERSION}.so" >>/etc/php/8.1/cli/php.ini
     else
          echo -e "${red}Sorry, This script is designed for DEBIAN (10, 11), UBUNTU (18.04, 20.04, 22.04, 22.10)${end}"
          exit 1
     fi

     rm -rf ioncube

     # Refresh Nginx And PHP
     RESTART_SERVICES=scripts/restart.sh

     if test -f "$RESTART_SERVICES"; then
          source $RESTART_SERVICES
     else
          echo "${red}Cannot Restart Nginx And Nginx${end}"
          exit
     fi

     echo ""
     sleep 1
}

# Run
install_ioncube
