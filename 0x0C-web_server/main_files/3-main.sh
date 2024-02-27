#!/usr/bin/env bash
# this script transfers and runs a shell script that installs nginx on a web server

path_to_install=$(dirname "$(dirname "$0")")/3-redirection
path=$(dirname "$(dirname "$0")")/0-transfer_file
installer=3-redirection
IP=$SERVER
USER=ubuntu
path_to_ssh_key=~/.ssh/id_rsa

echo "Executing $path with arguments"
"$path" "$installer" "$IP" "$USER" "$path_to_ssh_key"
if [ $? -eq 0 ]; then
    echo "File transferred successfully"
else
    echo "File transfer failed"
    exit 1
fi

echo "Checking if file exists remotely"
ssh -i "$path_to_ssh_key" "$USER@$IP" "test -f ~/$installer"
if [ $? -eq 0 ]; then
    echo "file exists remotely. Executing the file..."
    ssh -i $path_to_ssh_key $USER@$IP "./$installer;"
	# rm -f ~/$installer"
else
    echo "file does not exist remotely"
    ssh -i $path_to_ssh_key $USER@$IP 'ls ~/'
    exit 1
fi

if curl -s "$IP" | grep -q "Hello World!"; then
	echo "nginx is installed and running"
else
	echo "nginx is not running"
	exit 1
fi

if curl -s "$IP/redirect_me" | grep -q "HTTP/1.1 301 Moved Permanently"; then
	echo "redirect is working"
else
	echo "redirect is not working"
	exit 1
fi

