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

# Update os
update_os() {
     echo "${grn}Starting update os ...${end}"
     echo ""
     sleep 3
     # By default this is set to "interactive" mode which causes the interruption of scripts.
     if [[ "${OS_VERSION}" == "22.04" ]] || [[ "${OS_VERSION}" == "22.10" ]]; then
          sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/' /etc/needrestart/needrestart.conf
     fi
     apt update
     apt upgrade -y
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

# Install PHP
install_php() {
     if [[ "${OS_VERSION}" == "10" ]]; then
          echo "Debian 10 PHP"

     elif [[ "${OS_VERSION}" == "11" ]]; then
          echo "${grn}Installing PHP ...${end}"
          echo ""
          sleep 3
          apt install php7.4-fpm php-mysql -y
          apt-get install php7.4 php7.4-common php7.4-gd php7.4-mysql php7.4-imap php7.4-cli php7.4-cgi php-pear mcrypt imagemagick libruby php7.4-curl php7.4-intl php7.4-pspell php7.4-sqlite3 php7.4-tidy php7.4-xmlrpc php7.4-xsl memcached php-memcache php-imagick php7.4-zip php7.4-mbstring memcached php7.4-soap php7.4-fpm php7.4-opcache php-apcu -y
          echo ""
          sleep 1

     elif [[ "${OS_VERSION}" == "18.04" ]]; then
          apt-get install software-properties-common
          add-apt-repository -y ppa:ondrej/php
          apt update
          apt install php7.3-fpm php-mysql -y
          apt install php7.3-common php7.3-zip php7.3-curl php7.3-xml php7.3-xmlrpc php7.3-json php7.3-mysql php7.3-pdo php7.3-gd php7.3-imagick php7.3-ldap php7.3-imap php7.3-mbstring php7.3-intl php7.3-cli php7.3-recode php7.3-tidy php7.3-bcmath php7.3-opcache -y
          apt-get purge php8.* -y
          apt-get autoclean
          apt-get autoremove -y
          echo ""
          sleep 1

     elif [[ "${OS_VERSION}" == "20.04" ]]; then
          echo "${grn}Installing PHP ...${end}"
          echo ""
          sleep 3
          apt install php7.4-fpm php-mysql -y
          apt-get install php7.4 php7.4-common php7.4-gd php7.4-mysql php7.4-imap php7.4-cli php7.4-cgi php-pear mcrypt imagemagick libruby php7.4-curl php7.4-intl php7.4-pspell php7.4-sqlite3 php7.4-tidy php7.4-xmlrpc php7.4-xsl memcached php-memcache php-imagick php7.4-zip php7.4-mbstring memcached php7.4-soap php7.4-fpm php7.4-opcache php-apcu -y
          echo ""
          sleep 1

     elif [[ "${OS_VERSION}" == "22.04" ]]; then
          echo "${grn}Installing PHP ...${end}"
          echo ""
          sleep 3
          apt install php8.1-fpm php-mysql -y
          apt-get install php8.1 php8.1-common php8.1-gd php8.1-mysql php8.1-imap php8.1-cli php8.1-cgi php-pear mcrypt imagemagick libruby php8.1-curl php8.1-intl php8.1-pspell php8.1-sqlite3 php8.1-tidy php8.1-xmlrpc php8.1-xsl memcached php-memcache php-imagick php8.1-zip php8.1-mbstring memcached php8.1-soap php8.1-fpm php8.1-opcache php-apcu -y
          echo ""
          sleep 1

     elif [[ "${OS_VERSION}" == "22.10" ]]; then
          echo "${grn}Installing PHP ...${end}"
          echo ""
          sleep 3
          apt install php8.1-fpm php-mysql -y
          apt-get install php8.1 php8.1-common php8.1-gd php8.1-mysql php8.1-imap php8.1-cli php8.1-cgi php-pear mcrypt imagemagick libruby php8.1-curl php8.1-intl php8.1-pspell php8.1-sqlite3 php8.1-tidy php8.1-xmlrpc php8.1-xsl memcached php-memcache php-imagick php8.1-zip php8.1-mbstring memcached php8.1-soap php8.1-fpm php8.1-opcache php-apcu -y
          echo ""
          sleep 1
     else
          echo -e "${red}Sorry, This script is designed for DEBIAN (10, 11), UBUNTU (18.04, 20.04, 22.04, 22.10)${end}"
          exit 1
     fi
}

# Install and start nginx
install_nginx() {
     echo "${grn}Installing NGINX ...${end}"
     echo ""
     sleep 3
     apt-get install nginx -y
     sudo ufw allow 'Nginx HTTP'
     systemctl start nginx
     echo ""
     sleep 1
}

# Configure PHP FPM
configure_php_fpm() {
     echo "${grn}Configure PHP FPM ...${end}"
     echo ""
     sleep 3

     # Get PHP Installed Version
     PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")

     if [[ "${PHP_VERSION}" == "7.2" ]]; then
          sed -i "s/max_execution_time = 30/max_execution_time = 360/g" /etc/php/7.2/fpm/php.ini
          sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/" /etc/php/7.2/fpm/php.ini
          sed -i "s/display_errors = .*/display_errors = Off/" /etc/php/7.2/fpm/php.ini
          sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/fpm/php.ini
          sed -i "s/upload_max_filesize = .*/upload_max_filesize = 256M/" /etc/php/7.2/fpm/php.ini
          sed -i "s/post_max_size = .*/post_max_size = 256M/" /etc/php/7.2/fpm/php.ini
          echo ""
          sleep 1

     elif [[ "${PHP_VERSION}" == "7.3" ]]; then
          sed -i "s/max_execution_time = 30/max_execution_time = 360/g" /etc/php/7.3/fpm/php.ini
          sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/" /etc/php/7.3/fpm/php.ini
          sed -i "s/display_errors = .*/display_errors = Off/" /etc/php/7.3/fpm/php.ini
          sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.3/fpm/php.ini
          sed -i "s/upload_max_filesize = .*/upload_max_filesize = 256M/" /etc/php/7.3/fpm/php.ini
          sed -i "s/post_max_size = .*/post_max_size = 256M/" /etc/php/7.3/fpm/php.ini
          echo ""
          sleep 1

     elif [[ "${PHP_VERSION}" == "7.4" ]]; then
          sed -i "s/max_execution_time = 30/max_execution_time = 360/g" /etc/php/7.4/fpm/php.ini
          sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/" /etc/php/7.4/fpm/php.ini
          sed -i "s/display_errors = .*/display_errors = Off/" /etc/php/7.4/fpm/php.ini
          sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.4/fpm/php.ini
          sed -i "s/upload_max_filesize = .*/upload_max_filesize = 256M/" /etc/php/7.4/fpm/php.ini
          sed -i "s/post_max_size = .*/post_max_size = 256M/" /etc/php/7.4/fpm/php.ini
          echo ""
          sleep 1

     elif [[ "${PHP_VERSION}" == "8.1" ]]; then
          sed -i "s/max_execution_time = 30/max_execution_time = 360/g" /etc/php/8.1/fpm/php.ini
          sed -i "s/error_reporting = .*/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/" /etc/php/8.1/fpm/php.ini
          sed -i "s/display_errors = .*/display_errors = Off/" /etc/php/8.1/fpm/php.ini
          sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/8.1/fpm/php.ini
          sed -i "s/upload_max_filesize = .*/upload_max_filesize = 256M/" /etc/php/8.1/fpm/php.ini
          sed -i "s/post_max_size = .*/post_max_size = 256M/" /etc/php/8.1/fpm/php.ini
          echo ""
          sleep 1
     else
          echo -e "${red}Sorry, This script is designed for DEBIAN (10, 11), UBUNTU (18.04, 20.04, 22.04, 22.10)${end}"
          exit 1
     fi
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

     # Get PHP Installed Version
     PHP_MAJOR_VERSION=$(php -r "echo PHP_MAJOR_VERSION;")

     # Get PHP Installed Version
     PHP_MAJOR_VERSION=$(php -r "echo PHP_MAJOR_VERSION;")

     if [[ "${OS_VERSION}" != "22.04" ]] && [[ "${OS_VERSION}" != "22.10" ]]; then
          if [[ "${PHP_MAJOR_VERSION}" == "8" ]]; then
               apt-get purge php8.* -y
               apt-get autoclean
               apt-get autoremove -y
          fi
     fi

     echo ""
     sleep 1
}

# Restart Services
restart_services() {
     # Get PHP Installed Version
     PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")

     if [[ "${PHP_VERSION}" == "7.2" ]]; then
          systemctl restart php7.2-fpm.service

     elif [[ "${PHP_VERSION}" == "7.3" ]]; then
          systemctl restart php7.3-fpm.service

     elif [[ "${PHP_VERSION}" == "7.4" ]]; then
          systemctl restart php7.4-fpm.service

     elif [[ "${PHP_VERSION}" == "8.1" ]]; then
          systemctl restart php8.1-fpm.service
     else
          echo -e "${red}Sorry, This script is designed for DEBIAN (10, 11), UBUNTU (18.04, 20.04, 22.04, 22.10)${end}"
          exit 1
     fi

     systemctl restart nginx
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

     restart_services

     echo ""
     sleep 1
}

# Install Mcrypt
install_mcrpyt() {
     echo "${grn}Installing Mcrypt ...${end}"
     echo ""
     sleep 3

     # PHP Modules folder
     MODULES=$(php -i | grep ^extension_dir | awk '{print $NF}')

     # Get PHP Installed Version
     PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")

     if [[ "${PHP_VERSION}" == "7.2" ]]; then
          systemctl restart php7.2-fpm.service

     elif [[ "${PHP_VERSION}" == "7.3" ]]; then
          apt-get install php7.3-dev -y
          apt-get -y install gcc make autoconf libc-dev pkg-config
          apt-get -y install libmcrypt-dev
          yes | pecl install mcrypt-1.0.3
          echo "extension=$MODULES/mcrypt.so" >>/etc/php/7.3/fpm/php.ini
          echo "extension=$MODULES/mcrypt.so" >>/etc/php/7.3/cli/php.ini
          restart_services
          echo ""
          sleep 1

     elif [[ "${PHP_VERSION}" == "7.4" ]]; then
          apt-get install php-dev libmcrypt-dev php-pear -y
          pecl channel-update pecl.php.net
          yes | pecl install channel://pecl.php.net/mcrypt-1.0.4
          echo "extension=$MODULES/mcrypt.so" >>/etc/php/7.4/fpm/php.ini
          echo "extension=$MODULES/mcrypt.so" >>/etc/php/7.4/cli/php.ini
          restart_services
          echo ""
          sleep 1

     elif [[ "${PHP_VERSION}" == "8.1" ]]; then
          apt-get install php-dev libmcrypt-dev php-pear -y
          pecl channel-update pecl.php.net
          yes | pecl install channel://pecl.php.net/mcrypt-1.0.5
          echo "extension=$MODULES/mcrypt.so" >>/etc/php/8.1/fpm/php.ini
          echo "extension=$MODULES/mcrypt.so" >>/etc/php/8.1/cli/php.ini
          restart_services
          echo ""
          sleep 1
     else
          echo -e "${red}Sorry, This script is designed for DEBIAN (10, 11), UBUNTU (18.04, 20.04, 22.04, 22.10)${end}"
          exit 1
     fi
}

# Install HTOP
install_htop() {
     echo "${grn}Installing HTOP ...${end}"
     echo ""
     sleep 3
     apt-get install htop -y
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
     sudo ufw allow 'Nginx Full'
     sudo ufw delete allow 'Nginx HTTP'
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
     wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/nginx.conf -O nginx.conf
     dos2unix /etc/nginx/nginx.conf
     cd
     echo ""
     sleep 1
}

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

# Run Installations
cd
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
restart_services
change_login_greetings

# Menu Script
cd
wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/lempzy.sh -O lempzy.sh
dos2unix lempzy.sh
chmod +x lempzy.sh

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
