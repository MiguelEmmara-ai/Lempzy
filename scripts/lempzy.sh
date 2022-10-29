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
  echo "  3) SHOW CURRENT DOMAIN"
  echo "  4) SHOW CURRENT DATABASE"
  echo "  5) INSTALL RAINLOOP WEBMAIL"
  echo "  6) INSTRALL FILERUN"
  echo "  7) CHANGE PORT SSH"
  echo "  8) REFRESH SERVER"
  echo "  9) CLEAR CACHE RAM"
  echo "  10) INSTALL INVOICE NINJA (BETA)"
  echo "  11) ${red}RESTART SERVER${end}"
  echo "  ${grn}12) EXIT MENU${end}"
  echo ""
  read -p "Choose your option [1-12]: " choice

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
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/main-menu/showdomain.sh -O ~/showdomain.sh && dos2unix ~/showdomain.sh && bash ~/showdomain.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      4)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/database-menu/show-databases.sh -O ~/show-databases.sh && dos2unix ~/show-databases.sh && bash ~/show-databases.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      5)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/addons/rainloop.sh -O ~/rainloop.sh && dos2unix ~/rainloop.sh && bash ~/rainloop.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      6)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/addons/filerun.sh -O ~/filerun.sh && dos2unix ~/filerun.sh && bash ~/filerun.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      7)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/main-menu/changeportsshd.sh -O ~/changeportsshd.sh && dos2unix ~/changeportsshd.sh && bash ~/changeportsshd.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      8)
        clear
        systemctl restart php$PHP_VERSION-fpm.service
        systemctl restart nginx
        echo "${cyn}Server Refreshed!${end}"
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      9)
        clear
        echo 3 >/proc/sys/vm/drop_caches
        echo "${cyn}RAM CACHE CLEARED!${end}"
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      10)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/addons/invoiceninja.sh -O ~/invoiceninja.sh && dos2unix ~/invoiceninja.sh && bash ~/invoiceninja.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      11)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/main-menu/restartserver.sh -O ~/restartserver.sh && dos2unix ~/restartserver.sh && bash ~/restartserver.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        main_menu
        ;;

      12)
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
  echo "  ${grn}1) ADD DOMAIN"
  echo "  2) ADD DOMAIN + INSTALL WORDPRESS"
  echo "  3) ADD SUB-DOMAIN"
  echo "  4) ADD SUB-DOMAIN + INSTALL WORDPRESS"
  echo "  5) SHOW CURRENT DOMAIN"
  echo "  6) DELETE DOMAIN / SUB-DOMAIN"
  echo "  7) BACKUP WEB"
  echo "  8) BACK TO MAIN MENU <"
  echo "  9) EXIT MENU${end}"
  echo ""
  read -p "Choose your option [1-9]: " submenudomain

  while [ submenudomain != '' ]; do
    if [[ $submenudomain = "" ]]; then
      exit
    else
      case $submenudomain in

      1)
        # ADD DOMAIN
        DOMAIN1=scripts/domain-menu/domain1.sh

        if test -f "$DOMAIN1"; then
          source $DOMAIN1
          cd && cd Lempzy
        else
          echo "${red}Cannot Add Domain${end}"
          exit
        fi
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;

      2)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/domain-menu/domain2.sh -O ~/domain2.sh && dos2unix ~/domain2.sh && bash ~/domain2.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;

      3)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/domain-menu/domain3.sh -O ~/domain3.sh && dos2unix ~/domain3.sh && bash ~/domain3.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;

      4)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/domain-menu/domain4.sh -O ~/domain4.sh && dos2unix ~/domain4.sh && bash ~/domain4.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;

      5)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/main-menu/showdomain.sh -O ~/showdomain.sh && dos2unix ~/showdomain.sh && bash ~/showdomain.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;

      6)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/domain-menu/delete.sh -O ~/delete.sh && dos2unix ~/delete.sh && bash ~/delete.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;

      7)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/domain-menu/backupwebdata.sh -O ~/backupwebdata.sh && dos2unix ~/backupwebdata.sh && bash ~/backupwebdata.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu1
        ;;

      8)
        clear
        main_menu
        ;;

      9)
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
  read -p "Choose your option [1-5]: " submenudomain2

  while [ submenudomain2 != '' ]; do
    if [[ $submenudomain2 = "" ]]; then
      exit
    else
      case $submenudomain2 in

      1)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/database-menu/create-database.sh -O ~/create-database.sh && dos2unix ~/create-database.sh && bash ~/create-database.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu2
        ;;

      2)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/database-menu/delete-database.sh -O ~/delete-database.sh && dos2unix ~/delete-database.sh && bash ~/delete-database.sh
        read -p "${grn}Press [Enter] key to continue...${end}" readEnterKey
        sub_menu2
        ;;

      3)
        wget https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/scripts/database-menu/show-databases.sh -O ~/show-databases.sh && dos2unix ~/show-databases.sh && bash ~/show-databases.sh
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

clear
main_menu
