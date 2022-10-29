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

# Get OS Version
OS_VERSION=$(lsb_release -rs)

# Update os
update_os() {
     echo "${grn}Starting update os ...${end}"
     echo ""
     sleep 3
     # By default this is set to "interactive" mode which causes the interruption of scripts.
     if [[ "${OS_VERSION}" == "22.04" ]] || [[ "${OS_VERSION}" == "22.10" ]]; then
          sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/' /etc/needrestart/needrestart.conf
          sudo apt -y remove needrestart
     fi

     apt update

     if [[ "${OS_VERSION}" == "11" ]]; then
          # Non-interactive apt upgrade
          sudo DEBIAN_FRONTEND=noninteractive apt-get -yq upgrade
     else
          apt upgrade -y
     fi

     echo ""
     sleep 1
}

# Run
update_os