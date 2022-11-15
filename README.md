<p align="center"><a href="[https://miguelemmara.me/](https://github.com/MiguelEmmara-ai/Lempzy)" target="_blank"><img src="https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/development/logo/lemp.jpeg" width="400" alt="Lemp Logo"></a><br>Image Source: Techkylabs</p>

# Lempzy
Lempzy is a Simple All In One script to install LEMP Server Stack (Linux eNginx Mysql PHP) with just a single command line.

# Menu
![Lempzy](https://raw.githubusercontent.com/MiguelEmmara-ai/Lempzy/v1.2/screenshots/Lempzy-main-menu.PNG "Main Menu")

## Features
Lempzy will also optimize the configuration within The LEMP Stack.
* Nginx - A high performance web server and a reverse proxy server.
  * Fast FastCGI Caching
  * Custom Optimize Nginx Config
* PHP - General-purpose scripting language that can be used to develop dynamic and interactive websites.
  * php-fpm
  * php-mysql
  * Custom Optimize PHP Config
* MariaDB - When it comes to performing queries or replication, MariaDB is faster than MySQL.
* OpenSSL - Applications that secure communications over computer networks against eavesdropping or need to identify the party at the other end.
  * Free SSL certificates from Let's Encrypt
* Interactive menu for convenient

## Installation List
Here all the list that the script will install
<br>
[Full List](https://github.com/MiguelEmmara-ai/Lempzy/blob/v1.2/full-list.txt)

## Prerequisites
What things you need to make sure before proceed.
* **OS: DEBIAN (10, 11), UBUNTU (18.04, 20.04, 22.04, 22.10)**
* **YOU SHOULD BE LOGIN AS ROOT**
* **FRESH CLEAN SERVER**

## How to Install Lempzy
To Install Lempzy, all you need to do is to run a single command line and it will install everything.

```
sudo apt-get install git -y && apt-get install dos2unix -y && git clone --branch main https://github.com/MiguelEmmara-ai/Lempzy.git && cd Lempzy && chmod +x lempzy-setup.sh && sudo ./lempzy-setup.sh

```

## Getting Started
Congratulations, you now have installed Lempzy!

Once everything is set up, run this command below in /root directory to open the Menu Options
```
cd
./lempzy.sh
```

## Authors
* **Muhamad Miguel Emmara** - *Lempzy*

## Current Release
*Lempzy - V1.3*

## License
Copyright 2022. Code released under the MIT license.
