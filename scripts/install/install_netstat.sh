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

# Install Netstat
install_netstat() {
     echo "${grn}Installing netstat ...${end}"
     echo ""
     sleep 3
     apt install net-tools -y
     netstat -ptuln
     echo ""
     sleep 1
}

# Run
install_netstat
