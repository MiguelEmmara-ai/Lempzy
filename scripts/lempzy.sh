#!/bin/bash

# Script author: Muhamad Miguel Emmara
# Main Menu of the scripts

set -e

# Colours
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# Get PHP Installed Version
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")

main_menu() {
  NORMAL=$(echo "\033[m")
  MENU=$(echo "\033[36m")   #Blue
  NUMBER=$(echo "\033[33m") #yellow
  FGRED=$(echo "\033[41m")
  RED_TEXT=$(echo "\033[31m")
  ENTER_LINE=$(echo "\033[33m")

  clear
  # display menu
  echo "Server Name - ${grn}$(hostname)${end} - Lempzy V1.0"
  echo "-------------------------------------------------------------------------"
  echo "M A I N - M E N U"
  echo "Script By"
  echo ""
  echo "     __                                    "
  echo "    / /   ___  ____ ___  ____  ____  __  __"
  echo "   / /   / _ \/ __ \`__ \/ __ \/_  / / / / /"
  echo "  / /___/  __/ / / / / / /_/ / / /_/ /_/ /"
  echo " /_____/\___/_/ /_/ /_/ .___/ /___/\__, /"
  echo "                   /_/          /____/_/"
  echo ""
  echo "-------------------------------------------------------------------------"
  echo "Choose Your Options"
  echo ""
  echo "  ${grn}1) DOMAIN MENU >"
  echo "  2) DATABASE MENU >"
  echo "  3) ADD-ONS APPS INSTALLER MENU >"
  echo "  4) SHOW CURRENT DOMAIN"
  echo "  5) SHOW CURRENT DATABASE"
  echo "  6) CHANGE PORT SSH"
  echo "  7) REFRESH SERVER"
  echo "  8) CLEAR CACHE RAM"
  echo "  9) ${red}RESTART SERVER${end}"
  echo "  ${grn}10) EXIT MENU${end}"
  echo ""
  read -p "Choose your option [1-10]: " choice

  while [ choice != '' ]; do
    if [[ $choice = "" ]]; then
      exit
    else
      case $choice in
      1)
        clear
        # option_picked "Sub Menu 1";
        sub_menu1
        ;;

      2)
        clear
        # option_picked "Sub Menu 2";
        sub_menu2
        ;;

      3)
        clear
        # option_picked "Sub Menu 3";
        sub_menu3
        ;;


      4)
        # Show Domain
        SHOW_DOMAIN=/root/Lempzy/scripts/domain-menu/showdomain.sh

        if test -f "$SHOW_DOMAIN"; then
          source $SHOW_DOMAIN
          cd && cd Lempzy
        else
          echo "${red}Cannot View Domains${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      5)
        # Show Databases
        SHOW_DATABASES=/root/Lempzy/scripts/database-menu/show-databases.sh

        if test -f "$SHOW_DATABASES"; then
          source $SHOW_DATABASES
          cd && cd Lempzy
        else
          echo "${red}Cannot View Databases${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      6)
        # Change Port SSHD
        CHANGE_PORT_SSHD=/root/Lempzy/scripts/main-menu/changeportsshd.sh

        if test -f "$CHANGE_PORT_SSHD"; then
          source $CHANGE_PORT_SSHD
          cd && cd Lempzy
        else
          echo "${red}Cannot Change Port${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      7)
        clear
        systemctl restart php$PHP_VERSION-fpm.service
        systemctl restart nginx
        echo "${cyn}Server Refreshed!${end}"
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      8)
        clear
        echo 3 >/proc/sys/vm/drop_caches
        echo "${cyn}RAM CACHE CLEARED!${end}"
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      9)
        # Restart Server
        RESTART_SERVER=/root/Lempzy/scripts/main-menu/restartserver.sh

        if test -f "$RESTART_SERVER"; then
          source $RESTART_SERVER
          cd && cd Lempzy
        else
          echo "${red}Cannot Restart Server${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      10)
        clear
        echo "Bye!"
        echo "You can open the Main Menu by typing ${grn}./lempzy.sh${end}"
        exit
        ;;

      *)
        echo "Error: Invalid option..."
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;
      esac
    fi
  done
}

function option_picked() {
  COLOR='\033[01;31m' # bold red
  RESET='\033[00;00m' # normal white
  MESSAGE=${@:-"${RESET}Error: No message passed"}
  echo -e "${COLOR}${MESSAGE}${RESET}"
}

