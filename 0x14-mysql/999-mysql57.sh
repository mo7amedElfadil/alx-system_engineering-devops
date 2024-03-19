#!/usr/bin/env bash
# sudo wget -O mysql57 https://raw.githubusercontent.com/nuuxcode/alx-system_engineering-devops/master/scripts/mysql57 && sudo chmod +x mysql57 && sudo ./mysql57

RED='\e[0;31m'
GRN='\e[0;32m'
YLW='\e[1;33m'
BLU='\e[0;34m'
WHT='\e[0m'

echo ""
echo -e "${BLU}if wanna read the guide:${WHT}"
echo -e "${BLU}https://docs.google.com/document/d/1btVRofXP75Cj90_xq2x8AmzuMPOKq6D_Dt_SCDD6GrU/${WHT}"
echo ""

echo ""
echo -e "${WHT}-------------------------------"
echo "# Remove Existing MySQL Versions"
echo -e "-------------------------------${WHT}"
echo ""

if [ -x "$(command -v mysql)" ]; then
    echo -e "${GRN}MySQL is installed, removing it...${WHT}"
    if sudo apt-get remove --purge mysql-server mysql-client mysql-common -y && sudo apt-get autoremove -y; then
        echo -e "${GRN}MySQL removed successfully.${WHT}"
    else
        echo -e "${RED}Error: MySQL removal failed.${WHT}"
    fi
else
    echo -e "${BLU}MySQL is not installed${WHT}"
fi

echo ""

echo -e "${WHT}-------------------------------"
echo "# Remove MySQL Apt Configuration"
echo -e "-------------------------------${WHT}"
echo ""

if [ -x "$(command -v mysql-apt-config)" ]; then
    echo -e "${GRN}mysql-apt-config is installed, removing it...${WHT}"
    if sudo apt-get remove --purge mysql-apt-config -y && sudo apt-get autoremove -y; then
        echo -e "${GRN}mysql-apt-config removed successfully.${WHT}"
    else
        echo -e "${RED}Error: mysql-apt-config removal failed.${WHT}"
    fi

    if sudo rm -rf /etc/apt/sources.list.d/mysql.list*; then
        echo -e "${GRN}mysql.list removed successfully.${WHT}"
    else
        echo -e "${RED}Error: mysql.list removal failed.${WHT}"
    fi
    if sudo rm -rf /var/lib/mysql-apt-config; then
        echo -e "${GRN}mysql-apt-config removed successfully.${WHT}"
    else
        echo -e "${RED}Error: mysql-apt-config removal failed.${WHT}"
    fi
    if sudo dpkg --purge mysql-apt-config; then
        echo -e "${GRN}mysql-apt-config purged successfully.${WHT}"
    else
        echo -e "${RED}Error: mysql-apt-config purge failed.${WHT}"
    fi
else
    echo -e "${BLU}mysql-apt-config is not installed${WHT}"
fi

echo ""
echo -e "${WHT}-------------------------------"
echo "# Remove MySQL Configuration Files"
echo -e "-------------------------------${WHT}"
echo ""

if [ -d "/etc/mysql" ]; then
    echo -e "${GRN}mysql directory exists, removing it...${WHT}"
    if sudo rm -rf /etc/mysql; then
        echo -e "${GRN}mysql directory removed successfully.${WHT}"
    else
        echo -e "${RED}Error: mysql directory removal failed.${WHT}"
    fi
else
    echo -e "${BLU}mysql directory does not exist${WHT}"
fi

if [ -d "/var/lib/mysql" ]; then
    echo -e "${GRN}mysql directory exists, removing it...${WHT}"
    if sudo rm -rf /var/lib/mysql; then
        echo -e "${GRN}mysql directory removed successfully.${WHT}"
    else
        echo -e "${RED}Error: mysql directory removal failed.${WHT}"
    fi
else
    echo -e "${BLU}mysql directory does not exist${WHT}"
fi

echo -e "${GRN}Done!${WHT}"

echo ""
echo -e "${WHT}-------------------------------"
echo "# Update Packages"
echo -e "-------------------------------${WHT}"
echo ""
if sudo apt update; then
    echo -e "${GRN}Packages updated successfully.${WHT}"
