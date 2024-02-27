#!/usr/bin/env bash
# this script transfers and runs a shell script that installs nginx on a web server

path_to_install=$(dirname "$(dirname "$0")")/7-puppet_install_nginx_web_server.pp
path=$(dirname "$(dirname "$0")")/0-transfer_file
installer=7-puppet_install_nginx_web_server.pp
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
    echo "file exists remotely. Executing the file...?"
	if [ "$1" == '-y' ]; then
		REPLY='y'
	else
		read -p "install? (y/n) " -n 1 -r
	fi
	if [[ "$REPLY" =~ ^[Yy]$ ]]; then
		# check if puttet is installed
		ssh -i "$path_to_ssh_key" "$USER@$IP" "which puppet"
		if [ $? -ne 0 ]; then
			echo "puppet is not installed. Installing puppet..."
			ssh -i "$path_to_ssh_key" "$USER@$IP" "sudo apt-get update; sudo apt-get install -y puppet"
		fi

		ssh -i "$path_to_ssh_key" "$USER"@"$IP" "sudo puppet apply $installer; rm -f ~/$installer"
	else
		echo "file exists remotely. Not executing the file"
	fi
else
    echo "file does not exist remotely"
    ssh -i $path_to_ssh_key $USER@$IP 'ls ~/'
    exit 1
fi



