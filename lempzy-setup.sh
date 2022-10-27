#!/bin/bash

# Script author: Muhamad Miguel Emmara
# Script site: https://www.miguelemmara.me
# Lempzy - One Click LEMP Server Stack Installation Script
#--------------------------------------------------
# Installation List:
# Nginx
# MariaDB (We will use MariaDB as our database)
# PHP 7
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

## To Ensure Correct Os Supported Version Is Use
OS_VERSION=$(lsb_release -rs)
if [[ "${OS_VERSION}" != "10" ]] && [[ "${OS_VERSION}" != "11" ]] && [[ "${OS_VERSION}" != "18.04" ]] && [[ "${OS_VERSION}" != "20.04" ]] && [[ "${OS_VERSION}" != "22.04" ]] && [[ "${OS_VERSION}" != "22.10" ]]; then
    echo -e "${red}Sorry, This script is designed for DEBIAN (10, 11), UBUNTU (18.04, 20.04, 22.04, 22.10)${end}"
    exit 1
fi

## To ensure script run as root
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

# Function update os
update_os() {
    echo "${grn}Starting update os ...${end}"
    echo ""
    sleep 3
    apt update
    echo ""
    sleep 1
}

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
    ufw allow OpenSSH
    echo ""
    sleep 1
}

# Enabling UFW
enabling_ufw() {
    echo "${grn}Enabling UFW ...${end}"
    echo ""
    sleep 3
    yes | ufw enable
    echo "y"
    echo ""
    sleep 1
}

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

#TODO Support all os
#Install PHP
install_php() {
    echo "${grn}Installing PHP 7.4 ...${end}"
    echo ""
    sleep 3
    apt install php7.4-fpm php-mysql -y
    apt-get install php7.4 php7.4-common php7.4-gd php7.4-mysql php7.4-imap php7.4-cli php7.4-cgi php-pear mcrypt imagemagick libruby php7.4-curl php7.4-intl php7.4-pspell php7.4-sqlite3 php7.4-tidy php7.4-xmlrpc php7.4-xsl memcached php-memcache php-imagick php7.4-zip php7.4-mbstring memcached php7.4-soap php7.4-fpm php7.4-opcache php-apcu -y
    echo ""
    sleep 1
}

# Install and start nginx
install_nginx() {
    echo "${grn}Installing NGINX ...${end}"
    echo ""
    sleep 3
    apt-get install nginx -y
    ufw allow 'Nginx HTTP'
    systemctl start nginx
    echo ""
    sleep 1
}

#TODO Support all os
# Configure PHP FPM
configure_php_fpm() {
    echo "${grn}Configuring PHP FPM ...${end}"
    echo ""
    sleep 3
    sed -i "s/max_execution_time = 30/max_execution_time = 360/g" /etc/php/7.4/fpm/php.ini
    sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/" /etc/php/7.4/fpm/php.ini
    sed -i "s/display_errors = .*/display_errors = Off/" /etc/php/7.4/fpm/php.ini
    sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.4/fpm/php.ini
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 256M/" /etc/php/7.4/fpm/php.ini
    sed -i "s/post_max_size = .*/post_max_size = 256M/" /etc/php/7.4/fpm/php.ini
    echo ""
    sleep 1
}

# Install Memcached
install_memcached() {
    echo "${grn}Installing Memcached ...${end}"
    echo ""
    sleep 3
    apt install memcached -y
    echo ""
    sleep 1
    apt install php-memcached -y
    sleep 1
    echo ""
    sleep 1
}

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
    echo "zend_extension=$MODULES/ioncube_loader_lin_${PHP_VERSION}.so" >>/etc/php/7.4/fpm/php.ini
    echo "zend_extension=$MODULES/ioncube_loader_lin_${PHP_VERSION}.so" >>/etc/php/7.4/cli/php.ini

    rm -rf ioncube

    #TODO Support all os
    systemctl restart php7.4-fpm.service
    systemctl restart nginx

    echo ""
    sleep 1
}

# Install Mcrypt
install_mcrpyt() {
    echo "${grn}Installing Mcrypt ...${end}"
    echo ""
    sleep 3
    apt-get install php-dev libmcrypt-dev php-pear -y
    pecl channel-update pecl.php.net
    yes | pecl install channel://pecl.php.net/mcrypt-1.0.4
    echo "extension=$MODULES/mcrypt.so" >>/etc/php/7.4/fpm/php.ini
    echo "extension=$MODULES/mcrypt.so" >>/etc/php/7.4/cli/php.ini
    systemctl restart php7.4-fpm.service
    systemctl restart nginx
    echo ""
    sleep 1
}

# Install HTOP
install_htop() {
    echo "${grn}Installing HTOP ...${end}"
    echo ""
    sleep 3
    apt-get install htop
    echo ""
    sleep 1
}

# Install netstat
install_netstat() {
    echo "${grn}Installing netstat ...${end}"
    echo ""
    sleep 3
    apt install net-tools -y
    netstat -ptuln
    echo ""
    sleep 1
}

