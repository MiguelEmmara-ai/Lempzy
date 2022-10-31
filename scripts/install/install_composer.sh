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

# Install composer
install_composer() {
     echo "${grn}Installing composer ...${end}"
     echo ""
     sleep 3
     cd ~
     curl -sS https://getcomposer.org/installer -o composer-setup.php
     sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
     echo ""
     sleep 1
}

# Run
install_composer
