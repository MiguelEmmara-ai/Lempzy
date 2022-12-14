#!/bin/bash

# Script author: Muhamad Miguel Emmara
# Create database

# The script will fail at the first error encountered
set -e

# Colours
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

clear
echo "########################### SERVER CONFIGURED BY MIGUEL EMMARA ###########################"
echo "                                   ${grn}CREATE DATABASE${end}"
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

echo -n "Type the name for your database [eg, database_domain], followed by [ENTER]: "
read DB

#check if database is exist
DATABASE=/var/lib/mysql/$DB
if [ -e $DATABASE ]; then
    echo ""
    echo "$DB does exist in the database already, please try again"
    exit
else
    echo ""
fi

echo -n "Type the username for your database [eg, user_domain], followed by [ENTER]: "
read USR

echo ""
echo -n "Type the password for your new user [eg, password123!@#_domain], followed by [ENTER]: "
read PASS

mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE $DB;
CREATE USER '$USR'@'localhost' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON $DB.* TO '$USR'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

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
echo "MySQL user created."
echo "Database:   $DB"
echo "Username:   $USR"
echo "Password:   $PASS"
echo ""
