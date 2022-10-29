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

# Install MariaDB server
install_mariadb() {
     echo "${grn}Installing MariaDB ...${end}"
     echo ""
     sleep 3
     MARIADB_VERSION='10.1'
     debconf-set-selections <<<"maria-db-$MARIADB_VERSION mysql-server/root_password password $1"
     debconf-set-selections <<<"maria-db-$MARIADB_VERSION mysql-server/root_password_again password $1"
     apt-get install -qq mariadb-server
     echo ""
     sleep 1
}

# Run
install_mariadb
