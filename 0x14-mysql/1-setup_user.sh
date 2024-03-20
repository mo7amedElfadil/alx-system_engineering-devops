#!/usr/bin/env bash
# this script sets up a new user for mysql

USER="holberton_user"
HOST="localhost"
PASSWORD="projectcorrection280hbtn"

sudo mysql -u root -e "CREATE USER IF NOT EXISTS '${USER}'@'${HOST}' IDENTIFIED BY '${PASSWORD}';"
sudo mysql -u root -e "GRANT REPLICATION CLIENT ON *.* TO '${USER}'@'${HOST}';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"
