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

# Installing UFW Firewall
install_ufw_firewall() {
     echo "${grn}Installing UFW Firewall ...${end}"
     echo ""
     sleep 3
     apt install ufw
     echo ""
     sleep 1
}

# Allow openSSH UFW
allow_openssh_ufw() {
     echo "${grn}Allow openSSH UFW ...${end}"
     echo ""
     sleep 3
     sudo ufw allow OpenSSH
     echo ""
     sleep 1
}

# Enabling UFW
enabling_ufw() {
     echo "${grn}Enabling UFW ...${end}"
     echo ""
     sleep 3
     yes | sudo ufw enable
     echo "y"
     echo ""
     sleep 1
}

# Run
install_ufw_firewall
allow_openssh_ufw
enabling_ufw