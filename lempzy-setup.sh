#!/bin/bash

# Script author: Muhamad Miguel Emmara
# Script site: https://www.miguelemmara.me
# Lempzy - One Click LEMP Server Stack Installation Script
#--------------------------------------------------
# Installation List:
# Nginx
# MariaDB (We will use MariaDB as our database)
# PHP
# UFW Firewall
# Memcached
# FASTCGI_CACHE
# IONCUBE
# MCRYPT
# HTOP
# NETSTAT
# OPEN SSL
# AB BENCHMARKING TOOL
# ZIP AND UNZIP
# FFMPEG AND IMAGEMAGICK
#--------------------------------------------------

set -e

# Colours
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# To Ensure Correct Os Supported Version Is Use
OS_VERSION=$(lsb_release -rs)
if [[ "${OS_VERSION}" != "10" ]] && [[ "${OS_VERSION}" != "11" ]] && [[ "${OS_VERSION}" != "18.04" ]] && [[ "${OS_VERSION}" != "20.04" ]] && [[ "${OS_VERSION}" != "22.04" ]] && [[ "${OS_VERSION}" != "22.10" ]]; then
     echo -e "${red}Sorry, This script is designed for DEBIAN (10, 11), UBUNTU (18.04, 20.04, 22.04, 22.10)${end}"
     exit 1
fi

# To ensure script run as root
if [ "$EUID" -ne 0 ]; then
     echo "${red}Please run this script as root user${end}"
     exit 1
fi

### Greetings
clear
echo ""
echo "******************************************************************************************"
echo " *   *    *****     ***     *   *    *****    *        *****    *****     ***     *   * "
echo " *   *      *      *   *    *   *    *        *          *      *        *   *    *   * "
echo " ** **      *      *        *   *    *        *          *      *        *        *   * "
echo " * * *      *      * ***    *   *    ****     *          *      ****     *        ***** "
echo " *   *      *      *   *    *   *    *        *          *      *        *        *   * "
echo " *   *      *      *   *    *   *    *        *          *      *        *   *    *   * "
echo " *   *    *****     ***      ***     *****    *****      *      *****     ***     *   * "
echo "******************************************************************************************"
echo ""

# Update os
UPDATE_OS=scripts/install/update_os.sh

if test -f "$UPDATE_OS"; then
     source $UPDATE_OS
else
     echo "Cannot Update OS"
     exit
fi

# Installing UFW Firewall
INSTALL_UFW_FIREWALL=scripts/install/install_firewall.sh

if test -f "$INSTALL_UFW_FIREWALL"; then
     source $INSTALL_UFW_FIREWALL
else
     echo "${red}Cannot Install UFW Firewall${end}"
     exit
fi

# Install MariaDB
INSTALL_MARIADB=scripts/install/install_mariadb.sh

if test -f "$INSTALL_MARIADB"; then
     source $INSTALL_MARIADB
else
     echo "${red}Cannot Install MariaDB${end}"
     exit
fi

# Install PHP And Configure PHP
INSTALL_PHP=scripts/install/install_php.sh

if test -f "$INSTALL_PHP"; then
     source $INSTALL_PHP
else
     echo "${red}Cannot Install PHP${end}"
     exit
fi

# Install, Start, And Configure nginx
INSTALL_NGINX=scripts/install/install_nginx.sh

if test -f "$INSTALL_NGINX"; then
     source $INSTALL_NGINX
else
     echo "${red}Cannot Install Nginx${end}"
     exit
fi

# Install Memcached
INSTALL_MEMCACHED=scripts/install/install_memcached.sh

if test -f "$INSTALL_MEMCACHED"; then
     source $INSTALL_MEMCACHED
else
     echo "${red}Cannot Install Memcached${end}"
     exit
fi

# Install Ioncube
INSTALL_IONCUBE=scripts/install/install_ioncube.sh

if test -f "$INSTALL_IONCUBE"; then
     source $INSTALL_IONCUBE
else
     echo "${red}Cannot Install Ioncube${end}"
     exit
fi

# Install Mcrypt
INSTALL_MCRPYT=scripts/install/install_mcrpyt.sh

if test -f "$INSTALL_MCRPYT"; then
     source $INSTALL_MCRPYT
else
     echo "${red}Cannot Install Mcrypt${end}"
     exit
fi