sub_menu1() {
  NORMAL=$(echo "\033[m")
  MENU=$(echo "\033[36m")   #Blue
  NUMBER=$(echo "\033[33m") #yellow
  FGRED=$(echo "\033[41m")
  RED_TEXT=$(echo "\033[31m")
  ENTER_LINE=$(echo "\033[33m")

  clear
  echo "Server Name - ${grn}$(hostname)${end} - Lempzy V1.0"
  echo "-------------------------------------------------------------------------"
  echo "D O M A I N - M E N U"
  echo "Script By"
  echo ""
  echo ""
  echo "     __                                    "
  echo "    / /   ___  ____ ___  ____  ____  __  __"
  echo "   / /   / _ \/ __ \`__ \/ __ \/_  / / / / /"
  echo "  / /___/  __/ / / / / / /_/ / / /_/ /_/ /"
  echo " /_____/\___/_/ /_/ /_/ .___/ /___/\__, /"
  echo "                   /_/          /____/_/"
  echo ""
  echo "-------------------------------------------------------------------------"
  echo "Choose Your Options"
  echo ""
  echo "  ${grn}1) ADD DOMAIN / SUB-DOMAIN"
  echo "  2) ADD DOMAIN / SUB-DOMAIN + INSTALL WORDPRESS"
  echo "  3) SHOW CURRENT DOMAIN"
  echo "  4) BACKUP WEBSITE"
  echo "  5) DELETE DOMAIN / SUB-DOMAIN"
  echo "  6) BACK TO MAIN MENU <"
  echo "  7) EXIT MENU${end}"
  echo ""
  read -p "Choose your option [1-7]: " sub_menu_1

  while [ sub_menu_1 != '' ]; do
    if [[ $sub_menu_1 = "" ]]; then
      exit
    else
      case $sub_menu_1 in

      1)
        # ADD DOMAIN / SUB-DOMAIN
        DOMAIN1=/root/Lempzy/scripts/domain-menu/domain1.sh

        if test -f "$DOMAIN1"; then
          source $DOMAIN1
          cd && cd Lempzy
        else
          echo "${red}Cannot Add Domain${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;

      2)
        # ADD DOMAIN
        DOMAIN2=/root/Lempzy/scripts/domain-menu/domain2.sh

        if test -f "$DOMAIN2"; then
          source $DOMAIN2
          cd && cd Lempzy
        else
          echo "${red}Cannot Add Domain${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;

      3)
        # Show Domain
        SHOW_DOMAIN=/root/Lempzy/scripts/domain-menu/showdomain.sh

        if test -f "$SHOW_DOMAIN"; then
          source $SHOW_DOMAIN
          cd && cd Lempzy
        else
          echo "${red}Cannot View Domains${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;

      4)
        # Back Up Web Data
        BACKUP_WEB_DATA=/root/Lempzy/scripts/domain-menu/backupwebdata.sh

        if test -f "$BACKUP_WEB_DATA"; then
          source $BACKUP_WEB_DATA
          cd && cd Lempzy
        else
          echo "${red}Cannot Back Up Web Data${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;

      5)
        # DELETE DOMAIN / SUB-DOMAIN
        DELETE_DOMAIN=/root/Lempzy/scripts/domain-menu/delete.sh

        if test -f "$DELETE_DOMAIN"; then
          source $DELETE_DOMAIN
          cd && cd Lempzy
        else
          echo "${red}Cannot Delete Domains${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;

      6)
        clear
        main_menu
        ;;

      7)
        clear
        echo "Bye!"
        echo "You can open the Main Menu by typing ${grn}./lempzy.sh${end}"
        exit
        ;;

      *)
        echo "Error: Invalid option..."
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;
      esac
    fi
  done
}