else
    echo -e "${RED}Error: Failed to update packages.${WHT}"
fi

echo ""
echo -e "${WHT}-------------------------------"
echo "# Clean APT Cache"
echo -e "-------------------------------${WHT}"
echo ""
if sudo apt clean; then
    echo -e "${GRN}APT cache cleaned successfully.${WHT}"
else
    echo -e "${RED}Error: Failed to clean APT cache.${WHT}"
fi
echo -e "${GRN}Done!${WHT}"

echo ""
echo -e "${WHT}-------------------------------"
echo "# Configure Any Pending Packages"
echo -e "-------------------------------${WHT}"
echo ""
if sudo dpkg --configure -a; then
    echo -e "${GRN}Pending packages configured successfully.${WHT}"
else
    echo -e "${RED}Error: Failed to configure pending packages.${WHT}"
fi
echo -e "${GRN}Done!${WHT}"

echo ""
echo -e "${WHT}-------------------------------"
echo "# Download and Install MySQL APT configuration package"
echo -e "-------------------------------${WHT}"
echo ""
if sudo wget -O mysql-apt-config_0.8.12-1_all.deb https://dev.mysql.com/get/mysql-apt-config_0.8.12-1_all.deb && \
   echo -e "${YLW}mysql-apt-config mysql-apt-config/select-server select mysql-5.7${WHT}" | sudo debconf-set-selections && \
   echo -e "${YLW}mysql-apt-config mysql-apt-config/select-server-5.7 select bionic${WHT}" | sudo debconf-set-selections && \
   sudo dpkg -i mysql-apt-config_0.8.12-1_all.deb; then
    echo -e "${GRN}MySQL APT configuration package downloaded and installed successfully.${WHT}"
else
    echo -e "${RED}Error: Failed to download and install MySQL APT configuration package.${WHT}"
fi

echo ""
echo -e "${WHT}-------------------------------"
echo "# Import the GPG key for the MySQL repository"
echo -e "-------------------------------${WHT}"
echo ""
if sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 467B942D3A79BD29 && \
   sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B7B3B788A8D3785C; then
    echo -e "${GRN}GPG key imported successfully.${WHT}"
else
    echo -e "${RED}Error: Failed to import GPG key.${WHT}"
fi

echo ""
echo -e "${WHT}-------------------------------"
echo "# Update Packages"
echo -e "-------------------------------${WHT}"
echo ""
if sudo apt update; then
    echo -e "${GRN}Packages updated successfully.${WHT}"
else
    echo -e "${RED}Error: Failed to update packages.${WHT}"
fi

echo ""
echo -e "${WHT}-------------------------------"
echo "# Display information MySQL server package"
echo -e "-------------------------------${WHT}"
echo ""
if sudo apt-cache policy mysql-server; then
    echo -e "${GRN}Information about MySQL server package displayed successfully.${WHT}"
else
    echo -e "${RED}Error: Failed to display information about MySQL server package.${WHT}"
fi

echo ""
echo -e "${WHT}-------------------------------"
echo "# Install MySQL 5.7"
echo -e "-------------------------------${WHT}"
echo ""
if sudo apt install -f mysql-client=5.7* mysql-community-server=5.7* mysql-server=5.7* -y; then
    echo -e "${GRN}MySQL 5.7 installed successfully.${WHT}"
else
    echo -e "${RED}Error: Failed to install MySQL 5.7.${WHT}"
fi

echo ""
echo -e "${WHT}-------------------------------"
echo "# Check if MySQL 5.7 installed correctly"
echo -e "-------------------------------${WHT}"
echo ""
if [ -x "$(command -v mysql)" ]; then
    echo -e "${BLU}MySQL is installed${WHT}"
    if mysql --version | grep -q "5.7"; then
        echo -e "${BLU}MySQL 5.7 is installed${WHT}"
    else
        echo -e "${RED}Error: MySQL 5.7 is not installed${WHT}"
    fi
else
    echo -e "${RED}Error: MySQL is not installed${WHT}"
fi
echo ""