# Install OPENSSL
install_openssl() {
    echo "${grn}Installing OPENSSL${end}"
    echo ""
    sleep 3
    cd /etc/ssl/certs/
    openssl dhparam -dsaparam -out dhparam.pem 4096
    cd
    ufw allow 'Nginx Full'
    ufw delete allow 'Nginx HTTP'
    echo ""
    sleep 1
}

# Install AB BENCHMARKING TOOL
install_ab() {
    echo "${grn}Installing AB BENCHMARKING TOOL ...${end}"
    echo ""
    sleep 3
    apt-get install apache2-utils -y
    echo ""
    sleep 1
}

# Install ZIP AND UNZIP
install_zips() {
    echo "${grn}Installing ZIP AND UNZIP ...${end}"
    echo ""
    sleep 3
    apt-get install unzip
    apt-get install zip
    echo ""
    sleep 1
}

# Install FFMPEG and IMAGEMAGICK
install_ffmpeg() {
    echo "${grn}Installing FFMPEG AND IMAGEMAGICK...${end}"
    echo ""
    sleep 3
    apt-get install imagemagick -y
    apt-get install ffmpeg -y
    echo ""
    sleep 1
}

# Config to make PHP-FPM working with Nginx
configuring_php_fpm_nginx() {
    echo "${grn}Configuring to make PHP-FPM working with Nginx ...${end}"
    echo ""
    sleep 3
    rm -rf /etc/nginx/nginx.conf
    cd /etc/nginx/
    wget https://raw.githubusercontent.com/MiguelEmmara-ai/LempStackUbuntu20.04/development/scripts/nginx.conf -O nginx.conf
    dos2unix /etc/nginx/nginx.conf
    cd
    echo ""
    sleep 1
}

# PHP POOL SETTING
php_pool_setting() {
    echo "${grn}Setting Up PHP Pool ...${end}"
    echo ""
    sleep 3
    php7_dotdeb="https://raw.githubusercontent.com/MiguelEmmara-ai/LempStackUbuntu20.04/development/scripts/php7dotdeb"
    wget -q $php7_dotdeb -O /etc/php/7.4/fpm/pool.d/$domain.conf
    sed -i "s/domain.com/$domain/g" /etc/php/7.4/fpm/pool.d/$domain.conf
    echo "" >>/etc/php/7.4/fpm/pool.d/$domain.conf
    dos2unix /etc/php/7.4/fpm/pool.d/$domain.conf
    service php7.4-fpm reload
    echo ""
    sleep 1
}

# Restart nginx and php-fpm
restart_nginx_php() {
    echo "${grn}Restart Nginx & PHP-FPM ...${end}"
    echo ""
    sleep 1
    systemctl restart nginx
    #TODO Support all os
    systemctl restart php7.4-fpm.service
    echo ""
    sleep 1
}

# Change Login Greeting
change_login_greetings() {
    echo "${grn}Change Login Greeting ...${end}"
    echo ""
    sleep 3

cat > .bashrc << EOF
echo "########################### SERVER CONFIGURED BY Lempzy ###########################"
echo " ######################## FULL INSTRUCTIONS GO TO MIGUELEMMARA.ME ####################### "
echo ""
echo " __  __ _                  _   ______"
echo "|  \/  (_)                | | |  ____|                                    "
echo "| \  / |_  __ _ _   _  ___| | | |__   _ __ ___  _ __ ___   __ _ _ __ __ _ "
echo "| |\/| | |/ _  | | | |/ _ \ | |  __| | '_   _ \| '_   _ \ / _  | '__/ _  |"
echo "| |  | | | (_| | |_| |  __/ | | |____| | | | | | | | | | | (_| | | | (_| |"
echo "|_|  |_|_|\__, |\__,_|\___|_| |______|_| |_| |_|_| |_| |_|\__,_|_|  \__,_|"
echo "           __/ |"
echo "          |___/"
echo ""
./menu.sh
EOF

    echo ""
    sleep 1
}

# Run functions
update_os
install_ufw_firewall
allow_openssh_ufw
enabling_ufw
install_mariadb
install_php
install_nginx
configure_php_fpm
install_memcached
install_ioncube
install_mcrpyt
install_htop
install_netstat
install_openssl
install_ab
install_zips
install_ffmpeg
configuring_php_fpm_nginx
php_pool_setting
restart_nginx_php
change_login_greetings

# Menu Script
cd
wget https://raw.githubusercontent.com/MiguelEmmara-ai/LempStackUbuntu20.04/development/scripts/menu.sh -O menu.sh
dos2unix menu.sh
chmod +x menu.sh

# Success Prompt
clear
echo "Lemzpy - LEMP Auto Installer BY Miguel Emmara $(date)"
echo "*******************************************************************************************"
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
echo "********************* OPEN MENU BY TYPING ${grn}./lempzy.sh${end} ******************************"
echo ""

rm -f /root/lempzy-setup.sh
exit