# Install HTOP
INSTALL_HTOP=scripts/install/install_htop.sh

if test -f "$INSTALL_HTOP"; then
     source $INSTALL_HTOP
else
     echo "${red}Cannot Install HTOP${end}"
     exit
fi

# Install Netstat
INSTALL_NETSTAT=scripts/install/install_netstat.sh

if test -f "$INSTALL_NETSTAT"; then
     source $INSTALL_NETSTAT
else
     echo "${red}Cannot Install Netstat${end}"
     exit
fi

# Install OpenSSL
INSTALL_OPENSSL=scripts/install/install_openssl.sh

if test -f "$INSTALL_OPENSSL"; then
     source $INSTALL_OPENSSL
else
     echo "${red}Cannot Install OpenSSL${end}"
     exit
fi

# Install AB BENCHMARKING TOOL
INSTALL_AB=scripts/install/install_openssl.sh

if test -f "$INSTALL_AB"; then
     source $INSTALL_AB
else
     echo "${red}Cannot Install AB BENCHMARKING TOOL${end}"
     exit
fi

# Install ZIP AND UNZIP
INSTALL_ZIPS=scripts/install/install_zips.sh

if test -f "$INSTALL_ZIPS"; then
     source $INSTALL_ZIPS
else
     echo "${red}Cannot Install ZIP AND UNZIP${end}"
     exit
fi

# Install FFMPEG and IMAGEMAGICK
INSTALL_FFMPEG=scripts/install/install_ffmpeg.sh

if test -f "$INSTALL_FFMPEG"; then
     source $INSTALL_FFMPEG
else
     echo "${red}Cannot Install ZIP AND UNZIP${end}"
     exit
fi

# Change Login Greeting
change_login_greetings() {
    echo "${grn}Change Login Greeting ...${end}"
    echo ""
    sleep 3

cat > .bashrc << EOF
echo "########################### SERVER CONFIGURED BY LEMPZY ###########################"
echo " ######################## FULL INSTRUCTIONS GO TO MIGUELEMMARA.ME ####################### "
echo ""
echo "     __                                    "
echo "    / /   ___  ____ ___  ____  ____  __  __"
echo "   / /   / _ \/ __ \\\`__ \/ __ \/_  / / / / /"
echo "  / /___/  __/ / / / / / /_/ / / /_/ /_/ /"
echo " /_____/\___/_/ /_/ /_/ .___/ /___/\__, /"
echo "                   /_/          /____/_/"
echo ""
./lempzy.sh
EOF

    echo ""
    sleep 1
}

# Menu Script Permission Setting
dos2unix scripts/lempzy.sh
chmod +x scripts/lempzy.sh

# Success Prompt
clear
echo "Lemzpy - LEMP Auto Installer BY Miguel Emmara $(date)"
echo "******************************************************************************************"
echo "              *   *    *****    *         ***      ***     *   *    ***** 	"
echo "              *   *    *        *        *   *    *   *    *   *    *		"
echo "              *   *    *        *        *        *   *    ** **    *		"
echo "              *   *    ****     *        *        *   *    * * *    ****	"
echo "              * * *    *        *        *        *   *    *   *    *		"
echo "              * * *    *        *        *   *    *   *    *   *    *		"
echo "               * *     *****    *****     ***      ***     *   *    *****	"
echo ""

echo "		                  *****     ***	"
echo "			      	    *      *   *	"
echo "			      	    *      *   *	"
echo "			      	    *      *   *	"
echo "			      	    *      *   *	"
echo "			      	    *      *   *	"
echo "			      	    *       ***	"
echo ""

echo " *   *    *****     ***     *   *    *****    *        *****    *****     ***     *   * "
echo " *   *      *      *   *    *   *    *        *          *      *        *   *    *   * "
echo " ** **      *      *        *   *    *        *          *      *        *        *   * "
echo " * * *      *      * ***    *   *    ****     *          *      ****     *        ***** "
echo " *   *      *      *   *    *   *    *        *          *      *        *        *   * "
echo " *   *      *      *   *    *   *    *        *          *      *        *   *    *   * "
echo " *   *    *****     ***      ***     *****    *****      *      *****     ***     *   * "
echo "*************** OPEN MENU BY TYPING ${grn}./lempzy.sh${end} IN ROOT DIRECTORY ************************"
echo ""

exit
