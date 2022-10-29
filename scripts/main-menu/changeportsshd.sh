#!/bin/bash

# Script author: Muhamad Miguel Emmara
# Change Port SSHD

set -e

# Colours
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# variables
userInput=$1

clear
echo "########################### SERVER CONFIGURED BY MIGUEL EMMARA ###########################"
echo "                                   ${grn}CHANGE PORT SSH${end}"
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
echo "This feature allow you to change your port ssh. After then, you will login to your server with your new port!"

echo -n "${grn}Provide your new port number (choose between 1024-65535) [eg, 58532]: ${end}"
read userInput

# Change Port
echo "Port $userInput" >> /etc/ssh/sshd_config
sed -i "s/Port .*/Port $userInput/" /etc/ssh/sshd_config
ufw allow $userInput/tcp
service ssh restart

# Success Prompt
clear
echo "Script By"
echo ""
echo "     __                                    "
echo "    / /   ___  ____ ___  ____  ____  __  __"
echo "   / /   / _ \/ __ \`__ \/ __ \/_  / / / / /"
echo "  / /___/  __/ / / / / / /_/ / / /_/ /_/ /"
echo " /_____/\___/_/ /_/ /_/ .___/ /___/\__, /"
echo "                   /_/          /____/_/"
echo ""
echo "Your Port number has been changed to ${grn}$userInput${end}"
echo "${blu}Try re-login your ssh with your new port number.${end}"
