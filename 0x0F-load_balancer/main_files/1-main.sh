#!/usr/bin/env bash
path=$(dirname "$(dirname "$0")")/transfer_file
installer=1-install_load_balancer
IP=$SERVER3LB
USER=ubuntu
path_to_ssh_key=~/.ssh/id_rsa

echo "Executing $path with arguments on server $IP"
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
    echo "file exists remotely. Executing the file...? $1"
	if [ "$1" == '-y' ]; then
		REPLY='y'
	else
		echo "INSTALL?"
		read -p "install? (y/n) " -n 1 -r
	fi
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo "INSTALLING"
		ssh -i $path_to_ssh_key $USER@$IP "./$installer; rm -f ~/$installer"
	else
		echo "file exists remotely. Not executing the file"
	fi
else
    echo "file does not exist remotely"
    ssh -i $path_to_ssh_key $USER@$IP 'ls ~/'
    exit 1
fi

if curl_output=$(curl -sI "$IP" | grep "X-Served-By"); then
	echo "X-Served-By header is present"
	if [[ $curl_output == $(curl -sI "$IP" | grep "X-Served-By") ]]; then
		echo "Not being balanced"
		exit 1
	else
		echo "Being balanced"
		exit 0
	fi
else
	echo "X-Served-By header is not present"
	exit 1
fi