sub_menu2() {
  NORMAL=$(echo "\033[m")
  MENU=$(echo "\033[36m")   #Blue
  NUMBER=$(echo "\033[33m") #yellow
  FGRED=$(echo "\033[41m")
  RED_TEXT=$(echo "\033[31m")
  ENTER_LINE=$(echo "\033[33m")

  clear
  echo "Server Name - ${grn}$(hostname)${end} - Lempzy V1.0"
  echo "-------------------------------------------------------------------------"
  echo "D A T A B A S E - M E N U"
  echo "Script By"
  echo ""
  echo ""
  echo "     __                                    "
  echo "    / /   ___  ____ ___  ____  ____  __  __"
  echo "   / /   / _ \/ __ \`__ \/ __ \/_  / / / / /"
  echo "  / /___/  __/ / / / / / /_/ / / /_/ /_/ /"
  echo " /_____/\___/_/ /_/ /_/ .___/ /___/\__, /"
  echo "                   /_/          /____/_/"
  echo ""
  echo "-------------------------------------------------------------------------"
  echo "Choose Your Options"
  echo ""
  echo "  ${grn}1) CREATE DATABASE"
  echo "  2) DELETE DATABASE"
  echo "  3) SHOW CURRENT DATABASE"
  echo "  4) BACK TO MAIN MENU <"
  echo "  5) EXIT MENU${end}"
  echo ""
  read -p "Choose your option [1-5]: " sub_menu_2

  while [ sub_menu_2 != '' ]; do
    if [[ $sub_menu_2 = "" ]]; then
      exit
    else
      case $sub_menu_2 in

      1)
        # Create Database
        CREATE_DATABASE=/root/Lempzy/scripts/database-menu/create-database.sh

        if test -f "$CREATE_DATABASE"; then
          source $CREATE_DATABASE
          cd && cd Lempzy
        else
          echo "${red}Cannot Create Database${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu2
        ;;

      2)

        # Delete Database
        DELETE_DATABASE=/root/Lempzy/scripts/database-menu/delete-database.sh

        if test -f "$DELETE_DATABASE"; then
          source $DELETE_DATABASE
          cd && cd Lempzy
        else
          echo "${red}Cannot Delete Database${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu2
        ;;

      3)
        # Show Databases
        SHOW_DATABASES=/root/Lempzy/scripts/database-menu/show-databases.sh

        if test -f "$SHOW_DATABASES"; then
          source $SHOW_DATABASES
          cd && cd Lempzy
        else
          echo "${red}Cannot View Databases${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu2
        ;;

      4)
        clear
        main_menu
        ;;

      5)
        clear
        echo "Bye!"
        echo "You can open the Main Menu by typing ${grn}./lempzy.sh${end}"
        exit
        ;;

      *)
        echo "Error: Invalid option..."
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu2
        ;;
      esac
    fi
  done
}

sub_menu3() {
  NORMAL=$(echo "\033[m")
  MENU=$(echo "\033[36m")   #Blue
  NUMBER=$(echo "\033[33m") #yellow
  FGRED=$(echo "\033[41m")
  RED_TEXT=$(echo "\033[31m")
  ENTER_LINE=$(echo "\033[33m")

  clear
  echo "Server Name - ${grn}$(hostname)${end} - Lempzy V1.0"
  echo "-------------------------------------------------------------------------"
  echo "ADD-ONS APPS INSTALLER - M E N U"
  echo "Script By"
  echo ""
  echo ""
  echo "     __                                    "
  echo "    / /   ___  ____ ___  ____  ____  __  __"
  echo "   / /   / _ \/ __ \`__ \/ __ \/_  / / / / /"
  echo "  / /___/  __/ / / / / / /_/ / / /_/ /_/ /"
  echo " /_____/\___/_/ /_/ /_/ .___/ /___/\__, /"
  echo "                   /_/          /____/_/"
  echo ""
  echo "-------------------------------------------------------------------------"
  echo "Choose Your Options"
  echo ""
  echo "  ${grn}1) INSTALL RAINLOOP"
  echo "  2) INSTALL FILERUN"
  echo "  3) INSTALL INVOICENINJA"
  echo "  4) BACK TO MAIN MENU <"
  echo "  5) EXIT MENU${end}"
  echo ""
  read -p "Choose your option [1-5]: " sub_menu_3

  while [ sub_menu_3 != '' ]; do
    if [[ $sub_menu_3 = "" ]]; then
      exit
    else
      case $sub_menu_3 in

      1)
        # Install Rainloop
        RAINLOOP=/root/Lempzy/scripts/addons/rainloop.sh

        if test -f "$RAINLOOP"; then
          source $RAINLOOP
          cd && cd Lempzy
        else
          echo "${red}Cannot Install RAINLOOP${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      2)
        # Install Filerun
        FILERUN=/root/Lempzy/scripts/addons/filerun.sh

        if test -f "$FILERUN"; then
          source $FILERUN
          cd && cd Lempzy
        else
          echo "${red}Cannot Install Filerun${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      3)
        # Install Invoiceninja
        INVOICENINJA=/root/Lempzy/scripts/addons/invoiceninja.sh

        if test -f "$INVOICENINJA"; then
          source $INVOICENINJA
          cd && cd Lempzy
        else
          echo "${red}Cannot Install Invoiceninja${end}"
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;; 

      4)
        clear
        main_menu
        ;;

      5)
        clear
        echo "Bye!"
        echo "You can open the Main Menu by typing ${grn}./lempzy.sh${end}"
        exit
        ;;

      *)
        echo "Error: Invalid option..."
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu3
        ;;
      esac
    fi
  done
}

clear
main_menu
